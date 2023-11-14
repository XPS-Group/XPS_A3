#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Action
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
	["#type","XPS_BT_typ_Action"],
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

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self get "Status";
		_status = _self call ["Action"];
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<base. XPS_BT_typ_Leaf. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Action
    
    	--- Prototype --- 
    	_status = _self call ["Action"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status. 
		
		Must be Overridden.

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Action",nil]
	/*----------------------------------------------------------------------------
	Method: Init
		<base. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<base. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/

]