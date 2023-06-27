#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. virtual. XPS_BT_typ_Leaf
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked

Parent:
    none

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#str",compileFinal {"XPS_BT_typ_Leaf"}],
	["#type","XPS_BT_typ_Leaf"],
	["@interfaces",["XPS_BT_ifc_INode"]],
	/*----------------------------------------------------------------------------
	Protected: preTick
    
    	--- Prototype --- 
    	_self call ["preTick"]
    	---

	Description:
		The code that executes before a Tick cycle of a Behaviour Tree. Usually 
		sets node to RUNNING status.

	Returns: 
		Nothing
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
	["processTick",nil],
	/*----------------------------------------------------------------------------
	Protected: postTick
    
    	--- Prototype --- 
    	_status = _self call ["postTick",[_status]]
    	---

	Description:
		The code that executes after a Tick cycle of a Behaviour Tree and then
		sets the <Status> property before going back up the tree.

	Parameters:
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil

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

		<XPS_BT_ifc_INode>
    
    Returns: 
		<HashmapObject> - A blackboard for use in nodes
	-----------------------------------------------------------------------------*/
	["Blackboard",nil],
	/*----------------------------------------------------------------------------
	Property: NodeType
    
    	--- Prototype --- 
    	get "NodeType"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<String> - "LEAF"
	-----------------------------------------------------------------------------*/
	["NodeType","LEAF"],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<String> - should only return "SUCCESS", "FAILED", "RUNNING", or <nil>
	-----------------------------------------------------------------------------*/
	["Status",nil],
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
		_status - <String> - returns <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFInal {		
		_self call ["preTick"];
		_self call ["postTick",
			_self call ["processTick"]
		];
	}]
]