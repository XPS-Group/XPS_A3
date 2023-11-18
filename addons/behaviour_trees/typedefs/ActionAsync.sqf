#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_ActionAsync
	<TypeDefinition>
		---prototype
		XPS_BT_typ_ActionAsync : XPS_BT_ifc_INode, XPS_BT_typ_LeafAsync
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_ActionAsync"]
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
	["#type","XPS_BT_typ_ActionAsync"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Leaf>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_LeafAsync],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_ActionAsync"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_LeafAsync.@interfaces>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<XPS_BT_typ_LeafAsync. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<XPS_BT_typ_LeafAsync. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_LeafAsync. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: callback
		<XPS_BT_typ_LeafAsync. callback>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: handle
		<XPS_BT_typ_LeafAsync. handle>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<XPS_BT_typ_LeafAsync. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status. This is called asynchronously and initiates the <Action>
		method. Once <Action> has completed, it will call the <callback> method
		which sets the status of the Node.

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		_self call ["Action"];
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_LeafAsync. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Action
    
    	--- Prototype --- 
    	call ["Action"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status. This is run asynchronously in a scheduled environment.
		
		Must be Overridden.

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Action",nil]
	/*----------------------------------------------------------------------------
	Method: Halt
		<XPS_BT_typ_LeafAsync. Halt>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_LeafAsync. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_LeafAsync. Tick>
	-----------------------------------------------------------------------------*/
]