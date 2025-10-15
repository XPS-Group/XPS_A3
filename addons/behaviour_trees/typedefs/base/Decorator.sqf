#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Decorator
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Decorator : XPS_BT_ifc_INode, XPS_BT_typ_Node
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Decorator"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has one child

Returns:
	<HashmapObject> of a Decorator node
	
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Decorator"],
	["#base", XPS_BT_typ_Node],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self call ["XPS_BT_typ_Node.#create",[]];
		_self set ["child",nil];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Decorator"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	/* ----------------------------------------------------------------------------
	Protected: child
    
    	--- Prototype --- 
    	get "child"
    	---

	Retruns:
		<HashmapObject> - child node
	---------------------------------------------------------------------------- */
	["child",nil],
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
	["processTick",compileFinal {
		private _status = _self call ["Status",[]];
		private _child = _self get "child";
		if (isNil "_child") exitWith {XPS_Status_Failure};
		_child call ["Tick",_this];		
	}],
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
		<XPS_BT_enum_NodeType> - XPS_BT_NodeType_Decorator
	-----------------------------------------------------------------------------*/
	["NodeType",nil,[["CTOR","XPS_BT_NodeType_Decorator"]]],
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Node.Status>
	-----------------------------------------------------------------------------*/

	/*----------------------------------------------------------------------------
	Method: AddChildNode
    
    	--- Prototype --- 
    	call ["AddChildNode",[childNode]]
    	---

	Description:
		Adds a child node to this node. Subsequent calls will replace previous values

	Parameters:
		childNode - <HashmapObject> that implements the <XPS_BT_ifc_INode> interface

	Returns: 
		<Hashmapobject> or <Boolean> - this composite node OR false if unsuccessfully added
	-----------------------------------------------------------------------------*/
	["AddChildNode",compileFinal {
		params [["_childNode",nil,[createhashmap]]];
		if (isNil "_childNode") exitWith {false};
		if !(XPS_CHECK_IFC1(_childNode,XPS_BT_ifc_INode)) exitWith {false};
		_self set ["child",_childNode];
		_self;
	}],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---
		
    	<XPS_BT_ifc_INode>
		<XPS_BT_typ_Node.Init>

	Description:
		Initialization code usually called to reset the node.

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Init",compileFinal {
		private _child = _self get "child";
		if !(isNil "_child") then {
			_child call ["Init"];
		};
		_self call ["XPS_BT_typ_Node.Init",[]];
	}]
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Node.Tick>
	-----------------------------------------------------------------------------*/
]
