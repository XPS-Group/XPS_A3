#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_typ_Parallel
	<TypeDefinition>
		---prototype
		XPS_BT_typ_Parallel : XPS_BT_ifc_INode, XPS_BT_typ_Composite
		---
    	--- Prototype --- 
    	createHashmapObject ["XPS_BT_typ_Parallel"]
    	---

Authors: 
	Crashdome

Description:
	A node that ticks all children at once.

Returns:
	<HashmapObject> of a Composite node

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_typ_Parallel"],
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
    	"XPS_BT_typ_Parallel"
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

	Returns: 
		<Enumeration> - <XPS_BT_Status_Success>, <XPS_BT_Status_Failure>, or <XPS_BT_Status_Running>,, or nil
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
	}]
	/*----------------------------------------------------------------------------
	Protected: postTick
		<XPS_BT_typ_Composite. postTick>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: tickNextChild
		<XPS_BT_typ_Composite. tickNextChild>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Blackboard
		<XPS_BT_typ_Composite. Blackboard>
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