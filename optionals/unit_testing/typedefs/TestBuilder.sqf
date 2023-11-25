#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestBuilder
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestBuilder
	---

Authors: 
	Crashdome

Description:
	An object which is a collection of Unit Test Classes that can build a
	collection of UnitTests.
 
---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_type_TestBuilder"],
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
			XPS_typCollection,[createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_typ_TestClass"]]]]]];
		_self set ["classOrder",[]];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		noCopy
	----------------------------------------------------------------------------*/
	["#flags",["sealed","nocopy"]],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_UT_type_TestBuilder"
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
        if !(_self get "_collection" call ["AddItem",[_key,_item]]) then {
			_self get "classOrder" pushback _key;
		};
    }],
    /* -----------------------------------------------------------------------
    Method: BuildUnitTests

        ---prototype
        call ["BuildUnitTests"];

		Builds a UnitTest Collection from added <XPS_typ_TestClasses: XPS_typ_TestClass>.

    -------------------------------------------------------------------------*/ 
	["BuildUnitTests",{
		private _dataArray = [];
		private _classOrder = _self get "_classOrder";
		{
			private _class = _self get "_collection" get _x;
			_dataArray pushback (createhashmapobject ["XPS_UT_typ_UnitTest",[_class, ""]]);
			private _methodOrder = _class get "TestOrder";
			{
				_dataArray pushback (createhashmapobject ["XPS_UT_typ_UnitTest",[_class, _x]]);
			} foreach _methodOrder;
		} foreach _classOrder;
		_dataArray;
	}]
];