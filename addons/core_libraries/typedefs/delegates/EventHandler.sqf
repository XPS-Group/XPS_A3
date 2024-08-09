#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventHandler
	<TypeDefinition>
        --- prototype
        XPS_typ_EventHandler : XPS_ifc_IEventHandler
        ---
        --- code
        createhashmapobject [XPS_typ_EventHandler,[_delegate]]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which wraps an <XPS_ifc_IDelegate> to provide Attach/Detach functionality without exposing the Invoke function.

Parameters: 
	_delegate - <XPS_ifc_IDelegate> - the delegate to wrap Attach/Detach functions around.

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
		_delegate - <XPS_ifc_IDelegate> - the delegate to wrap Attach/Detach functions around.
		
	Returns:
		<True>

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not implement <XPS_ifc_IDelegate>
    ----------------------------------------------------------------------------*/
	["#create",{
		params [["_mcDelegate",nil,[createhashmap]]];
		if (isNil "_mcDelegate") exitwith {
			throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"#create","Delegate Parameter was nil or not a hashmap"]];
		};
		if (!(CHECK_IFC1(_mcDelegate,XPS_ifc_IDelegate))) exitwith {
			throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"#create","Delegate Parameter was Invalid type",_this]];
		};
		_self set ["_delegate",_mcDelegate];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_EventHandler"
		---
	----------------------------------------------------------------------------*/
	["#str",compilefinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IEventHandler>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IEventHandler"]],
	["_delegate",nil],
    /*----------------------------------------------------------------------------
    Method: Attach
    
        --- Prototype --- 
        call ["Attach",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Attachs a function/method pointer to the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [ <HashMapObject> , "MethodName" ] -OR- <Code>

		Example Using Code:
		--- code 
        call ["Attach",{ hint "Hello";}]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Attach",[_hashmapobject, "MyMethodName"]]
		---
		
	Returns:
		<True> - if added

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
		<XPS_typ_InvalidArgumentException> - when parameter supplied was already added
    ----------------------------------------------------------------------------*/
	["Attach", compileFinal {
		_self get "_delegate" call ["Attach",_this];
	}],
    /*----------------------------------------------------------------------------
    Method: Detach
    
        --- Prototype --- 
        call ["Detach",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Detachs a function/method pointer from the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Detach", compileFinal {
		_self get "_delegate" call ["Detach",_this];
	}]
]