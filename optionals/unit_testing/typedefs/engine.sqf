#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_Engine
	<TypeDefinition>
	---prototype
	XPS_UT_typ_Engine : core.XPS_ifc_ICollection, core.XPS_ifc_ITypeRestrictor, core.XPS_typ_TypeCollection
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
	Parent: #base
		<core. XPS_typ_TypeCollection>
	----------------------------------------------------------------------------*/
	["#base",XPS_typ_TypeCollection],
	/*----------------------------------------------------------------------------
	Constructor: #create
		<XPS_typ_TypeCollection.#create> with added parameters to constrain allowed 
		types to <XPS_UT_typ_TestClass>
	----------------------------------------------------------------------------*/
	["#create", {
		_self call ["XPS_typ_TypeCollection.#create",[createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,["XPS_typ_TestClass"]]]];
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
	Protected: classOrder
		
		---prototype
		get "classOrder"
		---

	Returns:
		<Array> - of Class Names in the order they should be run
	----------------------------------------------------------------------------*/
	["classOrder",[],[["CTOR"]]],
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
    Method: AddItem

        ---prototype
        call ["AddItem",[_key,_item]];
        ---

        <core. XPS_ifc_ITypeCollection>

		Overrides base class method : <core. XPS_typ_TypeCollection. AddItem>

		Performs base method and then appends identifier to classOrder <array>
    
    Parameters: 
        _key - Anything - Key used when adding to <Items> store
        _item - <HashmapObject> - to add to <Items> store

    Returns:
        <Boolean> - True if successfully added, otherwise False

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(_self call ["XPS_typ_TypeCollection.AddItem",[_key,_item]]) then {
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