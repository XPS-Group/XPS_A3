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
		<String> - can be "<Number>", "<STRING>" or "<TEXT>"
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
		_lookup - <Number>,<String>, or <Text> - value to look up to get reference
    
    Returns: 
		<HashmapObject> - The reference to the Enumeration constant

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
		<XPS_typ_ArgumentOutOfRangeException> - when parameter supplied was not defined in the underlying enumeration
	-----------------------------------------------------------------------------*/
	["GetEnum", {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil",_this]]};
		if !(_this isEqualTypeAny [0,"",text ""]) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a number, string, or structured text.",_this]];};
		if (_self call ["IsDefined",_this]) then {
			_self call [_this];
		} else {throw createhashmapobject[XPS_typ_ArgumentOutOfRangeException,[_self,"GetEnum","Argument supplied was not found.",_this]];};
	}],
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",_lookup]
    	---
	
	Prameters:
		_lookup - <Number>,<String>, or <Text> - value to look up to get reference
    
    Returns: 
		<Boolean> - <True> if _lookup value exists otherwise <False>

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
	-----------------------------------------------------------------------------*/
	["IsDefined", {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil",_this]]};
		if !(_this isEqualTypeAny [0,"",text ""]) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a number, string, or structured text.",_this]];};
		
		_this in keys _self;
	}]
]