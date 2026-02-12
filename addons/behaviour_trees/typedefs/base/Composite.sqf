#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Composite
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Composite : XPS_BT_ifc_INode, XPS_BT_typ_Node
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Composite"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has multiple children

Returns:
	<HashmapObject> of a Composite node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Composite"],
	["#base", XPS_BT_typ_Node],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---

    Returns:
        <True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self call ["XPS_BT_typ_Node.#create",[]];
		_self set ["children",[]];
		_self set ["currentIndex",0];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Composite"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	/* ----------------------------------------------------------------------------
	Protected: children 
    
    	--- Prototype --- 
    	get "children"
    	---

	Returns:
		<Array> - of child nodes		
	---------------------------------------------------------------------------- */
	["children",[]],
	/* ----------------------------------------------------------------------------
	Protected: currentIndex
    
    	--- Prototype --- 
    	get "currentIndex"
    	---

	Returns:
		<Number> - current tasked index of child nodes
	---------------------------------------------------------------------------- */
	["currentIndex",0],
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
		<XPS_BT_enum_NodeType> - XPS_BT_NodeType_Composite
	-----------------------------------------------------------------------------*/
	["NodeType",nil,[["CTOR","XPS_BT_NodeType_Composite"]]],
	["NodeType",nil,[["CTOR","XPS_BT_NodeType_Composite"]]],
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Node.Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddChildNode
    
    	--- Prototype --- 
    	call ["AddChildNode",[childNode,_index]]
    	---

	Description:
		Adds a child node at the specified index. If index is out of bounds or unspecified,
		it will append the child to the index. 

	Parameters:
		childNode - <HashmapObject> that implements the <XPS_BT_ifc_INode> interface
		_index* - (optional - Default : -1) - the index in which to place the child node

	Returns: 
		<Hashmapobject> or <Boolean> - this composite node OR false if unsuccessfully added
	-----------------------------------------------------------------------------*/
	["AddChildNode",compileFinal {
		params [["_childNode",nil,[createhashmap]],["_index",-1,[0]]];
		if (isNil "_childNode") exitWith {false};
		if !( XPS_CHECK_IFC1(_childNode,XPS_BT_ifc_INode) ) exitWith {false};

		private _children = _self get "children";
		private _count = count (_children);
		if (_index < 0 ||_index >= _count) then {_index = -1};
		_children insert [_index,[_childNode]];
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
		_self set ["currentIndex",0];
		private _children = _self get "children";
		{
			if !(isNil "_x") then {
				_x call ["Init"];
			};
		} forEach _children;
		_self call ["XPS_BT_typ_Node.Init",[]];
	}]
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Node.Tick>
	-----------------------------------------------------------------------------*/
]
