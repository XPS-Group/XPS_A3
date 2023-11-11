#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Enumeration
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	Abstract Class. Derived classes created with 
	<XPS_fnc_createEnumeration: core.typeHandlers.XPS_fnc_createEnumeration> will store
	 a type-safe set of enumerations in the Values property which are constants (compileFinal'd).

	

	This class is not meant to be inherited directly.
	Use <XPS_fnc_createEnumeration: core.typeHandlers.XPS_fnc_createEnumeration> to generate them safely.
	
Parent:
    none

Implements:
    None

Flags:
    unscheduled


---------------------------------------------------------------------------- */
[
	["#str",compilefinal {_self get "#type" select  0}],
	["#type","XPS_typ_Enumeration"],
	//["#flags",["unscheduled"]],
	["Names",[]],
	["ValueType","SCALAR"],
	["Values",[]],
	["IsDefined", {
		params [["_lookup","",[0,"",text ""]]];
		_lookup in keys _self;
	}]
]