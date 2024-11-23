#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_FrameDelay
	<TypeDefinition>
    	--- Prototype --- 
		XPS_typ_FrameDelay : XPS_ifc_IDelay
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_typ_FrameDelay",[_numFrames*,_autoReset*,_autoStart*]]
    	---

Authors: 
	Crashdome

Description:
	Raises an event X number of frames after calling <Start>. Event is optionally repeatable.

Warning:
	When calling "Start", an "EachFrame" event handler is created which contains a ref to this hashmap object.
	It will return the event handler ID which is useful. Care should be given to not let the hashmap leave scope. 
	Once a FrameDelay object leaves scope and "Start" has been called, it will not automatically be garbage collected. 
	For this reason, one should always call "Stop" before it goes out of scope. Alternatively, the ID can be used
	with removeMissionEventHandler as a backup.

	For example, consider this:
	--- code ---
	tempVar = createhashmapobject [XPS_typ_FrameDelay,[5000]];
	_id = tempVar call ["Start"];
	tempVar = nil; // hashmap object is assumed to be orphaned but in fact is not since event handler contains a ref
	// There is now no way to "Stop" the timer
	---

	Best Practice is to force call "Stop" or "#delete" when object is finished being used but state is unknown. This will forcibly 
	remove the event handler.
	--- code ---
	tempVar = createhashmapobject [XPS_typ_FrameDelay,[5000]];
	_id = tempVar call ["Start"];

	// Code which may or may not "Stop" the timer

	tempVar call ["#delete"]; // forces clean up when state is unknown
	tempVar = nil; // hashmap object is now orphaned and will be removed from memory
	---

	Alternatively cache the string representation of the var name (either global or local scope) with handler ID 
	to post-check and perform cleanup. A crude example of this is below.
	--- code ---
	myTimerHandles = []
	tempVar = createhashmapobject [XPS_typ_FrameDelay,[5000]];
	_id = tempVar call ["Start"];
	myTimerHandles pushback [_id,"tempVar"];
	tempVar = nil; // hashmap object still exists and is running
	 
	 // a monitor loop in some other function/type
	 {
	 	// checks if var is nil and removes eventhandler thus fully orphaning the object
		_x params ["_id","_varname"];
		if (isNil _varName) then {removeMissionEventHandler ["EachFrame",_id]};
	 } foreach myTimerHandles
	---

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_FrameDelay"],
	/*-----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create",[_numFrames*,_autoReset*,_autoStart*]]
    	---
    
    Optionals: 
		_numFrames* - <Number> - (Optional - Default : 1) - Number of frames that must pass before Event is triggered
    	_autoReset* - <Boolean> - (Optional - Default : False) - Once an event has elapsed, it will reset and start again.
    	_autoStart* - <Boolean> - (Optional - Default : False) - Will Start automatically when created.

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_numFrames",1,[0]],["_autoReset",false,[true]],["_autoStart",false,[true]]];

        _self set ["Delay",_numFrames];
        _self set ["AutoReset",_autoReset];
        _self set ["_onElapsed",createHashmapObject [XPS_typ_Event]];
        _self set ["Elapsed",createHashmapObject [XPS_typ_EventHandler,[_self get "_onElapsed"]]];

        if (_autoStart) then {_self call ["Start"]};
	}],
	
	/*-----------------------------------------------------------------------------
	Constructor: #delete
    
    	--- Prototype --- 
    	call ["#delete"]
    	---
    
    Description:
		Removes all object references from this <hashmapobject>

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#delete", {
		_self call ["Stop"];
		true;
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_typ_FrameDelay"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_ifc_IDelay>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IDelay"]],
    ["_counter",0],
    ["_handle",nil],
    ["_onElapsed",nil],
	/*----------------------------------------------------------------------------
	Property: AutoReset
    
    	--- Prototype --- 
    	get "AutoReset"
    	---
    
    Returns: 
		<Boolean> - True if it should repeat until manually stopped.
	-----------------------------------------------------------------------------*/
    ["AutoReset",false],
	/*----------------------------------------------------------------------------
	Property: Delay
    
    	--- Prototype --- 
    	get "Delay"
    	---
    
    Returns: 
		<Number> - Number of Frames before <Elapsed> is invoked
	-----------------------------------------------------------------------------*/
    ["Delay",nil],
    /*----------------------------------------------------------------------------
    Method: Start
    
        --- Prototype --- 
        call ["Start"]
        ---

        <XPS_ifc_IDelay>
    
    Parameters: 
		none
		
	Returns:
		<Number> - the "EachFrame" missionEventHandler ID
    ----------------------------------------------------------------------------*/
    ["Start",compileFinal {
		private _hndl = _self get "_handle";
		if (isNil "_handle") then {
            _hndl = addMissionEventHandler ["EachFrame",{
                _thisArgs params ["_obj","_numFrames"];
                private _count = _obj get "_counter";
                _count = _count + 1;
                _obj set ["_counter",_count];
                if (_numFrames <= _count) then {
                    _obj get "_onElapsed" call ["Invoke",[_obj,[_count]]];
                    if (_obj get "AutoReset") then {
                        _obj call ["Reset"];
                    } else {
                        _obj call ["Stop"];
                    };
                };
            },[_self,_self get "Delay"]];
            _self set ["_handle",_hndl];
        };
		_self get ["_handle"];
    }],
    /*----------------------------------------------------------------------------
    Method: Stop
    
        --- Prototype --- 
        call ["Stop"]
        ---

        <XPS_ifc_IDelay>
    
    Parameters: 
		none
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
    ["Stop", compileFinal {
		private _hndl = _self get "_handle";
		if !(isNil "_hndl") then {
			removeMissionEventHandler ["EachFrame",_hndl];
			_self set ["_handle",nil];
		};
        _self call ["Reset"];
    }],
    /*----------------------------------------------------------------------------
    Method: Reset
    
        --- Prototype --- 
        call ["Reset"]
        ---

        <XPS_ifc_IDelay>
    
    Parameters: 
		none
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
    ["Reset", compileFinal {
        _self set ["_counter",0];
    }],
    /*----------------------------------------------------------------------------
    EventHandler: Elapsed
    
        --- Prototype --- 
        get "Elapsed"
        ---

        <XPS_ifc_IDelay>

    Returns:
        <XPS_typ_EventHandler>

    Signature: 
        [_sender, [_count] ]

        _sender - <XPS_typ_FrameDelay> - this object
        _count - <Number> - the number of delayed frames

    ----------------------------------------------------------------------------*/
    ["Elapsed",nil]
]