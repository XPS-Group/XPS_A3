#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_preprocessTypeDefinition
	
	---prototype
	_typeDefintion = [_type, _headers] call XPS_fnc_preprocessTypeDefinition
	---

Description:
    
	Preprocesses a Type Definition array and alters the code based on the following:

	Obfuscates the private Methods/Properties. 

	Takes base Array Properties with an "@" symbol and appends them together.
	
	It also has support for "Attributes" of the Methods/Properties. You can classify an Attribute
	by making it the third element of the Key/Value Pair. These Attributes do not exist once the 
	definition has been converted to a <HashmapObject>. The createHashmapObject command only cares
	about the first two elements and attributes will be discarded when instantiation occurs.

	---code
	["Key", "Value", [<Array> of Attribute Arrays] ]
	---

	Supported Attributes in the preprocessor are:

		- ["OBSOLETE"]
		- ["CONDITIONAL",{code}] - must return a boolean
		- ["VAILDATE_ALL", value] - see BIS command isEqualTypeAll
		- ["VAILDATE_ANY", value] - see BIS command isEqualTypeAny
		- ["VAILDATE_PARAMS", value] - see BIS command isEqualTypeParams
		- ["VAILDATE_TYPE", value] - see BIS command isEqualTypeType

	However, you can define any Attribute as long as it is in an array. The preprocessor will
	ignore custom attributes but, the first element MUST be a string. This is good if you want to 
	run your own custom preprocesser (or extend this one) before instantiating a type with 
	createHashmapPObject command.

Authors: 
	Crashdome
------------------------------------------------------------------------------

Parameter: _type 
	<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Optional: _headers 
	<Boolean> - determines if debug headers should be injected into code blocks  

Return: Nothing

Example: Private Properties

	The array :

	---code
	[
		["_propertyA",10],
		["_propertyB",10],
		["MethodA",{ (_self get "_propertyA") + (_self get "_propertyB")}]
	]
	---

	After calling this function would modify the original array to something like:
	
	---code
	[
		["f372a1c1",10],
		["9ade556a",10],
		["MethodA",{ (_self get "f372a1c1") + (_self get "9ade556a")}]
	]
	---

	Which can then be converted to a <HashmapObject> preventing "_propertyA" or 
	"_propertyB" to be called by an external function or method.

Example: Obsolete Methods/Properties

	The array :

	---code
	[
		["PropertyA",10,[["OBSOLETE"]]], // We dont use this anymore!
		["MethodA",{ "some old code here"},[["OBSOLETE"]]], // This has been replaced
		["MethodA",{ "some new code here"}]
	]
	---

	After calling this function would modify the original array to something like:
	
	---code
	[
		["MethodA",{ "some new code here"}]
	]
	---

Example: Conditional

	The array :

	---code
	[
		["MethodA",{ "some code dependant on MyVar being >= 10"},[["CONDITIONAL",{MyVar >= 10}]]],
		["MethodA",{ "some code dependant on MyVar being < 10"},[["CONDITIONAL",{MyVar < 10}]]]
	]
	---

	After calling this function, if MyVar was 13, it would modify the original array to something like:
	
	---code
	[
		["MethodA",{ "some code dependant on MyVar being >= 10"}]
	]
	---

	Note: Good for versioning and mod compatibility

Example: Validation of values

	The array :

	---code
	[
		["PropertyA",[1,2,3,4,"A"],[["VALIDATE_ALL",0]]],
		["PropertyB",SomeGlobalVar,[["VALIDATE_TYPE",""]]]
	]
	---

	After calling this function, if SomeGlobalVar was "Hello World":
	
	---code
	[
		["PropertyA", [1,2,3,4] , [["VALIDATE_TYPE,[]]  ,["VALIDATE_ALL",0]] ],  // This would vaildate true and continue
		["PropertyB",SomeGlobalVar,[["VALIDATE_TYPE",objNull]]]  // This would cause the type to not compile and an error would be sent to the RPT
	]
	---

	Note: Good for checking properties that are dependant on an external variable 

---------------------------------------------------------------------------- */
if !(params [["_typeDef",nil,[[]]],"_debugHeaders"]) exitwith {false};
_debugHeaders = [_debugHeaders] param [0,false,[true]];

private _privateKeys = [];
private _result = true;
private _ctor = "";
private _dtor = "";
private _ctor_l = "";
private _dtor_l = "";
private _hasCtor = false;
private _hasDtor = false;

private _typeName = (_typeDef select (_typeDef findIf {_x isEqualType [] && {_x select 0 isEqualTo "#type"}})) select 1;
_typeName = [_typeName,"<unknown type>"] select (isNil {_typeName});

try 
{
	//Process Key Attributes
	private _i = 0;
	while { _i < (count _typeDef)} do {

		scopeName "MAIN";

		if !((_typeDef#_i) isEqualType []) then {throw format ["Not a valid key/value array %1 in %2",_typeDef#_i,_typeDef]};
		
		private _keyPair = _typeDef#_i;
		private _key = _keyPair#0;
		private _value = _keyPair#1;

			if (_key isEqualTo "#create") then {_hasCtor = true};
			if (_key isEqualTo "#delete") then {_hasDtor = true};

			// Convert Interface list of strings to hashmap with ref to interface
			if (_key isEqualTo "@interfaces") then {
				if (_value isEqualType [] && {_value isEqualTypeAll ""}) then {
					private _interfaces = createhashmap;
					{
						private _ifc = call compile _x;
						_interfaces merge [createhashmapfromarray [[_x,_ifc]],true];
					} foreach _value;
					_value = compileFinal _interfaces;
					_keyPair set [1,_value];
				} else {throw format ["Interface list for Key @interfaces is not an array of strings.",_key]};
			};

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
					_typeDef deleteat _i; 
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
					if (_attParams isEqualType "") then {_initValue = _attParams} else {_initValue = str _attParams};
					_ctor = _ctor + format["_self set [%1,%2];",str _key,_initValue]; 
				};
				case "DTOR" : {
					_dtor = _dtor + format["_self set [%1,nil];",str _key]; 
				};
				case "CTOR_LAZY" : {
					private _initValue = str _value;
					if (_attParams isEqualType "") then {_initValue = _attParams} else {_initValue = str _attParams};
					_ctor_l = _ctor_l + format["_self set [%1,%2];",str _key,_initValue]; 
				};
				case "DTOR_LAZY" : {
					_dtor_l = _dtor_l + format["_self set [%1,nil];",str _key]; 
				};
				case "VALIDATE_ANY" : {
					if !(_attParams isEqualType []) then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",typename _attParams,_key]};
					if !(_value isEqualTypeAny _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "VALIDATE_ALL" : {
					if !(_value isEqualTypeALL _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "VALIDATE_PARAMS" : {
					if !(_attParams isEqualType []) then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",typename _attParams,_key]};
					if !(_value isEqualTypeParams _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
				};
				case "VALIDATE_TYPE" : {
					if !(_value isEqualType _attParams) then {
						diag_log text format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
				};
			};

			_a = _a + 1;
		};

		// Finally record if private key
		if (_key isEqualType "" && {_key find "_" == 0}) then {
			private _uid = [8] call XPS_fnc_createUniqueID;
			_privateKeys pushback [_key,_uid];
			_keyPair set [0,_uid]
		};

		_i = _i + 1;
	};

	// ------- Code injection for constructor/destructor and private keys -------- //
	// Add create / delete methods if they dont exist prior to changing private keys
	if (!_hasCtor && {_ctor != "" || _ctor_l != ""}) then {_typeDef pushback ["#create",compile (_ctor + _ctor_l)]};
	if (!_hasDtor && {_dtor != "" || _dtor_l != ""}) then {_typeDef pushback ["#delete",compile (_dtor + _dtor_l)]};

	for "_ix" from 0 to (count _typeDef)-1 do {
		private _keyPair = _typeDef#_ix;
		_keyPair params ["_key","_value"];
		// Constructor injection but only if it existed prior to above code
		if (_hasCtor && {_key isEqualTo "#create" && {_ctor != "" || _ctor_l != ""}}) then {
			private _strCode = (str _value) insert [1,_ctor];
			private _value = call compile (_strCode insert [count _strCode - 1,_ctor_l]);
			_keyPair set [1, _value];
		};
		// Destructor injection but only if it existed prior to above code
		if (_hasDtor && {_key isEqualTo "#delete" && {_dtor != "" || _dtor_l != ""}}) then {
			private _strCode = (str _value) insert [1,_dtor];
			private _value = call compile (_strCode insert [count _strCode - 1,_dtor_l]);
			_keyPair set [1, _value];
		};

		if (_value isEqualType {}) then {
			// Set header before replacing private keys
			private _strHeader = format[XPS_DebugHeader_TYP, _typeName, _keypair#0];

			//Replace Private Keys in any code block
			{
				private _find = _x#0;
				private _replace = _x#1;
				_value = [_find,_replace,_value] call xps_fnc_findReplaceKeyInCode;
				_keyPair set [1,_value];
			} foreach _privateKeys;

			//Finally Insert unaltered header
			if (_debugHeaders && {_keyPair#0 isNotEqualTo "#str"}) then {
				private _strCode = (str _value) insert [1,_strHeader];
				_keyPair set [1, call compile _strCode];
			};
		};
	};

	_result;

} catch {
	diag_log text "XPS_fnc_preprocessTypeDefinition: Encountered the following exception:";
	diag_log _exception;
	false;
};