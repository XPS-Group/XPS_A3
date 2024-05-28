#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Enumeration
	<TypeDefinition>
    	--- Prototype --- 
    	XPS_typ_Enumeration : XPS_ifc_IEnumeration
    	---

Authors: 
	Crashdome
   
Description:
	Abstract Class. Helper that provides lookup and retrieval of global static enumerations.
	Derived classes created with 
	<XPS_fnc_createEnumeration: core.typeHandlers.XPS_fnc_createEnumeration> will store
	a type-safe set of enumeration references to global variables which are constants (compileFinal'd).
	Additionally, it will create a static helper class using this definition.

	See <XPS_fnc_createEnumeration> for more info on usage of types inheriting this type

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Enumeration"],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_typ_Enum"
		---
	-----------------------------------------------------------------------------*/
	["#str",compilefinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_ifc_IEnumeration>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IEnumeration"]],
	/*----------------------------------------------------------------------------
	Property: Names
    
    	--- Prototype --- 
    	get "Names"
    	---
    
    Returns: 
		<Array> - of all Enumeration Names
	-----------------------------------------------------------------------------*/
	["Names",[]],
	/*----------------------------------------------------------------------------
	Property: ValueType
    
    	--- Prototype --- 
    	get "ValueType"
    	---
    
    Returns: 
		<String> - can be "<SCALAR>", "<STRING>" or "<TEXT>"
	-----------------------------------------------------------------------------*/
	["ValueType","SCALAR"],
	/*----------------------------------------------------------------------------
	Property: Values
    
    	--- Prototype --- 
    	get "Values"
    	---
    
    Returns: 
		<Array> - of all Enumeration Values
	-----------------------------------------------------------------------------*/
	["Values",[]],
	/*----------------------------------------------------------------------------
	Method: GetEnum
    
    	--- Prototype --- 
    	call ["GetEnum",_lookup]
    	---

	Prameters:
		_lookup - <Anything> - value to look up to get reference
    
    Returns: 
		<HashmapObject> - The reference to the Enumeration constant or False if not defined
	-----------------------------------------------------------------------------*/
	["GetEnum", {
		[_this] params [["_lookup","",[0,"",text ""]]];
		if (_self call ["IsDefined",_lookup]) then {
			_self call [_lookup];
		} else {false};
	}],
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",_lookup]
    	---
	
	Prameters:
		_lookup - <Anything> - value to look up to see if Name or Value exists
    
    Returns: 
		<Boolean> - <True> if _lookup value exists otherwise <False>
	-----------------------------------------------------------------------------*/
	["IsDefined", {
		[_this] params [["_lookup","",[0,"",text ""]]];
		_lookup in keys _self;
	}]
]