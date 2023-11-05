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
    <virtual. XPS_BT_typ_Leaf>

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
		<virtual. XPS_BT_typ_Leaf. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<virtual. XPS_BT_typ_Leaf. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<virtual. XPS_BT_typ_Leaf. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<virtual. XPS_BT_typ_Leaf. preTick>
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
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		if (_self call ["Condition"]) then {_status = NODE_SUCCESS} else {_status = NODE_FAILURE};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<virtual. XPS_BT_typ_Leaf. postTick>
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
		<virtual. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<virtual. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
]