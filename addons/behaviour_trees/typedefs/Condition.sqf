#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Condition
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked

Parent:
    <base. XPS_BT_typ_Leaf>

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Condition"],
	["#base",XPS_BT_typ_Leaf],
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<base. XPS_BT_typ_Leaf. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<base. XPS_BT_typ_Leaf. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<base. XPS_BT_typ_Leaf. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<base. XPS_BT_typ_Leaf. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	_status = _self call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status.

	Parameters:
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = if (_self call ["Condition"]) then {XPS_BT_Status_Success} else {XPS_BT_Status_Failure};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<base. XPS_BT_typ_Leaf. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Condition
    
    	--- Prototype --- 
    	_condition = _self call ["Condition"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns true/false. 
		
		Must be Overridden.
		
	Returns: 
		_condition - <Boolean> - True or False
	-----------------------------------------------------------------------------*/
	["Condition",nil]
	/*----------------------------------------------------------------------------
	Method: Init
		<base. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<base. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
]