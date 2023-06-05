#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. base. XPS_BT_typ_Selector
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A node that ticks children one at a time until success.

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
	["#str",{"XPS_BT_typ_Selector"}],
	["#type","XPS_BT_typ_Selector"],
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

		if (isNil "_status") then {_status = _child call ["Tick"];};

		switch (_status) do {
			case NODE_FAILURE : {
				_currentIndex = _currentIndex+1;
				if (_currentIndex < count _children) then {
					_self set ["currentIndex",_currentIndex];
					_status = NODE_RUNNING;
				}; //else Failure
			};
			case NODE_SUCCESS : {
				// Do Nothing - keep status success
			};
			case NODE_RUNNING : {
				// Do Nothing - keep index and status same
			};
			default {_status = NODE_FAILURE};
		};
		_status;
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