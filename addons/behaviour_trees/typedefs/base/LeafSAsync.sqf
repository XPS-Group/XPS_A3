#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_LeafSAsync
	<TypeDefinition>
		---prototype
		XPS_BT_typ_LeafSAsync : XPS_BT_ifc_INode
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_LeafSAsync"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked. Runs processTick in *Scheduled* code. <processTick>
	will provide the condition and final status.

Returns:
	<HashmapObject> of a Leaf Node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_LeafSAsync"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_LeafSAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str",compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
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
    	call ["preTick",_context]
    	---

	Description:
		The code that executes before a Tick of this node. Usually 
		propogates down the tree if possible.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <core.XPS_ifc_IBlackboard> interface

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
    	call ["processTick",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status.

	Must be Overridden - This type contains no functionality

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <core.XPS_ifc_IBlackboard> interface

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
		The code that executes after a Tick of this node and then
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
    	call ["Tick", _context]
    	---

		<XPS_BT_ifc_INode>

	Description:
		The code that begins the entire Tick cycle process. Calls proccessTick
		asynchronously in a *Scheduled* environment. Status should be <XPS_BT_Status_Running> 
		in most cases until processTick has finished.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFInal {		
		if (isNil {_self get "handle"} && isNil {_self get "Status"}) then {	
			_self call ["preTick",_this];	
				_handle = [_self,_this] spawn {
					params ["_node","_context"];
					private _status = _node call ["processTick",_context]; 
					_node call ["callback",_status]
				};
				_self set ["handle",_handle];
			_self call ["postTick",_self get "Status"];
		};
		_self get "Status";
	}]
]