#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Condition
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Condition : XPS_BT_ifc_INode, XPS_BT_typ_Leaf
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Condition"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked

Returns:
	<HashmapObject> of a Leaf Node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Condition"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Leaf>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_Leaf],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Condition"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_Leaf.@interfaces>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<XPS_BT_typ_Leaf. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<XPS_BT_typ_Leaf. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Leaf. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<XPS_BT_typ_Leaf. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status.

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = if (_self call ["Condition"]) then {XPS_BT_Status_Success} else {XPS_BT_Status_Failure};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Leaf. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Condition
    
    	--- Prototype --- 
    	call ["Condition"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns true/false. 
		
		Must be Overridden.
		
	Returns: 
		<Boolean> - <True> or <False>
	-----------------------------------------------------------------------------*/
	["Condition",nil]
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Leaf. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
]