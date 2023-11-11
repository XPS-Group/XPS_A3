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
	/*----------------------------------------------------------------------------
	Property: Names
    
    	--- Prototype --- 
    	get "Names"
    	---
    
    Returns: 
		<Array> - of all Type Names
	-----------------------------------------------------------------------------*/
	["Names",[]],
	/*----------------------------------------------------------------------------
	Property: ValueType
    
    	--- Prototype --- 
    	get "ValueType"
    	---
    
    Returns: 
		<String> - can be "SCALAR", "STRING" or "TEXT"
	-----------------------------------------------------------------------------*/
	["ValueType","SCALAR"],
	/*----------------------------------------------------------------------------
	Property: Values
    
    	--- Prototype --- 
    	get "Values"
    	---
    
    Returns: 
		<Array> - of all Values
	-----------------------------------------------------------------------------*/
	["Values",[]],
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",[_lookup]]
    	---
	
	Prameters:
		_lookup - <Anything> - value to look up to see if Name or Value exists
    
    Returns: 
		<Boolean> - True if _lookup value exists otherwisse False
	-----------------------------------------------------------------------------*/
	["IsDefined", {
		params [["_lookup","",[0,"",text ""]]];
		_lookup in keys _self;
	}]
]