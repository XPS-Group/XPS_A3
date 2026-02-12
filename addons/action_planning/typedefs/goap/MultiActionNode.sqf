#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. goap. XPS_AP_typ_GoapNode
	<TypeDefinition>
	---prototype
	XPS_AP_typ_GoapNode : main.XPS_ifc_IAstarNode
	---
	---prototype
	createhashmapobject [XPS_AP_typ_GoapNode, [_var1*, _var2*]]
	---


Authors: 
	Crashdome

Description:
	<HashmapObject> which represents a...

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str", compileFinal {"XPS_AP_typ_GoapNode"}],
	["#type","XPS_AP_typ_GoapNode"],
	["@interfaces",["XPS_ifc_IAstarNode"]],	
	/*----------------------------------------------------------------------------
	Property: Index
    
    	--- Prototype --- 
    	get "Index"
    	---

		<main. XPS_ifc_IAstarNode>

    Returns: 
		<String> - the key used to store this in a <XPS_AP_typ_GoapGraph>
	-----------------------------------------------------------------------------*/
	["Index",nil],
	["Actions",[]],
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
		params [["_index",nil,[""]],["_action",nil,[createhashmap]]];
		
	}]
]
