#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Parallel
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node that ticks all children at once.

Parent:
    virtual. XPS_BT_typ_Composite>

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: children 
	<Array> - of child nodes

Protected: currentIndex
	<Number> - current tasked index of children nodes
	
---------------------------------------------------------------------------- */
[
	["#str",{"XPS_BT_typ_Parallel"}],
	["#type","XPS_BT_typ_Parallel"],
	["#base",XPS_BT_typ_Composite],
	/*----------------------------------------------------------------------------
	Protected: preTick
		<virtual. XPS_BT_typ_Composite. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	_status = _self call ["processTick"]
    	---

	Description:
		Ticks all children at once. Any failures results in "FAILURE"

	Returns: 
		_status - <String> - "RUNNING", "SUCCESS", "FAILURE", or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _children = _self get "children";
		private _finalStatus = NODE_SUCCESS;

		while {(_self get "currentIndex") < count _children} do {
			private _status = _self call ["tickNextChild"];
		};

		for "_i" from 0 to (count _children)-1 do {
			private _status = (_children#_index) get "Status";
			if (_status == NODE_FAILURE) then {_finalStatus == NODE_FAILURE};
			if (_status == NODE_RUNNING && !(_finalStatus == NODE_FAILURE)) then {_finalStatus == NODE_RUNNING};
		};
		_finalStatus;
	}]
	/*----------------------------------------------------------------------------
	Protected: postTick
		<virtual. XPS_BT_typ_Composite. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: tickNextChild
		<virtual. XPS_BT_typ_Composite. tickNextChild>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<virtual. XPS_BT_typ_Composite. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<virtual. XPS_BT_typ_Composite. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<virtual. XPS_BT_typ_Composite. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
		<virtual. XPS_BT_typ_Composite. #create>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<virtual. XPS_BT_typ_Composite. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<virtual. XPS_BT_typ_Composite. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<virtual. XPS_BT_typ_Composite. Tick>
	-----------------------------------------------------------------------------*/

]