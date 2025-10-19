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
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---

    Returns:
        <True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["_status",XPS_Status_Created];
#ifdef XPS_DEBUG
		_self set ["id", [] call XPS_fnc_createUniqueID];
		_self set ["_onStatusChangedEvent",createHashmapObject [XPS_typ_Event]];
        _self set ["StatusChanged",createHashmapObject [XPS_typ_EventHandler,[_self get "_onStatusChangedEvent"]]];
		_self set ["_onPreTickEvent",createHashmapObject [XPS_typ_Event]];
        _self set ["PreTicked",createHashmapObject [XPS_typ_EventHandler,[_self get "_onPreTickEvent"]]];
		_self set ["_onPostTickEvent",createHashmapObject [XPS_typ_Event]];
        _self set ["PostTicked",createHashmapObject [XPS_typ_EventHandler,[_self get "_onPostTickEvent"]]];
#endif
	}],
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
	["_status",nil],
#ifdef XPS_DEBUG
	["_onPreTickEvent",nil],
	["_onPostTickEvent",nil],
	["_onStatusChangedEvent",nil],
	["id", nil],
#endif
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
		if (_self get "_status" isEqualTo XPS_Status_Initialized) then {
			_self call ["setStatus",XPS_Status_Running];
		};
#ifdef XPS_DEBUG
		_self get "_onPreTickEvent" call ["Invoke",[_self,["PreTicked",diag_tickTime]]];
#endif
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
		_self call ["setStatus",_this];
#ifdef XPS_DEBUG
		_self get "_onPostTickEvent" call ["Invoke",[_self,["PostTicked",diag_tickTime]]];
#endif
		_this;
	}],
	/*----------------------------------------------------------------------------
	Protected: setStatus
    
    	--- Prototype --- 
    	call ["setStatus", _status]
    	---

		<XPS_BT_ifc_INode>

	Parameters:
		_status - <Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>, or nil
    
    Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>, or nil
	-----------------------------------------------------------------------------*/
	["setStatus", compileFinal {
		private _current = _self get "_status";
		if (_this isNotEqualTo _current) then {
			_self set ["_status",_this];
#ifdef XPS_DEBUG
			_self get "_onStatusChangedEvent" call ["Invoke",[_self,["StatusChanged",_this]]];
#endif
		};
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
	Method: Status
    
    	--- Prototype --- 
    	call ["Status"]
    	---

		<XPS_BT_ifc_INode>
    
    Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["Status", compileFinal {
		_self get "_status";
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
		if (_self get "_status" isNotEqualTo XPS_Status_Initialized) then {
			_self call ["setStatus",XPS_Status_Initialized];
		};
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
		if (_self get "_status" isEqualto XPS_Status_Running) then {
			_self call ["setStatus", XPS_Status_Failure];
			diag_log format["Halt Called: %1", _self]
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
#ifdef XPS_DEBUG
    /*----------------------------------------------------------------------------
    EventHandler: PreTicked

	DEBUG ONLY
    
        --- Prototype --- 
        get "PreTicked"
        ---

        Handles Subscriptions to the onPreTickEvent

    Returns:
        <XPS_typ_EventHandler>
    ----------------------------------------------------------------------------*/
    ,["PreTicked",nil],
    /*----------------------------------------------------------------------------
    EventHandler: PostTicked

	DEBUG ONLY
    
        --- Prototype --- 
        get "PostTicked"
        ---

        Handles Subscriptions to the onPostTickEvent

    Returns:
        <XPS_typ_EventHandler>
    ----------------------------------------------------------------------------*/
    ["PostTicked",nil],
    /*----------------------------------------------------------------------------
    EventHandler: StatusChanged
    
        --- Prototype --- 
        get "StatusChanged"
        ---

		<XPS_BT_ifc_INode>

        Handles Subscriptions to the onStatusChangedEvent

    Returns:
        <XPS_typ_EventHandler>
    ----------------------------------------------------------------------------*/
    ["StatusChanged",nil]
#endif
]
