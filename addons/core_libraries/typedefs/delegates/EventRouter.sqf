#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventRouter
	<TypeDefinition>
        --- prototype
        XPS_typ_EventRouter : XPS_ifc_IEventRouter, XPS_ifc_IEventHandler
        ---
        --- prototype
        createhashmapobject [XPS_typ_EventRouter]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which creates a map of <XPS_ifc_IDelegates> Listens and/or Invokes
	through the <RouteEvent> method any incoming events. <filter> method provides a way to
	control if one or more mapped <XPS_typ_Delegates> should receive the event.

	The signature of the Invoke method is set as [sender: <HashmapObject> , args: <Array>]

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_EventRouter"],


    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",_delegateType]
        ---
    
	Parameters: 
		_delegateType - (optional - Default: <XPS_typ_Delegate>) - a type definition implementing the <XPS_ifc_IDelegate> interface.
	
    Return:
        <True>

	Throws:
		<XPS_typ_InvalidArgumentException> - when parameter does not implement the XPS_ifc_IDelegate interface.
    ----------------------------------------------------------------------------*/
	["#create",{
		
        params [["_filter",nil,[{}]],["_delegateType",XPS_typ_Delegate,[createhashmap]]];
		if !(CHECK_IFC1(_delegateType,XPS_ifc_IDelegate)) exitwith {
			throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"#create","Delegate Type Parameter was Invalid type",_this]];
		};

        if !(isNil _filter) then {_self set ["filter",compileFinal _filter]};
		_self set ["_delegateType",_this];
		_self set ["_delegates",createhashmap];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_EventRouter"
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IEventRouter>
	----------------------------------------------------------------------------*/
	["_delegates", createhashmap],
	["_delegateType",nil],
    /*----------------------------------------------------------------------------
    Protected: filter
    
    	--- Prototype --- 
    	call ["filter", [ _sender, _args]]
    	---
    
	This method should be overridden. Must Return below parameters.

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_args - <Array> - the arguments sent by the event 

	Returns:
		_key - <HashmapKey> - the key which dictates where to route to. See <XPS_typ_RoutingDelegate> for more info 
    ----------------------------------------------------------------------------*/
	["filter",{}],
    /*----------------------------------------------------------------------------
    Method: RouteEvent
    
    	--- Prototype --- 
    	call ["RouteEvent",_args]
    	---
    
	Sends received event data to filter for processing. Then pushes event args on to subscriber based on key

	Parameters:
		_args - <Array> - the arguments sent by the event 
    ----------------------------------------------------------------------------*/
	["RouteEvent",{
		private _keylist = _self call ["filter",_this];
		{
			_self get "_delegates" get _x call ["Invoke",_this];
		} foreach _keyList;
	}],
    /*----------------------------------------------------------------------------
    Method: Attach
    
        --- Prototype --- 
        call ["Attach",[_pointer,_key]]
        ---

        <XPS_ifc_IEventRouter>

		Attachs a pointer to another function/method with given key
    
    Parameters: 
        _pointer - <Array> in format [HashMapObject,"MethodName"] -OR- <Code>
		
		Example Using Code:
		--- code 
        call ["Attach",[{ hint "Hello";},"key""]]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Attach",[[_hashmapobject, "MyMethodName"],"key"]]
		---
		
	Returns:
		<True> - if attached

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
    ----------------------------------------------------------------------------*/
	["Attach",{
		params ["_pointer","_key"];
		private _dlgt = createhashmapobject [_self get "_delegateType"];
		_dlgt call ["Attach",_pointer];
		_self get "_delegates" set [_key, _dlgt];
	}],
    /*----------------------------------------------------------------------------
    Method: Detach
    
        --- Prototype --- 
        call ["Detach",_key, _pointer*]
        ---

        <XPS_ifc_IEventRouter>

		Detachs a function/method pointer from the internal pointer collection or the entire 
		delegate if no pointer provided.
    
    Parameters: 
        _key - <HashmapKey> - the key for which pointer should be removed
		_pointer* - <Array> - in format [<HashMapObject>,"MethodName"] -OR- <Code> - only required 
		if removing one pointer from an underlying delegate that can hold multiple delegates. If not 
		provided, entire delegate is removed

		Must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Detach", compileFinal {
		params ["_key","_pointer"];
		private _dlgt = _self get "_delegates" getOrDefault [_key,createhashmap];
		private _result = _dlgt call ["Detach",_pointer];
		if (isNil "_pointer") then {_result = _self get "_delegates" deleteat _key};
		_result;
	}]
]