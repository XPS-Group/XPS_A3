#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Inverter
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Inverter : XPS_BT_ifc_INode, XPS_BT_typ_Decorator
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Inverter"]
    	---

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has one child

Returns:
	<HashmapObject> of a Decorator node
	
---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: child
	<HashmapObject> - child node
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Inverter"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Decorator>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_Decorator],
	/*----------------------------------------------------------------------------
	Constructor: #create
		<XPS_BT_typ_Decorator. #create>
	-----------------------------------------------------------------------------*/
	["#create", {_self call ["XPS_BT_typ_Decorator.#create"];}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Inverter"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_Decorator. @interfaces>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<XPS_BT_typ_Decorator. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Decorator. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<XPS_BT_typ_Decorator. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick",_context]
    	---

	Description:
		The code that executes during a Tick of this node and then
		returns a status.

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self call ["XPS_BT_typ_Decorator.processTick",_this];
        // Invert Status
        switch (_status) do {
            case XPS_BT_Status_Success : {_status = XPS_BT_Status_Failure;};
            case XPS_BT_Status_Failure : {_status = XPS_BT_Status_Success;};
        };
		_status;
	}]
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Decorator. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<XPS_BT_typ_Decorator. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Decorator. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Decorator. Tick>
	-----------------------------------------------------------------------------*/
]