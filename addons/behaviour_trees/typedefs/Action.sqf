#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Action
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Action : XPS_BT_ifc_INode, XPS_BT_typ_Leaf
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Action"]
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
	["#type","XPS_BT_typ_Action"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Leaf>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_Leaf],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Action"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_Leaf.@interfaces>
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
    	call ["processTick",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self call ["Status",[]];
		_status = _self call ["Action",_this];
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Leaf. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Action
    
    	--- Prototype --- 
    	call ["Action",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status. 
		
		Must be Overridden.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Action",nil]
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Leaf. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/

]
