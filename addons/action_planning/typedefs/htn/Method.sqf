#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_Method
	<TypeDefinition>
		---prototype
		XPS_AP_typ_Method : XPS_AP_ifc_IMethod
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_Method"]
    	---

Authors: 
	Crashdome

Description:
	A Method is a collection used in Heirarchical Task/Goal-Task Networks which decompose 
	into smaller subtasks based on a satisfied condition. 

Returns:
	<HashmapObject> of a Method

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_Method"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Method"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IMethod>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_IMethod"]],
	/*----------------------------------------------------------------------------
	Property: SubTasks
    
    	--- Prototype --- 
    	get "SubTasks"
    	---

		<XPS_AP_ifc_IMethod>
    
    Returns: 
		<Array> - ordered list of usually other <XPS_AP_typ_CompoundTasks> or <XPS_AP_typ_PrimitiveTasks>
	-----------------------------------------------------------------------------*/
	["SubTasks",[]],
	/*----------------------------------------------------------------------------
	Method: Precondition
    
    	--- Prototype --- 
    	call ["Precondition",_args*]
    	---

        Alternative: 

        --- code ---
        get "Precondition"  //allows lazy execution
        ---

		<XPS_AP_ifc_IMethod>
    
    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to condition when executed

    Returns: 
		<Boolean> - True if satisfied, otherwise False

	-----------------------------------------------------------------------------*/
    ["Precondition", {}]
]
