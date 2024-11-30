#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventHandler
	<TypeDefinition>
        --- prototype
        XPS_typ_EventHandler : XPS_ifc_IEventHandler
        ---
        --- code
        createHashmapObject [XPS_typ_EventHandler,[_delegate]]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which wraps an <XPS_ifc_IDelegate> to provide Subscribe/Unsubscribe functionality without exposing the Invoke function.

Parameters: 
	_delegate - <XPS_ifc_IDelegate> - the delegate to wrap Subscribe/Unsubscribe functions around.

Returns:
	<HashmapObject>

Throws: 
	<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
	<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_EventHandler"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",[_delegate]]
        ---
    
	Parameters: 
		_delegate - <XPS_ifc_IDelegate> - the delegate to wrap Subscribe/Unsubscribe functions around.
		
	Returns:
		<True>

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not implement <XPS_ifc_IDelegate>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_anyDelegate",nil,[createhashmap]]];
		if (isNil "_anyDelegate") exitWith {
			throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"#create","Delegate Parameter was nil or not a hashmap"]];
		};
		if (!(XPS_CHECK_IFC1(_anyDelegate,XPS_ifc_IDelegate))) exitWith {
			throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"#create","Delegate Parameter was Invalid type",_this]];
		};
		_self set ["_delegate",_anyDelegate];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_EventHandler"
		---
	----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IEventHandler>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IEventHandler"]],
	["_delegate",nil],
    /*----------------------------------------------------------------------------
    Method: Subscribe
    
        --- Prototype --- 
        call ["Subscribe",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Attachs a function/method pointer to the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [ <HashMapObject> , "MethodName" ] -OR- <Code>

		Example Using Code:
		--- code 
        call ["Subscribe", compileFinal { hint "Hello";}]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Subscribe",[_hashmapobject, "MyMethodName"]]
		---
		
	Returns:
		<True> - if added

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
		<XPS_typ_InvalidArgumentException> - when parameter supplied was already added
    ----------------------------------------------------------------------------*/
	["Subscribe", compileFinal {
		_self get "_delegate" call ["Subscribe",_this];
	}],
    /*----------------------------------------------------------------------------
    Method: Unsubscribe
    
        --- Prototype --- 
        call ["Unsubscribe",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Detachs a function/method pointer from the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Unsubscribe", compileFinal {
		_self get "_delegate" call ["Unsubscribe",_this];
	}]
]