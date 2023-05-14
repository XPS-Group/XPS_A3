#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. virtual. XPS_BT_typ_Composite
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has multiple children

Parent:
    none

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: children 
	<Array> - of child nodes

Protected: currentIndex
	<Number> - current tasked index of children nodes
	
---------------------------------------------------------------------------- */
[
	["#str",{"XPS_BT_typ_Composite"}],
	["#interfaces",["XPS_BT_ifc_INode"]],
	/*----------------------------------------------------------------------------
	Protected: preTick
    
    	--- Prototype --- 
    	_self call ["preTick"]
    	---

	Description:
		The code that executes before a Tick cycle of a Behaviour Tree. Usually 
		propogates down the tree if possible.

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["preTick",compileFinal {
		if (isNil {_self get "Status"}) then {
			_status = NODE_RUNNING;
			_self set ["Status",_status];
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	_status = _self call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status.

	Must be Overridden

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",{}],
	/*----------------------------------------------------------------------------
	Protected: postTick
    
    	--- Prototype --- 
    	_status = _self call ["postTick",_status]
    	---

	Description:
		The code that executes after a Tick cycle of a Behaviour Tree and then
		sets the <Status> property before going back up the tree.

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["postTick",compileFinal {
		params ["_status",nil,[""]];
		_self set ["Status",_status];
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: tickNextChild
    
    	--- Prototype --- 
    	_status = _self call ["tickNextChild"]
    	---

	Description:
		Ticks next child in the array of children

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["tickNextChild",compileFinal{
		private _currentIndex = _self get "currentIndex";
		private _children = _self get "children";
		if (_currentIndex >= count _children) exitwith {nil};
		if (_currentIndex < 0) then {_currentIndex = 0};
		private _child = _children#_currentIndex;
		if !(isNil "_child") then {
			_self set ["currentIndex",_currentIndex+1];
			_status = _child call ["Tick"];
		};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Property: Blackboard
    
    	--- Prototype --- 
    	get "Blackboard"
    	---
    
    Returns: 
		<HashmapObject> - A blackboard for use in nodes
	-----------------------------------------------------------------------------*/
	["Blackboard",nil],
	/*----------------------------------------------------------------------------
	Property: NodeType
    
    	--- Prototype --- 
    	get "NodeType"
    	---
    
    Returns: 
		<String> - "COMPOSITE"
	-----------------------------------------------------------------------------*/
	["NodeType","COMPOSITE"],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---
    
    Returns: 
		<String> - should only return "SUCCESS", "FAILED", "RUNNING", or <nil>
	-----------------------------------------------------------------------------*/
	["Status",nil],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_BT_typ_Composite"]
    	---

	Returns:
		_result - <HashmapObject> of a Composite node
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["children",[]];
		_self set ["currentIndex",0];
	}],
	/*----------------------------------------------------------------------------
	Method: AddChildNode
    
    	--- Prototype --- 
    	call ["AddChildNode",[childNode,_index]]
    	---

	Description:
		Adds a child node at the specified index. If index is out of bounds or unspecified,
		it will append the child to the index. 

	Parameters:
		childNode - <HashmapObject> that implements the <XPS_ifc_INode> interface
		_index* - (optional - Default : -1) - the index in which to place the child node

	Returns: 
		<Boolean> - True if successful otherwise False
	-----------------------------------------------------------------------------*/
	["AddChildNode",compileFinal {
		params [["_childNode",nil,[createhashmap]],["_index",-1,[0]]];
		if (isNil "_childNode") exitwith {false};
		if !([_childNode, ["XPS_ifc_INode"]] call XPS_fnc_checkInterface) exitwith {false};
		private _children = _self get "children";
		private _count = count (_children);
		if (_index < 0 ||_index >= _count) then {_index = -1};
		_children insert [_index,_childNode];
		_childNode set ["Blackboard",_self get "Blackboard"];
		true;
	}],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---

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
				_status = _x call ["Init"];
			};
		} foreach _children;
	}],
	/*----------------------------------------------------------------------------
	Method: Tick
    
    	--- Prototype --- 
    	call ["Tick"]
    	---

	Description:
		The code that begins the entire Tick cycle process.

	Returns: 
		_status - <String> - returns <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFInal {		
		_self call ["preTick"];
		_self call ["postTick",
			_self call ["processTick"]
		];
	}]
]