#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_enum_Status
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	An Enumeration set for node statuses.

Parent:
    <core. XPS_typ_Enumeration>

Implements:
	None 

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_enum_Status"],
	["#base",XPS_typ_Enumeration],
	/*----------------------------------------------------------------------------
	Property: Names
    
    	--- Prototype --- 
    	get "Names"
    	---
    
    Returns: 
		<Array> - ["Success", "Failure", "Running"]
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: ValueType
    
    	--- Prototype --- 
    	get "ValueType"
    	---
    
    Returns: 
		<String> - "<STRING>"
	-----------------------------------------------------------------------------*/
	["ValueType","STRING"],
	["Enumerations", [["Success","SUCCESS"], ["Failure","FAILURE"], ["Running","RUNNING"]]]
	/*----------------------------------------------------------------------------
	Property: Values
    
    	--- Prototype --- 
    	get "Values"
    	---
    
    Returns: 
		<Array> - ["SUCCESS", "FAILURE","RUNNING"]
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetEnum
    
    	--- Prototype --- 
    	call ["GetEnum",[_lookup]]
    	---
	
	Prameters:
		_lookup - Anything - value to look up to get reference
    
    Returns: 
		<HashmapObject> - The reference to the Enumeration constant or nil
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",[_lookup]]
    	---
	
	Prameters:
		_lookup - Anything - value to look up to see if Name or Value exists
    
    Returns: 
		<Boolean> - True if _lookup value exists otherwise False
	-----------------------------------------------------------------------------*/
]