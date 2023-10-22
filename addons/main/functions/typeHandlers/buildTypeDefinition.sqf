#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_buildTypeDefinition
	
	---prototype
	_typeDefintion = [_type] call XPS_fnc_buildTypeDefinition
	---

	---prototype
	_typeDefintion = [_type, true] call XPS_fnc_buildTypeDefinition
	---

Description:
    Used to define a global declaration for a <Hashmap> or <HashmapObject> 

	Has extra enhancements for inheritance and interfacing by looking for the following keys:

	_<String> - any string starting with an underscore is obfuscated by replacing the key and references to that key in code blocks with
	a unique identifier every time the type definition is rebuilt. See <XPS_fnc_preprocessTypeDefinition> for more info

	@<String> - any key named as such with an @ symbol and also has an <array> value type, will be appended. For example, "@MyArray" key in parent
	with a value of [1,2,3] and a child type which inherits but has a value of [4,5,6] will become [1,2,3,4,5,6]. The most common usage 
	will be the special "@interfaces" key which is used in checking Method/Property compliance. 

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _type 

<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Optional: _allowNils* 

<Boolean> - (optional) default: true - used to allow keys with nil values when checking interface validity

Optional: _preprocess* 

<Boolean> - (optional) default: true - determines if array should be preprocessed. 
See <XPS_fnc_preprocessinition> for more info.

Return: _typeDefinition
	<TypeDefinition> - or False if error

Example: No Inheritance
    --- Code
		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'
    ---

Example: Implements Interface
    --- Code
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];
		
		//This FAILS because PropertyA and Method do not exist
		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["@interfaces",["MyInterface"]],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		//Does not fail because PropertyA and Method exist
		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["@interfaces",["MyInterface"]],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'
    ---

Example: Implements Interface with Inheritance
    --- Code
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];

		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["@interfaces",["MyInterface"]],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		MyTypeDefB = [["#str",compileFinal {"TAG_TypeB"}],["#base", MyTypeDefA ],["PropertyA","Goodbye"],["Method",compileFinal {hint "Bye"}]];
        TAG_TypeB = ["MyTypeDefB"] call XPS_fnc_buildTypeDefinition; 

		// Both TypeA and TypeB will implement interface from inheritance but PropertyA and Method are overridden in TypeB 
		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'

		private _myObjB = createhashmapobject [TypeB];
		_myObj call ["Method"] //hints 'Bye'
    ---

---------------------------------------------------------------------------- */
if !(params [["_type",nil,[[]]],"_allowNils","_preprocess","_noStack"]) exitwith {false;};
_allowNils = [_allowNils] param [0,true,[true]];
_preprocess = [_preprocess] param [0,true,[true]];
_noStack = [_noStack] param [0,false,[true]];

private _fnc_recurseBases = {
	params ["_hashmap"];
	if ("#base" in keys _hashmap) then {
		private _base = createhashmapfromarray (_hashmap get "#base");
		[_base] call _fnc_recurseBases;
		_hashmap merge _base;
	};
};

if (_preprocess) then {
	if !([_type] call XPS_fnc_preprocessTypeDefinition) exitwith {false;};
};

private _hashmap = createhashmapfromarray _type;
private _preCompiled = _hashmap; // In case it doesn't have a parent, we need this for later

// Check for parent type
if ("#base" in keys _hashmap) then {
	private _pType = _hashmap get "#base";
	if (isNil {_pType} || !(typename _pType == "ARRAY")) exitwith {
		diag_log (format ["XPS_fnc_buildTypeDefinition: Type:%1 does not have a valid #base type definition. #base:%2",_hashmap get "#type",_hashmap get "#base"]);
	};

	_preCompiled = createhashmapfromarray _pType;


	private _pTypeName = _preCompiled get "#type";
	private _keys = keys _hashmap;
	{
		// Create base methods as "ParentType.Method"
		if (!(isNil {_pTypeName}) && {_x in _keys && typename _x isEqualTo "STRING" && typename _y isEqualTo "CODE"}) then {_hashmap set [format["%1.%2",_pTypeName,_x],_y];};

		// Append keys using @ 
		if (_x in _keys && typename _x isEqualTo "STRING") then {
			if ((_x find "@") == 0 && typename _y in ["ARRAY","HASHMAP"]) then {
				private _appendableValue = _hashmap getorDefault [_x,false];
				if (_appendableValue isEqualType _y) then {
					switch (typeName _appendableValue) do {
						case "ARRAY" : {
							if (_x isEqualTo "@interfaces") then {
								_appendableValue = +_appendableValue;
								_appendableValue insert [0,_y,true];
								_hashmap set ["@interfaces",_appendableValue]; // unique Values only for interfaces
							} else {
								_appendableValue = +_appendableValue;
								_appendableValue insert [0,_y];
								_hashmap set [_x,_appendableValue]; // always allows duplicates
							};
						};
						case "HASHMAP" : {
							private _dcValue = +_y;
							_dcValue merge [+_appendableValue,true];
							_hashMap set [_x,_dcValue]; /* overwrites parent keys */
						};
					};
				};
			};
		};
	} foreach _preCompiled;


	[_preCompiled] call _fnc_recurseBases;

	if (_noStack) then {
		_preCompiled deleteat "#create";
		_preCompiled deleteat "#clone";
		_preCompiled deleteat "#delete";
		_hashmap set ["#base",_preCompiled toArray false];
	};
	
	_preCompiled merge [_hashmap,true];
	
};

// Check Interfaces are implemented
private _interfaces = _preCompiled getOrDefault ["@interfaces",[]];
if ([_preCompiled,_interfaces,_allowNils] call XPS_fnc_checkInterface) then {
	// Passes all checks and is Ok to push out definition
	_hashmap toArray false;
} else {
	diag_log (format ["XPS_fnc_buildTypeDefinition: Type:%1 did not pass Interface Check",_hashmap get "#type"]);
	nil;
};