#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. base. XPS_BT_typ_Inverter
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node for a Behaviour Tree that has one child

Parent:
    <virtual. XPS_BT_typ_Decorator>

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
	["#str",{"XPS_BT_typ_Inverter"}],
	["#type","XPS_BT_typ_Inverter"],
	["#base",XPS_BT_typ_Decorator],
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<virtual. XPS_BT_typ_Decorator. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<virtual. XPS_BT_typ_Decorator. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<virtual. XPS_BT_typ_Decorator. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: preTick
		<virtual. XPS_BT_typ_Decorator. preTick>
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
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _status = _self call ["XPS_BT_typ_Decorator.processTick"];
        // Invert Status
        switch (_status) do {
            case NODE_SUCCESS : {_status = NODE_FAILURE;};
            case NODE_FAILURE : {_status = NODE_SUCCESS;};
        };
		_status;
	}]
	/*----------------------------------------------------------------------------
	Protected: postTick
		<virtual. XPS_BT_typ_Decorator. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
		<virtual. XPS_BT_typ_Decorator. #create>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<virtual. XPS_BT_typ_Decorator. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<virtual. XPS_BT_typ_Decorator. Tick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<virtual. XPS_BT_typ_Decorator. Tick>
	-----------------------------------------------------------------------------*/
]