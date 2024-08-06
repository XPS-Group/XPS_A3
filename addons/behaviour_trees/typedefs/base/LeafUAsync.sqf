#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_LeafUAsync
	<TypeDefinition>
		---prototype
		XPS_BT_typ_LeafUAsync : XPS_BT_ifc_INode
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_LeafUAsync"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked. Runs processTick in *Unscheduled* code and provides
	both a <conditional> and <result> code block for determining when it has
	completed.

Returns:
	<HashmapObject> of a Leaf Node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_LeafUAsync"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_LeafUAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str",compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_BT_ifc_INode"]],
	["#flags",["unscheduled"]],
	["_startTime",0],
	/*----------------------------------------------------------------------------
	Protected: condition
    
    	--- Prototype --- 
    	call ["condition",_context]
    	---

	Description:
		The code that executes during a Tick of this node when processTick has already been called

	Must be Overridden - This type contains no functionality

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard> interface

	Returns: 
		<Boolean> - condition was ssatified
	-----------------------------------------------------------------------------*/
	["condition",{}],
	/*----------------------------------------------------------------------------
	Protected: result
    
    	--- Prototype --- 
    	call ["result",_context]
    	---

	Description:
		The code that executes during a Tick of this node when the condition has been met.

	Must be Overridden - This type contains no functionality

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>
	-----------------------------------------------------------------------------*/
	["result",{}],
	/*----------------------------------------------------------------------------
	Protected: timeout
    
    	--- Prototype --- 
    	get "timeout"
    	---
    
    Returns: 
		<Number> - the maximum time in seconds (using diag_tickTime) before a processTick will 
		automatically call it a failure
	-----------------------------------------------------------------------------*/
	["timeout",nil],
	/*----------------------------------------------------------------------------
	Protected: preTick
    
    	--- Prototype --- 
    	call ["preTick",_context]
    	---

	Description:
		The code that executes before a Tick of this node. Usually 
		propogates down the tree if possible.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["preTick",compileFinal {
		if (isNil {_self get "Status"}) then {
			private _status = XPS_BT_Status_Running;
			_self set ["Status",_status];
			_self set ["_startTime",diag_tickTime];
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
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard> interface

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
		Halts any asynchronous call by invoking a failure

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFInal {		
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
		_self set ["_startTime",0];
	}],
	/*----------------------------------------------------------------------------
	Method: Tick
    
    	--- Prototype --- 
    	call ["Tick", _context]
    	---

		<XPS_BT_ifc_INode>

	Description:
		The code that begins the entire Tick cycle process. Calls proccessTick
		in a *Unscheduled* environment but defers to a conditional check once "Running". 
		Status should be <XPS_BT_Status_Running> until condition or timeout are satisfied.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFInal {	
		
		switch (true) do {

			case (isNil {_self get "Status"}): {
				_self call ["preTick",_this];
				_self call ["processTick",_this];
			};

			case (_self call ["condition",_this]): {
				_self call ["postTick",_self call ["result",_this]];
			};

			case (diag_tickTime > ((_self get "timeout") + (_self get "_startTime"))): {
				_self call ["postTick",XPS_BT_Status_Failure];
			};
		};
	}]
]