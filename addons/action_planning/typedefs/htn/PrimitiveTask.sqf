#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: action_planning. htn. XPS_AP_typ_PrimitiveTask
	<TypeDefinition>
		---prototype
		XPS_AP_typ_PrimitiveTask : XPS_AP_ifc_IPrimitiveTask
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_AP_typ_PrimitiveTask"]
    	---

Authors: 
	Crashdome

Description:
	A Method is a collection used in Heirarchical Task Networks which decompose 
	into smaller subtasks based on a satisfied condition. These collections are usually 
	found in a <XPS_AP_typ_PrimitiveTask> in order of priority.

Returns:
	<HashmapObject> of a Method

---------------------------------------------------------------------------- */
[
	["#type","XPS_AP_typ_PrimitiveTask"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_PrimitiveTask"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IPrimitiveTask>
	-----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_AP_ifc_IPrimitiveTask"]],

	/*----------------------------------------------------------------------------
	Method: Precondition
    
    	--- Prototype --- 
    	call ["Precondition",_args*]
    	---

        Alternative: 

        --- code ---
        get "Precondition"  //allows lazy execution
        ---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Conditional check to see if task is a valid task to plan for.
    
    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Precondition when executed

    Returns: 
		<Boolean> - True if satisfied, otherwise False

	-----------------------------------------------------------------------------*/
    ["Precondition",{}],
	/*----------------------------------------------------------------------------
	Method: Operation
    
    	--- Prototype --- 
    	call ["Operation",_args*]
    	---

        Alternative: 

        --- code ---
        get "Operation"  //allows lazy execution
        ---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Code to execute to complete task.

    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Operation when executed

    Returns: 
		<Anything>

	-----------------------------------------------------------------------------*/
    ["Operation",{}],
	/*----------------------------------------------------------------------------
	Method: Effects
    
    	--- Prototype --- 
    	call ["Effects",_args*]
    	---

        Alternative: 

        --- code ---
        get "Effects"  //allows lazy execution
        ---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Code to execute on current World State after Operation has completed.

    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Effects when executed

    Returns: 
		<Anything>

	-----------------------------------------------------------------------------*/
    ["Effects",{}],
	/*----------------------------------------------------------------------------
	Method: Expected
    
    	--- Prototype --- 
    	call ["Expected",_args*]
    	---

        Alternative: 

        --- code ---
        get "Expected"  //allows lazy execution
        ---

		<XPS_AP_ifc_IPrimitiveTask>

	Description:
		Code to execute on the working world state during planning. Applies expected changes
		in order to validate possible future tasks.

    Parameters: 
        _args* - (Optional) - <Anything> - arguments passed to Expected when executed

    Returns: 
		<Anything>

	-----------------------------------------------------------------------------*/
    ["Expected",{}]
]