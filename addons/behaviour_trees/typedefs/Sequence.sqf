#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Sequence
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Sequence : XPS_BT_ifc_INode, XPS_BT_typ_Composite
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Sequence"]
    	---

Authors: 
	Crashdome

Description:
	A node that ticks children one at a time until failure.

Returns:
	<HashmapObject> of a Composite node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Sequence"],
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
    	"XPS_BT_typ_Sequence"
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
    	call ["processTick"]
    	---

	Description:
		Ticks all children at once. Any failures results in "FAILURE"

	Parameters:
		_context - <HashmapObject> or <hashmap> - typically a blackboard object that implements the <XPS_ifc_IBlackboard> interface

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
	-----------------------------------------------------------------------------*/
	["processTick",compileFinal {
		private _children = _self get "children";
		private _currentIndex = _self get "currentIndex";
		private _child = _children#_currentIndex;
		private _status = _child get "Status";

		_status = _child call ["Tick",_this];

		switch (_status) do {
			case XPS_BT_Status_Success : {
				_currentIndex = _currentIndex+1;
				if (_currentIndex < count _children) then {
					_self set ["currentIndex",_currentIndex];
					_status = XPS_BT_Status_Running;
				};
			};
			case XPS_BT_Status_Failure : {
				// Do Nothing - keep status failure
			};
			case XPS_BT_Status_Running : {
				// Do Nothing - keep index and status same
			};
			default {_status = XPS_BT_Status_Failure};
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