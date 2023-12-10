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
	<HashmapObject> which wraps an <XPS_ifc_IMultiCastDelegate> to provide Add/Remove functionality without exposing the Invoke function.

Parameters: 
	_delegate - <XPS_ifc_IMultiCastDelegate> - the delegate to wrap Add/Remove functions around.

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
		_delegate - <XPS_ifc_IMultiCastDelegate> - the delegate to wrap Add/Remove functions around.
		
	Returns:
		<True>

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not implement <XPS_ifc_IMultiCastDelegate>
    ----------------------------------------------------------------------------*/
	["#create",{
		params [["_mcDelegate",nil,[createhashmap]]];
		if (isNil "_mcDelegate") then {
			throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"#create","Delegate Parameter was nil or not a hashmap"]];
		};
		if (!(CHECK_IFC1(_mcDelegate,XPS_ifc_IMultiCastDelegate))) then {
			throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"#create","Delegate Parameter was Invalid type",_this]];
		};
		_self set ["_delegate",_mcDelegate];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Delegate"
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
    Method: Add
    
        --- Prototype --- 
        call ["Add",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Adds a function/method pointer to the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [ <HashMapObject> , "MethodName" ] -OR- <Code>

		Example Using Code:
		--- code 
        call ["Add",{ hint "Hello";}]
		---

		Example Using <HashmapObject> Method:
		--- code 
        call ["Add",[_hashmapobject, "MyMethodName"]]
		---
		
	Returns:
		<True> - if added

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
		<XPS_typ_InvalidArgumentException> - when parameter supplied was already added
    ----------------------------------------------------------------------------*/
	["Add",{
		_self get "_delegate" call ["Add",_this];
	}],
    /*----------------------------------------------------------------------------
    Method: Remove
    
        --- Prototype --- 
        call ["Remove",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Removes a function/method pointer from the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Remove",{
		_self get "_delegate" call ["Remove",_this];
	}]
]