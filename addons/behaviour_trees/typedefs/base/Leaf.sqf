#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Leaf
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Leaf : XPS_BT_ifc_INode, XPS_BT_typ_Node
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Leaf"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <processTick> method which is 
	called when Ticked

Returns:
	<HashmapObject> of a Leaf Node
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Leaf"],
	["#base", XPS_BT_typ_Node],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Leaf"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<XPS_BT_typ_Node.preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status.

	Must be Overridden - This type contains no functionality

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick", {}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Node.postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
    
    	--- Prototype --- 
    	get "NodeType"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<XPS_BT_enum_NodeType> - XPS_BT_NodeType_Leaf
	-----------------------------------------------------------------------------*/
	["NodeType",nil,[["CTOR","XPS_BT_NodeType_Leaf"]]]
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Node.Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Node.Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Node.Tick>
	-----------------------------------------------------------------------------*/
]
