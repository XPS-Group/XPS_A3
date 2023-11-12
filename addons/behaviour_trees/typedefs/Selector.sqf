#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Selector
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node that ticks children one at a time until success.

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
	["#type","XPS_BT_typ_Selector"],
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
		_status - <Enumeration> - <XPS_BT_Result_Success>, <XPS_BT_Result_Failure>, or <XPS_BT_Result_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _children = _self get "children";
		private _currentIndex = _self get "currentIndex";
		private _child = _children#_currentIndex;
		private _status = _child get "Status";

		_status = _child call ["Tick"];

		switch (_status) do {
			case XPS_BT_Result_Failure : {
				_currentIndex = _currentIndex+1;
				if (_currentIndex < count _children) then {
					_self set ["currentIndex",_currentIndex];
					_status = XPS_BT_Result_Running;
				}; //else Failure
			};
			case XPS_BT_Result_Success : {
				// Do Nothing - keep status success
			};
			case XPS_BT_Result_Running : {
				// Do Nothing - keep index and status same
			};
			default {_status = XPS_BT_Result_Failure};
		};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<base. XPS_BT_typ_Composite. postTick>
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
	["#create", { _self call ["XPS_BT_typ_Composite.#create"]; }]
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