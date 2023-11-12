#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Inverter
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has one child

Parent:
    <base. XPS_BT_typ_Decorator>

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none
	
---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: child
	<HashmapObject> - child node
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Inverter"],
	["#base",XPS_BT_typ_Decorator],
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<base. XPS_BT_typ_Decorator. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<base. XPS_BT_typ_Decorator. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<base. XPS_BT_typ_Decorator. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<base. XPS_BT_typ_Decorator. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	_status = _self call ["processTick"]
    	---

	Description:
		The code that executes during a Tick cycle of a Behaviour Tree and then
		returns a status.

	Returns: 
		_status - <Enumeration> - <XPS_BT_Result_Success>, <XPS_BT_Result_Failure>, or <XPS_BT_Result_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self call ["XPS_BT_typ_Decorator.processTick"];
        // Invert Status
        switch (_status) do {
            case XPS_BT_Result_Success : {_status = XPS_BT_Result_Failure;};
            case XPS_BT_Result_Failure : {_status = XPS_BT_Result_Success;};
        };
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<base. XPS_BT_typ_Decorator. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
		<base. XPS_BT_typ_Decorator. #create>
	-----------------------------------------------------------------------------*/
	["#create", {_self call ["XPS_BT_typ_Decorator.#create"];}]
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<base. XPS_BT_typ_Decorator. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<base. XPS_BT_typ_Decorator. Tick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<base. XPS_BT_typ_Decorator. Tick>
	-----------------------------------------------------------------------------*/
]