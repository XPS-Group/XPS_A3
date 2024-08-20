#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_ActionSAsync
	<TypeDefinition>
		---prototype
		XPS_BT_typ_ActionSAsync : XPS_BT_ifc_INode, XPS_BT_typ_LeafSAsync
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_ActionSAsync"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called asynchronously when Ticked

Returns:
	<HashmapObject> of a Leaf Node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_ActionSAsync"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Leaf>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_LeafSAsync],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_ActionSAsync"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_LeafSAsync.@interfaces>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<XPS_BT_typ_LeafSAsync. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_LeafSAsync. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: callback
		<XPS_BT_typ_LeafSAsync. callback>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: handle
		<XPS_BT_typ_LeafSAsync. handle>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<XPS_BT_typ_LeafSAsync. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status. This is called asynchronously and initiates the <Action>
		method. Once <Action> has completed, it will call the <callback> method
		which sets the status of the Node.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		_self call ["Action",_this];
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_LeafSAsync. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Action
    
    	--- Prototype --- 
    	call ["Action",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status. This is run asynchronously in a scheduled environment.
		
		Must be Overridden.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Action",nil]
	/*----------------------------------------------------------------------------
	Method: Halt
		<XPS_BT_typ_LeafSAsync. Halt>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_LeafSAsync. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_LeafSAsync. Tick>
	-----------------------------------------------------------------------------*/
]