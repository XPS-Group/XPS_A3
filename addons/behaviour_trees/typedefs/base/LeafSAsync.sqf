#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_LeafSAsync
	<TypeDefinition>
		---prototype
		XPS_BT_typ_LeafSAsync : XPS_BT_ifc_INode, XPS_BT_typ_Node
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
	["#base", XPS_BT_typ_Node],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_LeafSAsync"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: callback
    
    	--- Prototype --- 
    	call ["callback",_status]
    	---

	Description:
		The callback which sets the status on the node after <processTick> has finished

	Parameters:
		_status - <Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["callback",compileFinal {
		private _status = _this;
		_self call ["setStatus",_status];
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
		<XPS_BT_enum_NodeType> - XPS_BT_NodeType_Leaf
	-----------------------------------------------------------------------------*/
	["NodeType",nil,[["CTOR","XPS_BT_NodeType_Leaf"]]],
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Node.Status>
	-----------------------------------------------------------------------------*/
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
	["Halt",compileFinal {		
		_handle = _self get "handle";
		if !(isNil "_handle") then {
			terminate _handle;
			_self set ["handle",nil];
		};
		_self call ["XPS_BT_typ_Node.Halt"];
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
		_self call ["XPS_BT_typ_Node.Init",[]];
		_self call ["Halt",[]];
	}],
	/*----------------------------------------------------------------------------
	Method: Tick
    
    	--- Prototype --- 
    	call ["Tick", _context]
    	---

		<XPS_BT_ifc_INode>

	Description:
		The code that begins the entire Tick cycle process. Calls proccessTick
		asynchronously in a *Scheduled* environment. Status should be <XPS_Status_Running> 
		in most cases until processTick has finished.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFinal {		
		if (isNil {_self get "handle"} && {_self call ["Status"] isEqualTo XPS_Status_Initialized}) then {	
			_self call ["preTick",_this];	
				_handle = [_self,_this] spawn {
					params ["_node","_context"];
					private _status = _node call ["processTick",_context]; 
					_node call ["callback",_status]
				};
				_self set ["handle",_handle];
		} else {
			_self call ["preTick",_this];	
		};
		if (!isNil {_self get "handle"} && {scriptDone (_self get "handle")}) then {
			_self call ["Halt"];
		};
		_self call ["postTick",_self call ["Status",[]]];
	}]
]
