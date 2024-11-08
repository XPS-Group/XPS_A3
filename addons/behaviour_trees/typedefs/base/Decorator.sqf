#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Decorator
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Decorator : XPS_BT_ifc_INode
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Decorator"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has one child

Returns:
	<HashmapObject> of a Decorator node
	
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Decorator"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["child",nil];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Decorator"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_ifc_INode>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_BT_ifc_INode"]],
	["#flags",["unscheduled"]],
	/* ----------------------------------------------------------------------------
	Protected: child
    
    	--- Prototype --- 
    	get "child"
    	---

	Retruns:
		<HashmapObject> - child node
	---------------------------------------------------------------------------- */
	["child",nil],
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
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self get "Status";
		private _child = _self get "child";
		if (isNil "_child") exitWith {XPS_BT_Status_Failure};
		if (isNil {_child get "Status"}) then {
			_status = _child call ["Tick",_this];
		} else {
			_status = _child get "Status";
		};		
		_status;
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
		<String> - "DECORATOR"
	-----------------------------------------------------------------------------*/
	["NodeType","DECORATOR"],
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
	Method: AddChildNode
    
    	--- Prototype --- 
    	call ["AddChildNode",[childNode]]
    	---

	Description:
		Adds a child node to this node. Subsequent calls will replace previous values

	Parameters:
		childNode - <HashmapObject> that implements the <XPS_BT_ifc_INode> interface

	Returns: 
		<Boolean> - <True> if successful otherwise <False>
	-----------------------------------------------------------------------------*/
	["AddChildNode",compileFinal {
		params [["_childNode",nil,[createhashmap]]];
		if (isNil "_childNode") exitWith {false};
		if !(CHECK_IFC1(_childNode,XPS_BT_ifc_INode)) exitWith {false};
		_self set ["child",_childNode];
		true;
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
		private _child = _self get "child";
		if !(isNil "_child") then {
			_child call ["Init"];
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
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil : <Status> property after execution
	-----------------------------------------------------------------------------*/
	["Tick",compileFinal {	
		_self call ["preTick",_this];
		_self call ["postTick",
			_self call ["processTick",_this]
		];
	}]
]