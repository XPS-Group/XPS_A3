#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Composite
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Composite : XPS_BT_ifc_INode
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
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["children",[]];
		_self set ["currentIndex",0];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Composite"
    	---
	-----------------------------------------------------------------------------*/
	["#str",compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_BT_ifc_INode"]],
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
    
    	--- Prototype --- 
    	call ["preTick"]
    	---

	Description:
		The code that executes before a Tick cycle of a Behaviour Tree. Usually 
		propogates down the tree if possible.

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["preTick",compileFinal {
		if (isNil {_self get "Status"}) then {
			private _status = XPS_BT_Status_Running;
			_self set ["Status",_status];
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status.

	Must be Overridden

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick", {}],
	/*----------------------------------------------------------------------------
	Protected: postTick
    
    	--- Prototype --- 
    	call ["postTick",_status]
    	---

	Description:
		The code that executes after a Tick cycle of a Behaviour Tree and then
		sets the <Status> property before going back up the tree.

	Parameters:
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["postTick",compileFinal {
		_self set ["Status",_this];
		_this;
	}],
	/*----------------------------------------------------------------------------
	Property: Blackboard
    
    	--- Prototype --- 
    	get "Blackboard"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<HashmapObject> - A blackboard for use in nodes
	-----------------------------------------------------------------------------*/
	["Blackboard",createhashmap],
	/*----------------------------------------------------------------------------
	Property: NodeType
    
    	--- Prototype --- 
    	get "NodeType"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<String> - "COMPOSITE"
	-----------------------------------------------------------------------------*/
	["NodeType","COMPOSITE"],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Status",nil],
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
		<Boolean> - <True> if successful otherwise <False>
	-----------------------------------------------------------------------------*/
	["AddChildNode",compileFinal {
		params [["_childNode",nil,[createhashmap]],["_index",-1,[0]]];
		if (isNil "_childNode") exitwith {false};
		if !( CHECK_IFC1(_childNode,XPS_BT_ifc_INode) ) exitwith {false};

		private _children = _self get "children";
		private _count = count (_children);
		if (_index < 0 ||_index >= _count) then {_index = -1};
		_children insert [_index,[_childNode]];
		_childNode set ["Blackboard",_self get "Blackboard"];
		true;
	}],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---

		<XPS_BT_ifc_INode>

	Description:
		Initialization code usually called to reset the node.

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Init",compileFinal {
		_self set ["Status",nil];
		_self set ["currentIndex",0];
		private _children = _self get "children";
		{
			if !(isNil "_x") then {
				_x call ["Init"];
			};
		} foreach _children;
	}],
	/*----------------------------------------------------------------------------
	Method: Tick
    
    	--- Prototype --- 
    	call ["Tick"]
    	---

		<XPS_BT_ifc_INode>

	Description:
		The code that begins the entire Tick cycle process.

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFInal {	
		_self call ["preTick"];
		_self call ["postTick",
			_self call ["processTick"]
		];
	}]
]