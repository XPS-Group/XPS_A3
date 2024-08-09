#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventRouter
	<TypeDefinition>
        --- prototype
        XPS_typ_EventRouter : XPS_ifc_IEventRouter
        ---
        --- prototype
        createhashmapobject [XPS_typ_EventRouter]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which creates a map of <XPS_typ_Delegates> to both control invocation and
	also provide a method for incoming events for which to route to a mapped <XPS_typ_Delegate>.

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
		if !(isnil "_this") then {
			if !(CHECK_IFC1(_this,XPS_ifc_IDelegate)) exitwith {
				throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"#create","Delegate Type Parameter was Invalid type",_this]];
			};
			_self set ["_delegateType",_this];
		} else {
			_self set ["_delegateType",XPS_typ_Delegate];
		};
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
    Protected: routeEvent
    
    	--- Prototype --- 
    	call ["routeEvent", [ _sender, _args]]
    	---
    
	This method should be overridden. Must Return below parameters.

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_args - <Array> - the arguments sent by the event 

	Returns:
		_key - <HashmapKey> - the key which dictates where to route to. See <XPS_typ_RoutingDelegate> for more info 
    ----------------------------------------------------------------------------*/
	["routeEvent",{}],
    /*----------------------------------------------------------------------------
    Protected: onEventReceived
    
    	--- Prototype --- 
    	call ["onEventReceived",[ _sender, _args]]
    	---
    
	Sends received event data to filter for processing. Then pushes event args on to subscriber based on key

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_args - <Array> - the arguments sent by the event 
    ----------------------------------------------------------------------------*/
	["onEventReceived",{
		private _key = _self call ["routeEvent",_this];
		_self get "_delegates" get _key call ["Invoke",_this];
	}],
    /*----------------------------------------------------------------------------
    Method: Attach
    
        --- Prototype --- 
        call ["Attach",[_key,_pointer]]
        ---

        <XPS_ifc_IEventRouter>

		Attachs a pointer to another function/method with given key
    
    Parameters: 
        _pointer - <Array> in format [HashMapObject,"MethodName"] -OR- <Code>
		
		Example Using Code:
		--- code 
        call ["Attach",[_key, { hint "Hello";}]]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Attach",[_key, [_hashmapobject, "MyMethodName"]]]
		---
		
	Returns:
		<True> - if attached

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
    ----------------------------------------------------------------------------*/
	["Attach",{
		params ["_key","_pointer"];
		private _dlgt = createhashmapobject [_self get "_delegateType"];
		_dlgt call ["Attach",_pointer];
		_self get "_delegates" set [_key, _dlgt];
	}]
]