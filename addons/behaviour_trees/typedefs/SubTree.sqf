#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_SubTree
	<TypeDefinition>
		---prototype
		XPS_BT_typ_SubTree : XPS_BT_ifc_INode, XPS_BT_typ_Leaf
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_SubTree"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has another Behaviour Tree which is Ticked
	when this node is also Ticked

Returns:
	<HashmapObject> of a Leaf Node
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_SubTree"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Leaf>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_Leaf],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["XPS_BT_typ_SubTree"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["tree",nil];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_SubTree"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_Leaf. @interfaces>
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
		Propogates Tick down through a subTree.

	Parameters:
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self get "Status";
		private _tree = _self get "tree";
		if !(isNil "_tree") then {_status = _tree call ["Tick"];};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Leaf. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: tree

		---code 
		get "tree"
		---

	Returns:	
		<HashmapObject> - a reference to a root node of a tree
	-----------------------------------------------------------------------------*/
	["tree",nil]
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Leaf. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
]