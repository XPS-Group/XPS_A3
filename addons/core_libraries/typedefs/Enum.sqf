#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Enum
	<Static>

Authors: 
	Crashdome
   
Description:
	Static Class to handle all derived classes of <XPS_typ_Enumeration>

Parent:
    none

Implements:
    None

Flags:
    unscheduled

---------------------------------------------------------------------------- */
[
	["#str",compilefinal {_self get "#type" select  0}],
	["#type","XPS_typ_Enum"],
	//["#flags",["unscheduled"]],
	/*----------------------------------------------------------------------------
	Method: GetNames
    
    	--- Prototype --- 
    	call ["GetNames",[_enumObject]]
    	---
	
	Prameters:
		_enumObject - <HashmapObject> - the Enumeration Type to check
    
    Returns: 
		<Array> - of all Names of the Enumeration Type
	-----------------------------------------------------------------------------*/
	["GetNames",{
		params [["_enumObject",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_enumObject get "Names"; 
	}],
	/*----------------------------------------------------------------------------
	Method: GetValueType
    
    	--- Prototype --- 
    	call ["GetValueType",[_enumObject]]
    	---
	
	Prameters:
		_enumObject - <HashmapObject> - the Enumeration Type to check
    
    Returns: 
		<String> - can be "SCALAR", "STRING" or "TEXT"
	-----------------------------------------------------------------------------*/
	["GetValueType",{
		params [["_enumObject",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_enumObject get "ValueType"; 
	}],
	/*----------------------------------------------------------------------------
	Method: GetValues
    
    	--- Prototype --- 
    	call ["GetValues",[_enumObject]]
    	---
	
	Prameters:
		_enumObject - <HashmapObject> - the Enumeration Type to check
    
    Returns: 
		<Array> - of all Values of the Enumeration Type
	-----------------------------------------------------------------------------*/
	["GetValues",{
		params [["_enumObject",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_enumObject get "Values"; 
	}],
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",[_enumObject, _lookup]]
    	---
	
	Prameters:
		_enumObject - <HashmapObject> - the Enumeration Type to check
		_lookup - <Anything> - value to look up to see if Name or Value exists
    
    Returns: 
		<Boolean> - True if _lookup value exists otherwisse False
	-----------------------------------------------------------------------------*/
	["IsDefined",{
		params [["_enumObject",createhashmap,[createhashmap]],["_lookup","",[0,"",text ""]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_lookup in keys _enumObject; 
	}]
]