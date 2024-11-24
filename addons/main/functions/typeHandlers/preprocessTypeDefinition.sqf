#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_preprocessTypeDefinition
	
	---prototype
	_result = _type call XPS_fnc_preprocessTypeDefinition
	---
	---prototype
	_result = [_type] call XPS_fnc_preprocessTypeDefinition
	---

Description:
    
	Preprocesses and modifies a Type Definition array and alters the code based on the following:

	Obfuscates the private Methods/Properties. 
	
	It also has support for "Attributes" of the Methods/Properties. You can classify an Attribute
	by making it the third element of the Key/Value Pair. These Attributes do not exist once the 
	definition has been converted to a <HashmapObject>. The createHashmapObject command only cares
	about the first two elements and attributes will be discarded when instantiation occurs.

	---code
	["Key", "Value", [<Array> of Attribute Arrays] ]
	---

	Supported Attributes in the preprocessor are:

		["OBSOLETE"] - used on methods no longer used but kept for backwards compatibility
		["CTOR","code"] - injects string or code block into #create method : Top 
		["DTOR","code"] - injects string or code block into #delete method : Top 
		["CTOR_LAZ","code"] - injects string or code block into #create method : Bottom
		["DTOR_LAZY","code"] - injects string or code block into #delete method : Bottom 
		["CONDITIONAL", compileFinal {code}] - must return a boolean - this method/property will only exist if <True>
		["VAILDATE_ALL", value] - see BIS command isEqualTypeAll
		["VAILDATE_ANY", value] - see BIS command isEqualTypeAny
		["VAILDATE_PARAMS", value] - see BIS command isEqualTypeParams
		["VAILDATE_TYPE", value] - see BIS command isEqualTypeType

	However, you can define any Attribute as long as it is in an array. The preprocessor will
	ignore custom attributes but, the first element MUST be a string. This is good if you want to 
	run your own custom preprocesser (or extend this one) before instantiating a type with 
	<createHashmapObject: https://community.bistudio.com/wiki/createHashmapObject> command.

More Info - <XPS Wiki - Preprocessor and Type Builder:https://www.notion.so/xps-group/Preprocessor-and-Type-Builder-2ca223d0e3ba40949b6655930d0fbf47>

Authors: 
	Crashdome
------------------------------------------------------------------------------

Parameter: _type 
	<Array> - an <array> of <arrays> in the format [[key1,value1],[key2,value2]...]  

Returns: _result
	<Boolean> - True if successful otherwise False

---------------------------------------------------------------------------- */
if !(_this isEqualType []) exitWith {false};

private _typeDef = _this;

if (count _this == 1 && {_this#0 isEqualTypeAll []}) then {_typeDef = _this#0};

_privateKeys = [_privateKeys,[]] select (isNil "_privateKeys");

private _result = true;
private _ctor = ""; 
private _dtor = "";
private _ctor_l = "";
private _dtor_l = "";
private _hasCtor = false;
private _hasDtor = false;

private _srlz = ""; 
private _desrlz = "";
private _hasSrlz = false;
private _hasDesrlz = false;

private _typeIndex = _typeDef findIf {_x isEqualType [] && {_x select 0 == "#type"}};
private _typeArray = [_typeDef select _typeIndex,["<unknown type>"]] select (_typeIndex isEqualTo -1);
private _typeName = _typeArray select (count _typeArray > 1);

private _flagsIndex = _typeDef findIf {_x isEqualType [] && {_x select 0 == "#flags"}};
private _flags = [_typeDef select _flagsIndex,[]] select (_flagsIndex isEqualTo -1);

private _nested = createhashmap;

try 
{
	//Process Key Attributes
	private _i = 0;
	while { _i < (count _typeDef)} do {

		scopeName "MAIN";

		if (isNil {_typeDef#_i} || {!((_typeDef#_i) isEqualType [] && {count (_typeDef#_i) > 1})}) then {throw format ["Not a valid key/value array %1 in %2",_typeDef#_i,_typeName]};
		
		private _keyPair = _typeDef#_i;
		private _key = _keyPair#0;
		private _value = _keyPair#1;

			if (_key == "#create") then {_hasCtor = true};
			if (_key == "#delete") then {_hasDtor = true};
			if (_key == "Serialize") then {_hasSrlz = true};
			if (_key == "Deserialize") then {_hasDesrlz = true};

			// Convert Interface list of strings to hashmap with ref to interface
			// if (_key == "@interfaces") then {
			// 	if (_value isEqualType [] && {_value isEqualTypeAll ""}) then {
			// 		private _interfaces = createhashmap;
			// 		{
			// 			private _ifc = currentNamespace getvariable _x;
			// 			if (isNil "_ifc") then  {throw format ["Cannot create interface: %1.",_x]};
			// 			_interfaces merge [createHashMapFromArray [[_x,_ifc]],true];
			// 		} forEach _value;
			// 		_value = compileFinal _interfaces;
			// 		_keyPair set [1,_value];
			// 	} else {throw format ["Interface list for Key @interfaces is not an array of strings."]};
			// };

		private _attributes = [];
		if (count _keyPair > 2) then {
			_attributes = _keyPair#2;
			if !(_attributes isEqualType []) then {throw format ["Attributes for Key %1 is not an array.",_key]};
		};
		
		private _a = 0;
		while {_a < (count _attributes)} do {

			scopeName "ATTRIBUTE_CHECK";

			private _attribute = _attributes#_a;
			if !(_attribute isEqualType []) then {throw format ["Attributes %1 for Key %2 is not formatted as an array.",_a,_key]};

			private _attCommand = _attribute#0;
			if !(_attCommand isEqualType "") then {throw format ["Attribute %1 for Key %2 is not a string.",_attCommand,_key]};
			private "_attParams";
			if (count _attribute >1) then {_attParams = _attribute#1};

			switch (toUpper _attCommand) do {
				case "OBSOLETE" : {
					if !(_attParams isEqualType "") then {throw format ["Obsolete Attribute for Key %2 contains %1. Expected String.",typename _attParams,_key]};
					_value = call compile ((str _value) insert [0,_attParams]);
					_keyPair set [1, _value];
					breakTo "Main";
				};
				case "CONDITIONAL" : {
					if !(_attParams isEqualType {}) then {throw format ["Conditional Attribute for Key %2 contains %1. Expected code block.",typename _attParams,_key]};
					if !(call _attParams) then {
						_typeDef deleteat _i; 
						breakTo "Main";
					};
				};
				case "CTOR" : {
					private _initValue = str _value;
					if !(isNil "_attParams") then {if (_attParams isEqualType "") then {_initValue = _attParams} else {_initValue = str _attParams}};
					_ctor = _ctor + format["_self set [%1,%2];",str _key,_initValue]; 
				};
				case "DTOR" : {
					_dtor = _dtor + format["_self set [%1,nil];",str _key]; 
				};
				case "CTOR_LAZY" : {
					private _initValue = str _value;
					if !(isNil "_attParams") then {if (_attParams isEqualType "") then {_initValue = _attParams} else {_initValue = str _attParams}};
					_ctor_l = _ctor_l + format["_self set [%1,%2];",str _key,_initValue]; 
				};
				case "DTOR_LAZY" : {
					_dtor_l = _dtor_l + format["_self set [%1,nil];",str _key]; 
				};
				case "VALIDATE_ANY" : {
					if !(_attParams isEqualType []) then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",typename _attParams,_key]};
					if !(_value isEqualTypeAny _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: %2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "VALIDATE_ALL" : {
					if !(_value isEqualTypeALL _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: %2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "VALIDATE_PARAMS" : {
					if !(_attParams isEqualType []) then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",typename _attParams,_key]};
					if !(_value isEqualTypeParams _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: %2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "VALIDATE_TYPE" : {
					if !(_value isEqualType _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: %2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "NESTED_TYPE" : {
					if (isNil "_attParams") then {_attParams = [true, true, false]} else {
						if !(_attParams isEqualTypeAll true) then {throw  format ["Inner Type Attribute for Key %2 was %1. Expected Array of Booleans.",_attParams,_key]}
					};

					_nested set [_i, [_value]+_attparams];
				};
				case "IN_TYPE_ONLY" : {	
					if !("sealed" in _flags) then {
						_ctor_l = _ctor_l + format["_self deleteAt %1;",str _key]; 
					};
				};
				case "SERIALIZABLE" : {
					_srlz = _srlz + format["_thisDTO set [%2, _self get %1];",str _key,str ("s|"+_key)]; 
					_desrlz = _desrlz + format["_self set [%1, _thisDTO get %2];",str _key,str ("s|"+_key)]; 
				};
			};

			_a = _a + 1;
		};

	if !(XPS_DebugMode) then {
		// Finally record if a private key for later obfuscation
		if (_key isEqualType "" && {_key find "_" isEqualTo 0}) then {
			private _uid = [8] call XPS_fnc_createUniqueID;
			_privateKeys pushBack [_key,_uid];
			_keyPair set [0,_uid]
		};
	};

		_i = _i + 1;
	};


	// ------- Code injection for constructor/destructor and private keys -------- //
	// Add create / delete / serialize / deserialize methods if they dont exist prior to changing private keys
	if (!_hasCtor && {_ctor isNotEqualTo "" || _ctor_l isNotEqualTo ""}) then {_typeDef pushBack ["#create",compileFinal  (_ctor + _ctor_l)]};
	if (!_hasDtor && {_dtor isNotEqualTo "" || _dtor_l isNotEqualTo ""}) then {_typeDef pushBack ["#delete",compileFinal  (_dtor + _dtor_l)]};
	if (!_hasSrlz && {_srlz isNotEqualTo ""}) then {_typeDef pushBack ["Serialize",compileFinal  ("params [[""_thisDTO"",createhashmap,[createhashmap]]];"+_srlz+"compileFinal _thisDTO;")]};
	if (!_hasDesrlz && {_desrlz isNotEqualTo ""}) then {_typeDef pushBack ["Deserialize",compileFinal  ("params [[""_thisDTO"",createhashmap,[createhashmap]]];"+_desrlz)]};

	// First pass - Injection
	for "_ix" from 0 to (count _typeDef)-1 do {
		private _keyPair = _typeDef#_ix;
		_keyPair params ["_key","_value"];
		// Constructor injection but only if it existed prior to above code
		if (_hasCtor && {_key == "#create" && {_ctor isNotEqualTo "" || _ctor_l isNotEqualTo ""}}) then {
			private _strCode = (str _value) insert [1,_ctor];
			_value = call compile (_strCode insert [count _strCode - 1,_ctor_l]);
			_keyPair set [1, compileFinal _value];
		};
		// Destructor injection but only if it existed prior to above code
		if (_hasDtor && {_key == "#delete" && {_dtor isNotEqualTo "" || _dtor_l isNotEqualTo ""}}) then {
			private _strCode = (str _value) insert [1,_dtor];
			_value = call compile (_strCode insert [count _strCode - 1,_dtor_l]);
			_keyPair set [1, compileFinal _value];
		};
		// Serialize injection but only if it existed prior to above code
		if (_hasCtor && {_key == "Serialize" && {_ctor isNotEqualTo ""}}) then {
			_value = call compile ((str _value) insert [count _strCode - 1,_srlz+"compileFinal _thisDTO;"]);
			_keyPair set [1, compileFinal _value];
		};
		// Deserialize injection but only if it existed prior to above code
		if (_hasCtor && {_key == "Deserialize" && {_ctor isNotEqualTo ""}}) then {
			_value = call compile ((str _value) insert [count _strCode - 1,_desrlz]);
			_keyPair set [1,compileFinal _value];
		};

		if (_value isEqualType {}) then {
			private _final = isFinal _Value;
			private _code = str _value;
			//Replace Private Keys
			{
				private _find = _x#0;
				private _replace = _x#1;
				_code = [_find, _replace, _code] call xps_fnc_findReplaceKeyInCode;
			} forEach _privateKeys;
			
			if (_final) then {
				_keyPair set [1,compileFinal call compile _code]
			} else {
				_keyPair set [1,call compile _code]
			};
		};
	};

	//Build any nested types with current _privateKeys list
	{
		_typdef#_x set [1,createhashmapfromarray (_y call XPS_fnc_buildTypeDefinition)];
	} foreach _nested;

	_result;

} catch {
	diag_log text "XPS_fnc_preprocessTypeDefinition: Encountered the following exception:";
	diag_log text _exception;
	diag_log _typeName;
	false;
};

/*----------------------------------------------------------------------------------

Example: Private Properties

	The array :

	---code
	[
		["_propertyA",10],
		["_propertyB",10],
		["MethodA", compileFinal { (_self get "_propertyA") + (_self get "_propertyB")}]
	]
	---

	After calling this function would modify the original array to something like:
	
	---code
	[
		["f372a1c1",10],
		["9ade556a",10],
		["MethodA", compileFinal { (_self get "f372a1c1") + (_self get "9ade556a")}]
	]
	---

	Which can then be converted to a <HashmapObject> preventing "_propertyA" or 
	"_propertyB" to be get, set, or called by an external function or method.

Example: Obsolete Methods

	The array :

	---code
	[
		["PropertyA",10], 
		["MethodA", compileFinal { "some old code here"},[["OBSOLETE","diag_log ""Warning! MethodA is old. Use MethodA_New"";"]]], // This has been replaced
		["MethodA_New", compileFinal { "some new code here"}]
	]
	---

	After calling this function would modify the original array to something like:
	
	---code
	[
		["PropertyA",10], 
		["MethodA", compileFinal { "diag_log ""Warning! MethodA is old. Use MethodA_New""; some old code here"}], 
		["MethodA_New", compileFinal { "some new code here"}]
	]
	---

Example: Conditional

	The array :

	---code
	[
		["MethodA", compileFinal { "some code dependant on MyVar being >= 10" },[["CONDITIONAL",{MyVar >= 10}]]],
		["MethodA", compileFinal { "some code dependant on MyVar being < 10" },[["CONDITIONAL",{MyVar < 10}]]]
	]
	---

	After calling this function, if MyVar was 13, it would modify the original array to something like:
	
	---code
	[
		["MethodA", compileFinal { "some code dependant on MyVar being >= 10" }]
	]
	---

	Note: Good for versioning and mod compatibility

Example: Validation of values

	The array :

	---code
	SomeGlobalVar = "Hello World";

	[
		["PropertyA",[1,2,3,4,"A"],[["VALIDATE_ALL",0]]], // This would vaildate false and cause the type to not compile and an error would be sent to the RPT
		["PropertyB",SomeGlobalVar,[["VALIDATE_TYPE",""]]]
	]
	---

	Another example of calling this function:
	
	---code
	SomeGlobalVar = "Hello World";
	
	[
		["PropertyA", [1,2,3,4] , [["VALIDATE_ALL",0]] ],  // This would vaildate true and continue
		["PropertyB",SomeGlobalVar,[["VALIDATE_TYPE",objNull]]]  // This would cause the type to not compile and an error would be sent to the RPT
	]
	---

	Note: Good for checking properties that are dependant on an external variable 
----------------------------------------------------------------------------------*/