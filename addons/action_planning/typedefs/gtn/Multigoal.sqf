#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_Multigoal
	<TypeDefinition>
		---prototype
		XPS_AP_typ_Multigoal : XPS_AP_ifc_IMultigoal
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_Multigoal"]
    	---

Authors: 
	Crashdome

Description:
	A collection of methods tested in order until a goal condition
	is Satisfied. Multigoals have multiple conditions to satisfy versus 
    a UniGoal which typically only satisfies one goal condition.

Returns:
	<HashmapObject> of a Multigoal

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_Multigoal"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Multigoal"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IMultigoal>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_IMultigoal"]],
    []
]