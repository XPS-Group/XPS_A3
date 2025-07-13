#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Action
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Action : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_Action, []]
	---

Authors: 
	CrashDome

Description:
	An object that exewcutes an action and returns an <XPS_Status> <Enumeration>

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_Action"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Action"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction"]],
	/*----------------------------------------------------------------------------
	Protected: preExecute
    
    	--- Prototype --- 
    	call ["preExecute", [_context, _args]]
    	---

	Description:
		The code that executes before the action.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Optionals:
		_args - <anything> - the argument or arguments to be passed into the action along with the context

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["preExecute",compileFinal {
		if (isNil {_self get "Status"}) then {
			_self set ["Status",XPS_Status_Running];
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: postExecute
    
    	--- Prototype --- 
    	call ["postExecute",_status]
    	---

	Description:
		The code that executes and then sets the <Status> property.

	Parameters:
		_status - <Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["postExecute",compileFinal {
		_self set ["Status",_this];
		_this;
	}],
	/*----------------------------------------------------------------------------
	Protected: action
    
    	--- Prototype --- 
    	call ["action", [_context, _args]]
    	---

	Description:
		The code that executes and then returns a status.

	Must be Overridden - This type contains no functionality

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface
	
	Optionals:
		_args - <anything> - the argument or arguments to be passed into the action along with the context

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["action", {}],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---

		<XPS_AP_ifc_IAction>
    
    Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Status",nil],
	/*----------------------------------------------------------------------------
	Method: Execute
    
    	--- Prototype --- 
    	call ["Execute", [_context, _args]]
    	---

		<XPS_AP_ifc_IAction>

	Description:
		The code that begins the entire execution process. This base action can be run scheduled or unscheduled but,
		will return a Status result as soon as execution is complete. For asynchronous actions where it may take some time to complete
		the action after execution of script, use <XPS_AP_typ_ActionSAsync> or <XPS_AP_typ_ActionUAsync>

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Optionals:
		_args - <anything> - the argument or arguments to be passed into the action along with the context

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Execute", {	
		_self call ["preExecute",_this];
		_self call ["postExecute",
			_self call ["action",_this];
		];
	}]
]