#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_Multigoal
	<TypeDefinition>
		---prototype
		XPS_AP_typ_CompoundTask : XPS_AP_ifc_ICompoundTask
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_CompoundTask"]
    	---

Authors: 
	Crashdome

Description:
	A Compound task is a collection of methods tested in order until a condition
	is Satisfied within the Method
Returns:
	<HashmapObject> of a Method

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_CompoundTask"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_CompoundTask"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_ICompoundTask>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_ICompoundTask"]],
    []
]