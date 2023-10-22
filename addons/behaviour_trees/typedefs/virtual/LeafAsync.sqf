#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. virtual. XPS_BT_typ_LeafAsync
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
	["#str",compileFinal {"XPS_BT_typ_LeafAsync"}],
	["#type","XPS_BT_typ_LeafAsync"],
	["@interfaces",["XPS_BT_ifc_INode"]],
	/*----------------------------------------------------------------------------
	Protected: callback
    
    	--- Prototype --- 
    	[]_self,_status] call ["callback"]
    	---

	Description:
		The callback which sets the status on the node after <processTick> has finished

	Parameters:
		_self - <HashmapObject> - this node
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["callback",compileFinal {
		params [["_self",nil,[createhashmap]],["_status",nil,[""]]];
		_self call ["postTick",[_status]];
		_self set ["handle",nil];
	}],
	/*----------------------------------------------------------------------------
	Protected: handle
    
    	--- Prototype --- 
    	get "handle"
    	---
    
    Returns: 
		<Number> - the handle of the executing script called asynchronously.
		Nil if not executing.
	-----------------------------------------------------------------------------*/
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
		returns a status to the <callback> method. 

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		params [["_self",nil,[createhashmap]],["_status",nil,[""]],["_callback",nil,[{}]]];
		[_self, _status] call _callback;
	}],
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
	["Blackboard",createhashmap],
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
	Method: Halt
    
    	--- Prototype --- 
    	call ["Halt"]
    	---

	Description:
		Halts a script called asynchronously

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFInal {		
		_handle = _self get "handle";
		terminate _handle;
		_self set ["handle",nil];
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
	}],
	/*----------------------------------------------------------------------------
	Method: Tick
    
    	--- Prototype --- 
    	call ["Tick"]
    	---

		<XPS_BT_ifc_INode>

	Description:
		The code that begins the entire Tick cycle process. Calls proccessTick
		asynchronously. Status should be RUNNING in most cases until processTick
		has finished.

	Returns: 
		_status - <String> - returns <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFInal {		
		_self call ["preTick"];	
		private _status = _self get "Status";	
		_handle = [_self, _status, _self get ["callback"]] spawn (_self get ["processTick"]);
		_self set ["handle",_handle];
		_self call ["postTick",[_status]];
	}]
]