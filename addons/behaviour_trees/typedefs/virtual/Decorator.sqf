#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. virtual. XPS_BT_typ_Decorator
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has one child

Parent:
    none

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none
	
---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: child
	<HashmapObject> - child node
---------------------------------------------------------------------------- */
[
	["#str",compileFinal {"XPS_BT_typ_Decorator"}],
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

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self get "Status";
		private _child = _self get "child";
		if (isNil "_child") exitwith {NODE_FAILURE};
		if (isNil {_child get "Status"}) then {
			_status = _child call ["Tick"];
		} else {
			_status = _child get "Status";
		};		
		_status;
	}],
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
		<String> - "DECORATOR"
	-----------------------------------------------------------------------------*/
	["NodeType","DECORATOR"],
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
    	_result = createHashmapObject ["XPS_BT_typ_Decorator"]
    	---

	Returns:
		_result - <HashmapObject> of a Decorator node
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["child",nil];
	}],
	/*----------------------------------------------------------------------------
	Method: AddChildNode
    
    	--- Prototype --- 
    	call ["AddChildNode",[childNode]]
    	---

	Description:
		Adds a child node to this node. Subsequent calls will replace previous values

	Parameters:
		childNode - <HashmapObject> that implements the <XPS_ifc_INode> interface

	Returns: 
		<Boolean> - True if successful otherwise False
	-----------------------------------------------------------------------------*/
	["AddChildNode",compileFinal {
		params [["_childNode",nil,[createhashmap]]];
		if (isNil "_childNode") exitwith {false};
		if !([_childNode, XPS_ifc_INode] call XPS_fnc_checkInterface) exitwith {false};
		_self set ["child",_childNode];
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
		private _child = _self get "child";
		if !(isNil "child") then {
			_status = _child call ["Init"];
		};
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