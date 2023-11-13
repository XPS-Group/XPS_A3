#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Parallel
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node that ticks all children at once.

Parent:
    <base. XPS_BT_typ_Composite>

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: children 
		<base. XPS_BT_typ_Composite. children>

Protected: currentIndex
		<base. XPS_BT_typ_Composite. currentIndex>
	
---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Parallel"],
	["#base",XPS_BT_typ_Composite],
	/*----------------------------------------------------------------------------
	Protected: preTick
		<base. XPS_BT_typ_Composite. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	_status = _self call ["processTick"]
    	---

	Description:
		Ticks all children at once. Any failures results in "FAILURE"

	Returns: 
		_status - <Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _children = _self get "children";
		private _finalStatus = XPS_BT_Status_Success;

		while {(_self get "currentIndex") < count _children} do {
			private _currentIndex = _self get "currentIndex";

			(_children select _currentIndex) call ["Tick"];
			
			if (_currentIndex < count _children-1) then {
				_self set ["currentIndex",_currentIndex+1];
			} else {_self set ["currentIndex",0];};
		};

		for "_i" from 0 to (count _children)-1 do {
			private _status = (_children#_index) get "Status";
			if (_status isEqualTo XPS_BT_Status_Failure) then {_finalStatus = XPS_BT_Status_Failure};
			if (_status isEqualTo XPS_BT_Status_Running && !(_finalStatus isEqualTo XPS_BT_Status_Failure)) then {_finalStatus = XPS_BT_Status_Running};
		};
		_finalStatus;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<base. XPS_BT_typ_Composite. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: tickNextChild
		<base. XPS_BT_typ_Composite. tickNextChild>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<base. XPS_BT_typ_Composite. Blackboard>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<base. XPS_BT_typ_Composite. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<base. XPS_BT_typ_Composite. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
		<base. XPS_BT_typ_Composite. #create>
	-----------------------------------------------------------------------------*/
	["#create", {_self call ["XPS_BT_typ_Composite.#create"];}]
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<base. XPS_BT_typ_Composite. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<base. XPS_BT_typ_Composite. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<base. XPS_BT_typ_Composite. Tick>
	-----------------------------------------------------------------------------*/

]