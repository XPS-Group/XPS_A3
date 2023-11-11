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
	["GetNames",{
		params [["_enumObject",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_enumObject get "Names"; 
	}],
	["GetValueType",{
		params [["_enumObject",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_enumObject get "ValueType"; 
	}],
	["GetValues",{
		params [["_enumObject",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_enumObject get "Values"; 
	}],
	["IsDefined",{
		params [["_enumObject",createhashmap,[createhashmap]],["_lookup","",[0,"",text ""]]];
		if !("#type" in keys _enumObject && {"XPS_typ_Enumeration" in _enumObject get "#type"}) exitwith {false};
		
		_lookup in keys _enumObject; 
	}]
]