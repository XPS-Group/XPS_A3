#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_Engine
	<TypeDefinition>
	---prototype
	XPS_UT_typ_Engine
	---

Authors: 
	Crashdome

Description:
	An object which is a collection of Unit Test Classes that can be run
	to perform Unit Tests of other <Hashmap Objects>
 
---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_type_Engine"],
	/*----------------------------------------------------------------------------
	Constructor: #create
		---prototype
		call ["#create"]
		---

	Returns:
		True
	----------------------------------------------------------------------------*/
	["#create", {
		_self set ["_collection",createhashmapobject [
			XPS_typCollection,[createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,["XPS_typ_TestClass"]]]]];
		_self set ["classOrder",[]];
		_self set ["Selected",[]];
		_self set ["TestResults",createhashmap];
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
		"XPS_UT_type_Engine"
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
	/*----------------------------------------------------------------------------
	Protected: initTestRsults
		
		---prototype
		call ["initTestRsults"]
		---


	----------------------------------------------------------------------------*/
	["initTestRsults",{
		private _testResults = createhashmapobject [XPS_UT_typ_TestResults];
		{
			private _class = _self get "Items" get _x;

			//TODO : Should we use just a hashmap or place result directly on test class?
		} foreach (_self get "classOrder");
		_self set ["TestResults",_testRsults];

	}],
	["TestResults",createhashmap],
	["Selected",[]],
    /* -----------------------------------------------------------------------
    Method: AddClass

        ---prototype
        call ["AddClass",[_key,_item]];

		Adds item to collection and then appends identifier to classOrder <array>
    
    Parameters: 
        _key - Anything - Key used when adding to <Items> store
        _item - <HashmapObject> - to add to <Items> store

    -------------------------------------------------------------------------*/ 
	["AddClass", compileFinal {
        if !(_self get "_collection" call ["AddItem",[_key,_item]]) then {
			_self get "classOrder" pushback _key;
		};
    }],
	/*----------------------------------------------------------------------------
	Method: RunAll
		
		---prototype
		call ["RunAll"]
		---

		Runs all Tests in a Scheduled Environment
	----------------------------------------------------------------------------*/
	["RunAll",{
		_self spawn {
			private _engine = _this;
			{
				private _class = _engine get "Items" get _x;
				private _orderedList = _class get "TestOrder";
				diag_log text ((_class get "Description") + ": - BEGIN TEST");
				// Init Class
				_class call ["InitTest"];
				//Run Class Tests
				{
					try {
						_class call [_x];
						diag_log text ((_class get "Description") + ":" + _x + " -  PASSED");
					} catch {
						if (count (["XPS_UT_typ_AssertFailedException","XPS_UT_typ_AssertInconclusiveException"] arrayintersect (_exception get "#type"))>0) then {
							diag_log text  ((_class get "Description") + ":" + _x + " -  FAILED");
							diag_log (_exception call ["GetText"]);
						} else {
							throw _exception;
						};
					}
				} foreach _orderedList;
				// Finalize Class
				_class call ["FinalizeTest"];
			} foreach (_engine get "classOrder");
		};
	}],
	["RunSelected",{}]
];