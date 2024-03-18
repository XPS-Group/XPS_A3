#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestClasses
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestClasses
	---

Authors: 
	Crashdome

Description:
	An object which is a collection of Unit Test Classes that can build a
	collection of UnitTests.
 
---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_type_TestClasses"],
	/*----------------------------------------------------------------------------
	Constructor: #create
		---prototype
		call ["#create"]
		---

	Returns:
		<True>
	----------------------------------------------------------------------------*/
	["#create", {
		_self set ["_collection",createhashmapobject [
			XPS_typ_TypeCollection,[createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_UT_typ_TestClass"]]]]]];
		_self set ["classOrder",[]];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		noCopy
	----------------------------------------------------------------------------*/
	//["#flags",["sealed","nocopy"]],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_UT_type_TestClasses"
		---
	----------------------------------------------------------------------------*/
	["#str", {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<core. XPS_ifc_ICollection>
		<core. XPS_ifc_ITypeRestrictor>
	----------------------------------------------------------------------------*/
	["_collection",nil],
	/*----------------------------------------------------------------------------
	Protected: classOrder
		
		---prototype
		get "classOrder"
		---

	Returns:
		<Array> - of Class Names in the order they should be run
	----------------------------------------------------------------------------*/
	["classOrder",[]],
    /* -----------------------------------------------------------------------
    Method: AddClass

        ---prototype
        call ["AddClass",[_key,_item]];

		Adds item to collection and then appends identifier to classOrder <array>
    
    Parameters: 
        _key - <Anything> - Key used when adding to <Items> store
        _item - <HashmapObject> - to add to <Items> store

    -------------------------------------------------------------------------*/ 
	["AddClass", compileFinal {
		params [["_key",nil,[""]],["_item",createhashmap,[createhashmap]]];
        _self get "classOrder" pushback (_self get "_collection" call ["AddItem",[_key,_item]]);
    }],
    /* -----------------------------------------------------------------------
    Method: GetClasses

        ---prototype
        call ["GetClasses"];

		Gets Collection from added <XPS_typ_TestClasses: XPS_typ_TestClass>.

    -------------------------------------------------------------------------*/ 
	["GetClasses",{
		private _dataArray = [];
		private _classOrder = _self get "classOrder";
		{
			private _class = _self get "_collection" call ["GetItem",_x];
			_dataArray pushback _class;
		} foreach _classOrder;
		_dataArray;
	}]
];