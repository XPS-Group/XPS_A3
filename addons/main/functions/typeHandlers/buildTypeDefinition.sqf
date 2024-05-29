#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_buildTypeDefinition
	
	---prototype
	_typeDefinition = [_type] call XPS_fnc_buildTypeDefinition
	---

	---prototype
	_typeDefinition = [_type, false, true, true] call XPS_fnc_buildTypeDefinition
	---

Description:
    Used to define a global declaration for a type <Array> (<Hashmap> for v2.16 onward)

	Has extra enhancements for inheritance and interfacing by looking for the following keys:

	_String - any string starting with an underscore is obfuscated by replacing the key and references to that key in code blocks with
	a unique identifier every time the type definition is rebuilt. See <XPS_fnc_preprocessTypeDefinition> for more info

	@String - any key named as such with an @ symbol and also has an <array> value type, will be appended (unique only). For example, "@MyArray" key in parent
	with a value of [1,2,3] and a child type which inherits but has a value of [2,3,4,5,6] will become [1,2,3,4,5,6]. The most common usage 
	will be the special "@interfaces" key which is used in checking Method/Property compliance. 

	@interfaces - an <array> of <strings> - e.g. ["IShape", "IObject"] - where each string is a valid global variable containing an <Interface> <array>
	which will be used to verify keys/values of a <Hashmap> or <HashmapObject> exist.

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _type 

<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Optional: _allowNils* 

<Boolean> - (optional) default: true - used to allow keys with nil values when checking interface validity

Optional: _preprocess* 

<Boolean> - (optional) default: true - determines if array should be preprocessed. 
See <XPS_fnc_preprocessTypeDefinition> for more info.

Optional: _noStack* 

<Boolean> - (optional) default: false - determines if "#base" definition should stack "#create" and "#delete" methods during inheritance
See <XPS_fnc_preprocessTypeDefinition> for more info.

Optional: _headers* 

<Boolean> - (optional) default: false - determines if debug headers should be injected into code blocks - ignored if _preprocess isEqualTo false
See <XPS_fnc_preprocessTypeDefinition> for more info.

Return: _typeDefinition
	<TypeDefinition> - or <False> if error

---------------------------------------------------------------------------- */
params [["_type",[],[[]]],["_allowNils",true,[true]],["_preprocess",true,[true]],["_noStack",false,[true]],["_headers",false,[true]]];

if (_type isEqualTo []) exitwith {false};

private _errors = false;

private _fnc_recurseBases = {
	params ["_hashmap"];
	if ("#base" in keys _hashmap) then {
		private _base = createhashmapfromarray (_hashmap get "#base");
		[_base] call _fnc_recurseBases;
		_hashmap merge _base;
	};
};

if (_preprocess) then {
	if !([_type, _headers] call XPS_fnc_preprocessTypeDefinition) exitwith {
		_errors = true;
	};
};

if (_errors) exitwith {
	diag_log text ("XPS_fnc_buildTypeDefinition: Skipping a bad preprocessed Array - Any Preprocess Errors above may provide more info");
	false;
};

private _hashmap = createhashmapfromarray _type;
private _preCompiled = _hashmap; // In case it doesn't have a parent, we need this for later

// Check for parent type
if ("#base" in keys _hashmap) then {
	private _pType = _hashmap get "#base";
	if (isNil {_pType} || !(_pType isEqualTypeAny [[],createhashmap])) exitwith {
		diag_log text (format ["XPS_fnc_buildTypeDefinition: Type:%1 does not have a valid #base type definition. #base:%2",_hashmap get "#type",_hashmap get "#base"]);
		_errors = true;
	};

	_preCompiled = if (_pType isEqualType []) then {createhashmapfromarray _pType} else {+_pType};

	private _pTypeName = _preCompiled get "#type";
	private _keys = keys _hashmap;
	{
		// Create base methods as "ParentType.Method"
		if (!(isNil {_pTypeName}) && {_x in _keys && _x isEqualType "" && _y isEqualType {}}) then {_hashmap set [format["%1.%2",_pTypeName,_x],_y];};

		// Append keys using @ 
		if (_x isEqualType "" && {_y isEqualTypeAny [[],createhashmap]}) then {

			private _pAppend = (_x find "@") isEqualTo 0;
			private _cAppend = ("@" + _x) in _keys;

			if ( _pAppend || _cAppend ) then {
				
				private _valuesToAppend = _hashmap getorDefault [_x,true];
				if (_valuesToAppend isEqualType true) then {_valuesToAppend = _hashmap getorDefault ["@" + _x,true];};

				if (_valuesToAppend isEqualType _y) then {
					switch (typeName _valuesToAppend) do {
						case "ARRAY" : {
								_valuesToAppend = +_valuesToAppend;
								_y pushbackUnique _valuestoAppend; // does not allow duplicates
								_hashmap set [_x,_valuesToAppend]; 
							};
						case "HASHMAP" : {
							private _dCopy = +_y;
							_dCopy merge [+_valuesToAppend,true]; // overwrites parent keys 
							_hashMap set [_x,_dCopy]; 
						};
					};

					// Remove @ if parent does not have it
					if (_cAppend) then {_hashmap deleteat ("@"+ _x);};
				};
			};
		};
	} foreach _preCompiled;

	[_preCompiled] call _fnc_recurseBases;

	if (_noStack) then {
		{
			if (_x in keys _precompiled) then {
				if !(_x in _keys) then {_hashmap set [_x, _precompiled get _x]};
				_preCompiled deleteat _x;
			};
		} foreach ["#create","#clone","#delete"];
		_hashmap set ["#base",_preCompiled toArray false];
	};
	
	// Merge for interface check
	_preCompiled merge [_hashmap,true];
	
};

if (_errors) exitwith {
	diag_log text (format ["XPS_fnc_buildTypeDefinition: skipped due to errors:  %1",_hashmap get "#type"]);
	false;
};

// Check Interfaces are implemented
private _interfaces = _preCompiled getOrDefault ["@interfaces",nil];

if (isNil {_interfaces} || {[_preCompiled, keys _interfaces, _allowNils] call XPS_fnc_checkInterface}) then {
	// Passes all checks and is Ok to push out definition
	_hashmap toArray false;
} else {
	diag_log text (format ["XPS_fnc_buildTypeDefinition: Type:%1 did not pass Interface Check",_hashmap get "#type"]);
	false;
};

/*------------------------------------------------------------------------------
Example: No Inheritance
    --- Code
		MyTypeDefA = [["#str",compileFinal {_self get "#type" select  0}],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'
    ---

Example: Implements Interface
    --- Code
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];
		
		//This FAILS because PropertyA and Method do not exist
		MyTypeDefA = [["#str",compileFinal {_self get "#type" select  0}],["@interfaces",["MyInterface"]],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		//Does not fail because PropertyA and Method exist
		MyTypeDefA = [["#str",compileFinal {_self get "#type" select  0}],["@interfaces",["MyInterface"]],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'
    ---

Example: Implements Interface with Inheritance
    --- Code
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];

		MyTypeDefA = [["#str",compileFinal {_self get "#type" select  0}],["@interfaces",["MyInterface"]],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		MyTypeDefB = [["#str",compileFinal {_self get "#type" select  0}],["#base", MyTypeDefA ],["PropertyA","Goodbye"],["Method",compileFinal {hint "Bye"}]];
        TAG_TypeB = ["MyTypeDefB"] call XPS_fnc_buildTypeDefinition; 

		// Both TypeA and TypeB will implement interface from inheritance but PropertyA and Method are overridden in TypeB 
		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'

		private _myObjB = createhashmapobject [TypeB];
		_myObj call ["Method"] //hints 'Bye'
    ---

------------------------------------------------------------------------------*/