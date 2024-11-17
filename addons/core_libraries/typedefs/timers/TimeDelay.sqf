#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_TimeDelay
	<TypeDefinition>
    	--- Prototype --- 
		XPS_typ_TimeDelay : XPS_ifc_IDelay
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_typ_TimeDelay",[_numMillisecs*,_autoReset*,_autoStart*]]
    	---

Authors: 
	Crashdome

Description:
	Raises an event X number of milliseconds after calling <Start>. Event is optionally repeatable.

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_TimeDelay"],
	/*-----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create",[_numMillisecs*,_autoReset*,_autoStart*]]
    	---
    
    Optionals: 
		_numMillisecs* - <Number> - (Optional - Default : 1000) - Number of milliseconds that must pass before Event is triggered
    	_autoReset* - <Boolean> - (Optional - Default : False) - Once an event has elapsed, it will reset and start again.
    	_autoStart* - <Boolean> - (Optional - Default : False) - Will Start automatically when created.

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_numMillisecs",1000,[0]],["_autoReset",false,[true]],["_autoStart",false,[true]]];

        _self set ["Delay",_numMillisecs];
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
        player sideChat "TimeDelay Deleted";
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_typ_TimeDelay"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_ifc_IDelay>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IDelay"]],
	["_lastTickTime",0],
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
		Nothing
    ----------------------------------------------------------------------------*/
    ["Start",compileFinal {
		private _hndl = _self get "_handle";
		_self set ["_lastTickTime",diag_TickTime];
		if (isNil "_handle") then {
            _hndl = addMissionEventHandler ["EachFrame",{
                _thisArgs params ["_obj","_numMillisecs"];
                private _count = _obj get "_counter";

				private _msDiff = (diag_TickTime - (_obj get "_lastTickTime"))*1000;
                _count = _count + _msDiff;
                
				_obj set ["_counter",_count];
				_obj set ["_lastTickTime",diag_TickTime];
                
				if (_numMillisecs < _count) then {
                    _obj get "_onElapsed" call ["Invoke",[_obj,[_count]]];
                    if (_obj get "AutoReset") then {
                        _obj call ["Reset"];
                    } else {
                        _obj call ["Stop"];
                    };
                };
            },[_self,_self get "Delay"]];
            _self set ["_handle",_hndl];
        }
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
        _self set ["_lastTickTime",diag_TickTime];
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

        _sender - <XPS_typ_TimeDelay> - this object
        _count - <Number> - the number of delayed frames

    ----------------------------------------------------------------------------*/
    ["Elapsed",nil]
]