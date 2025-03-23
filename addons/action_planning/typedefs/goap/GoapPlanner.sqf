#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. goap. XPS_AP_typ_GoapPlanner
	<TypeDefinition>
	---prototype
	XPS_AP_typ_GoapPlanner : main.XPS_ifc_IGoapPlanner
	---
	---prototype
	createhashmapobject [XPS_AP_typ_GoapPlanner, [_var1*, _var2*]]
	---


Authors: 
	Crashdome

Description:
	<HashmapObject> which represents a...

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_GoapPlanner"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Action"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	["@interfaces",["XPS_ifc_IAstarNode"]],	
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_typ_Name",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_index",nil,[""]],["_goal",nil,[createhashmap]]];
		
	}],
	/*----------------------------------------------------------------------------
	Property: Index
    
    	--- Prototype --- 
    	get "Index"
    	---

		<main. XPS_ifc_IAstarNode>

    Returns: 
		<String> - the key used to store this in a <XPS_AP_typ_GoapGraph>
	-----------------------------------------------------------------------------*/
	["_search",nil],
	["_goals",createhashmap],
    ["_beliefs",createhashmap],
    ["_graphs",createhashmap],
    ["_plan",[]]
    
]