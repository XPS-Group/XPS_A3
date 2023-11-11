#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_Engine
	<TypeDefintion>

Authors: 
	Crashdome

Description:
	An object which is a collection of Unit Test Classes that can be run
	to perform Unit Tests of other <Hashmap Objects>

Parent:
	none

Implements: 
	none

Flags: 
	NoCopy
	Sealed

---------------------------------------------------------------------------- */
[
	["#str", {_self get "#type" select  0}],
	["#type","XPS_UT_type_Engine"],
	["#flags",["sealed","nocopy"]],
	["#base",XPS_typ_HashmapCollection],
	["initTestRsults",{
		private _testResults = createhashmapobject [XPS_UT_typ_TestResults];
		{
			private _class = _self get "Items" get _x;

			//TODO : Should we use just a hashmap or place result directly on test class?
		} foreach (_self get "classOrder");
		_self set ["TestResults",_testRsults];

	}],
	["#create", {
		_self call ["XPS_typ_HashmapCollection.#create",[]];
	}],
	["Selected",[]],
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
	["RunSelected",{}],
    /* -----------------------------------------------------------------------
    Method: AddItem

        ---prototype
        call ["AddItem",[_key,_item]];
        ---

        <XPS_ifc_ICollection>

		Overrides base class method : <main. XPS_typ_HashmapCollection. AddItem>

		Performs base method and then appends identifier to classOrder <array>
    
    Parameters: 
        _key - Anything - Key used when adding to <Items> store
        _item - <HashmapObject> - to add to <Items> store

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[createhashmap]]]) exitwith {false;};
        if !(_self call ["XPS_typ_HashmapCollection.AddItem",[_key,_item]]) exitwith {false};
		_self get "classOrder" pushback _key;
    }],
	["classOrder",[],[["CTOR"]]],
	["TestResults",createhashmap]
];