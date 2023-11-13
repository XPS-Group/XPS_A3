#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_SubTree
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has another Behaviour Tree which is Ticked
	when this node is also Ticked

Parent:
	<base. XPS_BT_typ_Leaf>

Implements: 
	<XPS_BT_ifc_INode>

Flags: 
	none

Protecteds: 
	tree - <HashmapObject> - of a behaviour tree
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_SubTree"],
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
		Propogates Tick down through a subTree.

	Parameters:
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self get "Status";
		private _tree = _self get "tree";
		if !(isNil "_tree") then {_status = _tree call ["Tick"];};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<base. XPS_BT_typ_Leaf. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: tree
		<HashmapObject> - a reference to a root node of a tree
	-----------------------------------------------------------------------------*/
	["tree",nil],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_BT_typ_SubTree"]
    	---

	Returns:
		_result - <HashmapObject> of a <SubTree> node
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["tree",nil];
	}]
	/*----------------------------------------------------------------------------
	Method: Init
		<base. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<base. XPS_BT_typ_Leaf. Tick>
	-----------------------------------------------------------------------------*/
]