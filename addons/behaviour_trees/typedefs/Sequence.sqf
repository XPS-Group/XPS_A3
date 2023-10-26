#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Sequence
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node that ticks children one at a time until failure.

Parent:
    virtual. XPS_BT_typ_Composite>

Implements:
    <XPS_BT_ifc_INode>

Flags:
    none

---------------------------------------------------------------------------- */
/* ----------------------------------------------------------------------------
Protected: children 
		<virtual. XPS_BT_typ_Composite. children>

Protected: currentIndex
		<virtual. XPS_BT_typ_Composite. currentIndex>
	
---------------------------------------------------------------------------- */
[
	["#str",compileFinal {"XPS_BT_typ_Sequence"}],
	["#type","XPS_BT_typ_Sequence"],
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
		private _currentIndex = _self get "currentIndex";
		private _child = _children#_currentIndex;
		private _status = _child get "Status";

		_status = _child call ["Tick"];

		switch (_status) do {
			case NODE_SUCCESS : {
				_currentIndex = _currentIndex+1;
				if (_currentIndex < count _children) then {
					_self set ["currentIndex",_currentIndex];
					_status = NODE_RUNNING;
				};
			};
			case NODE_FAILURE : {
				// Do Nothing - keep status failure
			};
			case NODE_RUNNING : {
				// Do Nothing - keep index and status same
			};
			default {_status = NODE_FAILURE};
		};
		_status;
	}],
	/*----------------------------------------------------------------------------
	Protected: postTick
		<virtual. XPS_BT_typ_Composite. postTick>
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
	["#create", {_self call ["XPS_BT_typ_Composite.#create"];}]
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