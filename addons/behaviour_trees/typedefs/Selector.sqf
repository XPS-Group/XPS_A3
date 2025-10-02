#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Selector
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Selector : XPS_BT_ifc_INode, XPS_BT_typ_Composite
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Selector"]
    	---

Authors: 
	Crashdome

Description:
	A node that ticks children one at a time until success.

Returns:
	<HashmapObject> of a Composite node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Selector"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_BT_typ_Composite>
	-----------------------------------------------------------------------------*/
	["#base",XPS_BT_typ_Composite],
	/*----------------------------------------------------------------------------
	Constructor: #create
		<XPS_BT_typ_Composite. #create>
	-----------------------------------------------------------------------------*/
	["#create", {_self call ["XPS_BT_typ_Composite.#create"];}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_BT_typ_Selector"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_BT_typ_Composite. @interfaces>
	-----------------------------------------------------------------------------*/
	/* ----------------------------------------------------------------------------
	Protected: children 
		<XPS_BT_typ_Composite. children>

	Protected: currentIndex
		<XPS_BT_typ_Composite. currentIndex>
		
	Protected: preTick
		<XPS_BT_typ_Composite. preTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: processTick
    
    	--- Prototype --- 
    	call ["processTick",_context]
    	---

	Description:
		Ticks all children at once. Any failures results in "FAILURE"

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard:core.XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_Status_Success>, <XPS_Status_Failure>, or <XPS_Status_Running>, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _children = _self get "children";
		private _currentIndex = _self get "currentIndex";

		if (_children isEqualTo []) exitWith {XPS_Status_Failure};

		private _child = _children#_currentIndex;
		private _status = _child call ["Tick",_this];

		switch (_status) do {
			case XPS_Status_Failure : {
				_currentIndex = _currentIndex+1;
				if (_currentIndex < count _children) then {
					_self set ["currentIndex",_currentIndex];
					_status = XPS_Status_Running;
				}; //else Failure
			};
			case XPS_Status_Success : {
				// Do Nothing - keep status success
			};
			case XPS_Status_Running : {
				// Do Nothing - keep index and status same
			};
			default {_status = XPS_Status_Failure};
		};
		_status;
	}]
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Composite. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: NodeType
		<XPS_BT_typ_Composite. NodeType>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Status
		<XPS_BT_typ_Composite. Status>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddChildNode
		<XPS_BT_typ_Composite. AddChildNode>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Init
		<XPS_BT_typ_Composite. Init>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Tick
		<XPS_BT_typ_Composite. Tick>
	-----------------------------------------------------------------------------*/

]
