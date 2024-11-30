#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventBus
	<TypeDefinition>
        --- prototype
        XPS_typ_EventBus : XPS_ifc_IEventBus, XPS_ifc_IEventHandler
        ---
        --- prototype
        createHashmapObject [XPS_typ_EventBus]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which creates a map of <XPS_ifc_IDelegates> Listens and/or Invokes
	through the <Publish> method any incoming events. <filter> method provides a way to
	control if one or more mapped <XPS_typ_Delegates> should receive the event.

	The signature of the Invoke method is set as []

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_EventBus"],
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
		_anyDelegate call ["Subscribe",[_self,"Publish"]];

		if !(XPS_CHECK_IFC1(_hndlrType,XPS_ifc_IEventHandler)) exitWith {
			throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"#create","EventHandler Type Parameter was Invalid type",_this]];
		};
		if !(XPS_CHECK_IFC1(_dlgtType,XPS_ifc_IDelegate)) exitWith {
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
		"XPS_typ_EventBus"
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IEventBus>
		<XPS_ifc_IEventHandler>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IEventBus","XPS_ifc_IEventHandler"]],
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
    Method: Publish
    
    	--- Prototype --- 
    	call ["Publish",_args]
    	---
    
	Sends received event data to filter for processing. Then pushes event args on to subscriber(s) based on key

	Parameters:
		_args - <Array> - the arguments sent by the event 
    ----------------------------------------------------------------------------*/
	["Publish", compileFinal {
		params ["_args"];
		private _keylist = _self call ["filter",_args];
		{
			_self get "delegates" get _x call ["Invoke",[_args,_x]];
		} forEach _keyList;
	}],
    /*----------------------------------------------------------------------------
    Method: Attach
    
        --- Prototype --- 
        call ["Subscribe",[_pointer,_key]]
        ---

        <XPS_ifc_IEventBus>

		Attachs a pointer to another function/method with given key
    
    Parameters: 
        _pointer - <Array> in format [HashMapObject,"MethodName"] -OR- <Code>
		
		Example Using Code:
		--- code 
        call ["Subscribe",[{ hint "Hello";},"key""]]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Subscribe",[[_hashmapobject, "MyMethodName"],"key"]]
		---
		
	Returns:
		<True> - if attached

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
    ----------------------------------------------------------------------------*/
	["Subscribe", compileFinal {
		params ["_pointer","_key"];
		private _dlgt = _self get "delegates" getOrDefault [_key , createHashmapObject [_self get "_delegateType",[]], true];
		private _hndlr = _self get "handlers" getOrDefault [_key , createHashmapObject [_self get "_handlerType",[_dlgt]], true];
		_hndlr call ["Subscribe",_pointer];
	}],
    /*----------------------------------------------------------------------------
    Method: Detach
    
        --- Prototype --- 
        call ["Unsubscribe",_key, _pointer*]
        ---

        <XPS_ifc_IEventBus>

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
	["Unsubscribe", compileFinal {
		params ["_key","_pointer"];
		private _hndlr = _self get "handlers" getOrDefault [_key,createhashmap];
		private _result = _hndlr call ["Unsubscribe",_pointer];
		if (isNil "_pointer") then {
			_self get "delegates" deleteat _key;
			_result = _self get "handlers" deleteat _key
		};
		_result;
	}]
]

//TODO Add exceptions