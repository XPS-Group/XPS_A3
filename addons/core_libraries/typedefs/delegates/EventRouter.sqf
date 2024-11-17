#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventRouter
	<TypeDefinition>
        --- prototype
        XPS_typ_EventRouter : XPS_typ_EventHandler, XPS_ifc_IEventRouter, XPS_ifc_IEventHandler
        ---
        --- prototype
        createHashmapObject [XPS_typ_EventRouter]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which creates a map of <XPS_ifc_IDelegates> Listens and/or Invokes
	through the <RouteEvent> method any incoming events. <filter> method provides a way to
	control if one or more mapped <XPS_typ_Delegates> should receive the event.

	The signature of the Invoke method is set as []

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_EventRouter"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_EventHandler>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_EvenetHandler],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",[_handlerType, _delegateType, _filter]]
        ---
    
	Parameters: 
		_handlerType - (optional - Default: <XPS_typ_EventHandler>) - a type definition implementing the <XPS_ifc_IEventhandler> interface.
		_delegateType - (optional - Default: <XPS_typ_Delegate>) - a type definition implementing the <XPS_ifc_IDelegate> interface.
		_filter - (optional - Default: no filter) - code which filters the <handlers> to one or more keys. See: <handlers>
	
    Return:
        <True>

	Throws:
		<XPS_typ_InvalidArgumentException> - when parameter does not implement the proper interface.
    ----------------------------------------------------------------------------*/
	["#create",compileFinal {
		
        params ["_anyDelegate",["_hndlrType",XPS_typ_EventHandler,[createhashmap]],["_dlgtType",XPS_typ_MultiCastDelegate,[createhashmap]],["_filter",nil,[{}]]];

		_self call ["XPS_typ_EventHandler.#create",_anyDelegate];
		_anyDelegate call ["Attach",[_self,"RouteEvent"]];

		if !(CHECK_IFC1(_hndlrType,XPS_ifc_IEventHandler)) exitWith {
			throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"#create","EventHandler Type Parameter was Invalid type",_this]];
		};
		if !(CHECK_IFC1(_dlgtType,XPS_ifc_IDelegate)) exitWith {
			throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"#create","Delegate Type Parameter was Invalid type",_this]];
		};

        if !(isNil "_filter") then {_self set ["filter",compileFinal _filter]};
		_self set ["_handlerType",_hndlrType];
		_self set ["_delegateType",_dlgtType];
		_self set ["delegates", createhashmap];
		_self set ["handlers",createhashmap];
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
	["@interfaces",["XPS_ifc_IEventRouter"]],
	["_delegateType",nil],
	["_handlerType",nil],
	["delegates",nil],
	["handlers",nil],
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
		_keyList - <Array> of <HashmapKey> - the keys which dictate where to route to.
    ----------------------------------------------------------------------------*/
	["filter", compileFinal {
		keys (_self get "handlers");
	}],
    /*----------------------------------------------------------------------------
    Method: RouteEvent
    
    	--- Prototype --- 
    	call ["RouteEvent",_args]
    	---
    
	Sends received event data to filter for processing. Then pushes event args on to subscriber based on key

	Parameters:
		_args - <Array> - the arguments sent by the event 
    ----------------------------------------------------------------------------*/
	["RouteEvent", compileFinal {
		params ["_args"];
		private _keylist = _self call ["filter",_args];
		{
			_self get "delegates" get _x call ["Invoke",[_args,_x]];
		} forEach _keyList;
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
	["Attach", compileFinal {
		params ["_pointer","_key"];
		private _dlgt = _self get "delegates" getOrDefault [_key , createHashmapObject [_self get "_delegateType",[]], true];
		private _hndlr = _self get "handlers" getOrDefault [_key , createHashmapObject [_self get "_handlerType",[_dlgt]], true];
		_hndlr call ["Attach",_pointer];
	}],
    /*----------------------------------------------------------------------------
    Method: Detach
    
        --- Prototype --- 
        call ["Detach",_key, _pointer*]
        ---

        <XPS_ifc_IEventRouter>

		Detachs a function/method pointer from the internal pointer collection or deletes the entire 
		delegate if no pointer provided.
    
    Parameters: 
        _key - <HashmapKey> - the key for which pointer should be removed
		_pointer* - <Array> - in format [<HashMapObject>,"MethodName"] -OR- <Code> - only required 
		if removing one pointer from an underlying delegate that can hold multiple delegates. If not 
		provided, entire delegate is removed

		_pointer must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Detach", compileFinal {
		params ["_key","_pointer"];
		private _hndlr = _self get "handlers" getOrDefault [_key,createhashmap];
		private _result = _hndlr call ["Detach",_pointer];
		if (isNil "_pointer") then {
			_self get "delegates" deleteat _key;
			_result = _self get "handlers" deleteat _key
		};
		_result;
	}]
]

//TODO Add exceptions