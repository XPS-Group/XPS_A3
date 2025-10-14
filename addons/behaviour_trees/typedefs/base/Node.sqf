#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Node
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Node : XPS_BT_ifc_INode
		---
    	--- Prototype --- 
    	N/A
    	---

Authors: 
	Crashdome

Description:
	Abstract base node for a Behaviour Tree 

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Node"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Node"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_BT_ifc_INode"]],
	/*----------------------------------------------------------------------------
	Protected: preTick
    
    	--- Prototype --- 
    	call ["preTick",_context]
    	---

	Description:
		The code that executes before a Tick of this node. Usually 
		propogates down the tree if possible.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["preTick",compileFinal {
		if (isNil {_self get "Status"}) then {
			private _status = XPS_Status_Running;
			_self set ["Status",_status];
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
    
    	--- Prototype --- 
    	call ["postTick",_status]
    	---

	Description:
		The code that executes after a Tick of this node and then
		sets the <Status> property before going back up the tree.

	Parameters:
		_status - <Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
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
        
        Not Implemented in abstract base class
	-----------------------------------------------------------------------------*/
	["NodeType",nil],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
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
	Method: Halt
    
    	--- Prototype --- 
    	call ["Halt"]
    	---

	Description:
		Halts a running node and sets <Status> to failure

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFinal {
		if (_self get "Status" isEqualto XPS_Status_Running) then {
			_self call ["postTick", XPS_Status_Failure];
		};
	}],
	/*----------------------------------------------------------------------------
	Method: Tick
    
    	--- Prototype --- 
    	call ["Tick", _context]
    	---

		<XPS_BT_ifc_INode>

	Description:
		The code that begins the entire Tick cycle process.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFinal {	
		_self call ["preTick",_this];
		_self call ["postTick",
			_self call ["processTick",_this]
		];
	}]
]
