#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_ActionAsync
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called asynchronously when Ticked

Parent:
    <virtual. XPS_BT_typ_LeafAsync>

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_ActionAsync"],
	["#base",XPS_BT_typ_LeafAsync],
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<virtual. XPS_BT_typ_Leaf. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<virtual. XPS_BT_typ_LeafAsync. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<virtual. XPS_BT_typ_LeafAsync. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: callback
		<virtual. XPS_BT_typ_LeafAsync. callback>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: handle
		<virtual. XPS_BT_typ_LeafAsync. handle>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<virtual. XPS_BT_typ_LeafAsync. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status. This is called asynchronously and initiates the <Action>
		method. Once <Action> has completed, it will call the <callback> method
		which sets the status of the Node.

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		_self call ["Action"];
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<virtual. XPS_BT_typ_LeafAsync. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Action
    
    	--- Prototype --- 
    	_status = _self call ["Action"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status. This is run asynchronously in a scheduled environment.
		
		Must be Overridden.

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["Action",nil]
	/*----------------------------------------------------------------------------
	Method: Halt
		<virtual. XPS_BT_typ_LeafAsync. Halt>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<virtual. XPS_BT_typ_LeafAsync. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<virtual. XPS_BT_typ_LeafAsync. Tick>
	-----------------------------------------------------------------------------*/
]