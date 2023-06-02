#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_preprocessTypeDefinition
	
	---prototype
	_typeDefintion = [_type] call XPS_fnc_preprocessTypeDefinition
	---

Description:
    
	Takes a type definition array and obfuscates the private Methods/Properties

Parameter: _type 

<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Return: 
	Nothing

Example:

	The array :
	---
	[
		["_propertyA",10],
		["_propertyB",10],
		["MethodA",{ (_self get "_propertyA") + (_self get "_propertyB")}]
	]
	---

	After calling this function would modify the original array to something like:
	---
	[
		["f372a1c1",10],
		["9ade556a",10],
		["MethodA",{ (_self get "f372a1c1") + (_self get "9ade556a")}]
	]
	---

	Which can then be converted to a <HashmapObject> preventing "_propertyA" or 
	"_propertyB" to be called by an external function or method.

Authors: 
	Crashdome

---------------------------------------------------------------------------- */
params [["_array",[],[[]]]];

private _privateKeys = [];
private _result = true;

try 
{
	//Process Keys
	private _i = 0;
	while { _i < (count _array)-1} do {
		scopeName "ATTRIBUTE_CHECK";
		if !(typename _array#_i == "ARRAY") then {throw format ["Not a valid key/value array %1 in %2",_array#_i,_array]};
		if (count _array#_i > 2) then {
			private _attributes = toUpperANSI _array#_i#2;
			if !(typename _attributes == "ARRAY") then {_attributes = [_attributes];};
			for "_x" from 0 to (count _attributes)-1 do {
				private _attribute = _attribute#_x;
				if !(typename _attribute == "ARRAY") then {_attribute = [_attribute];};
				if !(typename _attribute#0 == "STRING") then {throw format ["Attribute %1 for Key %2 is not a string.",_attribute#0,_array#_i#0]};
				switch (_attribute#0) do {
					case "OBSOLETE" : {
						_array deleteat _i; 
						breakOut "ATTRIBUTE_CHECK";
					};
					case "CONDITIONAL" : {
						if !(typename _attribute#1 == "CODE") then {throw format ["Conditional Attribute for Key %2 contains %1. Expected code block.",_attribute#1,_array#_i#0]};
						if !(call _attribute#1) then {
							_array deleteat _i; 
							breakOut "ATTRIBUTE_CHECK";
						};
					};
					case "VALIDATE_ANY" : {
						private _params = _attribute#1;
						private _value = _array#_i#1;
						if !(typename _params == "ARRAY") then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",_attribute#1,_array#_i#0]};
						if !(_value isEqualTypeAny _params) then {
							diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_array#_i#0,_array#_i#1];
							_result = false;
						};
						_i = _i + 1;
					};
					case "VALIDATE_ALL" : {
						private _params = _attribute#1;
						private _value = _array#_i#1;
						if !(_value isEqualTypeALL _params) then {
							diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_array#_i#0,_array#_i#1];
							_result = false;
						};
						_i = _i + 1;
					};
					case "VALIDATE_PARAMS" : {
						private _params = _attribute#1;
						private _value = _array#_i#1;
						if !(typename _params == "ARRAY") then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",_attribute#1,_array#_i#0]};
						if !(_value isEqualTypeParams _params) then {
							diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_array#_i#0,_array#_i#1];
							_result = false;
						};
						_i = _i + 1;
					};
					case "VALIDATE_TYPE" : {
						private _params = _attribute#1;
						private _value = _array#_i#1;
						if !(_value isEqualType _params) then {
							diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_array#_i#0,_array#_i#1];
							_result = false;
						};
						_i = _i + 1;
					};
					default {_i = _i + 1};
				};
			};
		};
		private _key = _array#_i#0;
		if (_key find "_" == 0) then {
			private _uid = [8] call XPS_fnc_createUniqueID;
			_privateKeys pushback [_key,_uid];
			_array#_i set [0,_uid]
		};
	};

	//Replace code blocks that reference the private key with the UID
	for "_i" from 0 to (count _array)-1 do {
		private _value = _array#_i#1;
		if (typename _value == "CODE") then {
			private _str = str _value;
			{
				private _find = """" insert [2,_x#0];
				private _replace = """" insert [2,_x#1];
				_str regexreplace [_find,_replace];
				_array#_i set [1,call compile _str];
			} foreach _privateKeys;
		};
	};

	_result;

} catch {
	diag_log format ["XPS_fnc_preprocessTypeDefinition: Encountered the follwing exception: %1",_exception];
	false;
};