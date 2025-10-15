#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_LeafUAsync
	<TypeDefinition>
		---prototype
		XPS_BT_typ_LeafUAsync : XPS_BT_ifc_INode, XPS_BT_typ_Node
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
	["#base", XPS_BT_typ_Node],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_LeafUAsync"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
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
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Boolean> - condition was ssatified
	-----------------------------------------------------------------------------*/
	["condition",{true}],
	/*----------------------------------------------------------------------------
	Protected: result
    
    	--- Prototype --- 
    	call ["result",_context]
    	---

	Description:
		The code that executes during a Tick of this node when the condition has been met. Default is to simply return <Success:XPS_Status_Success>

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>
	-----------------------------------------------------------------------------*/
	["result",{XPS_Status_Success}],
	/*----------------------------------------------------------------------------
	Protected: timeout
    
    	--- Prototype --- 
    	get "timeout"
    	---
    
    Returns: 
		<Number> - the maximum time in seconds (using diag_tickTime) before a processTick will 
		automatically call it a failure
	-----------------------------------------------------------------------------*/
	["timeout",0],
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
		returns a status when either the timeout is reached, the condition
		is met, or when <Halt> is executed.

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
		Halts any asynchronous call by invoking a failure and setting <starttime> to 0

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFinal {		
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
		Status should be <XPS_Status_Running> until condition or timeout are satisfied.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFinal {	
		
		switch (true) do {

			case (_self call ["Status",[]] isNotEqualTo XPS_Status_Running): {
				_self call ["preTick",_this];
				_self call ["processTick",_this];
			};
			case (diag_tickTime > ((_self get "timeout") + (_self get "_startTime"))):{
				_self call ["Halt"];
			};
			case (_self call ["condition",_this]): {
				_self call ["postTick",_self call ["result",_this]];
			};
		};
	}]
]
