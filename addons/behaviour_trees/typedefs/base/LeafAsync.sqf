#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. base. XPS_BT_typ_LeafAsync
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked. 

Parent:
    none

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#str",compileFinal {_self get "#type" select  0}],
	["#type","XPS_BT_typ_LeafAsync"],
	["@interfaces",["XPS_BT_ifc_INode"]],
	/*----------------------------------------------------------------------------
	Protected: callback
    
    	--- Prototype --- 
    	call ["callback",_status]
    	---

	Description:
		The callback which sets the status on the node after <processTick> has finished

	Parameters:
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["callback",compileFinal {
		_status = _this;
		_self call ["postTick",_status];
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
	["handle",nil],
	/*----------------------------------------------------------------------------
	Protected: preTick
    
    	--- Prototype --- 
    	call ["preTick"]
    	---

	Description:
		The code that executes before a Tick cycle of a Behaviour Tree. Usually 
		sets node to RUNNING status.

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["preTick",compileFinal {
		if (isNil {_self get "Status"}) then {
			_status = XPS_BT_Status_Running;
			_self set ["Status",_status];
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	_status = _self call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree 

		Must be Overridden

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",nil],
	/*----------------------------------------------------------------------------
	Protected: postTick
    
    	--- Prototype --- 
    	_status = _self call ["postTick",_status]
    	---

	Description:
		The code that executes after a Tick cycle of a Behaviour Tree and then
		sets the <Status> property before going back up the tree.

	Parameters:
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
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
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
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
		_self call ["postTick", XPS_BT_Status_Failure];
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
		if (isNil {_self get "handle"} && isNil {_self get "Status"}) then {	
			_self call ["preTick"];	
				_handle = _self spawn {
					private _status = _this call ["processTick"]; 
					_this call ["callback",_status]
				};
				_self set ["handle",_handle];
			_self call ["postTick",_status];
		};
		_self get "Status";
	}]
]