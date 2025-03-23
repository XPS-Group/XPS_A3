#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Leaf
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Leaf : XPS_BT_ifc_INode
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Leaf"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has an <ProcessTick> method which is 
	called when Ticked

Returns:
	<HashmapObject> of a Leaf Node
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Leaf"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Leaf"
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