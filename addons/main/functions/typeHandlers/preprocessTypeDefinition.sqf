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

Example: Private Properties

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

Example: Obsolete Method

	The array :

	---
	[
		["MethodA",{ "some old code here"},[["OBSOLETE]]],
		["MethodA",{ "some new code here"}]
	]
	---

	After calling this function would modify the original array to something like:
	
	---
	[
		["MethodA",{ "some new code here"}]
	]
	---

Example: Obsolete Method

	The array :

	---
	[
		["MethodA",{ "some old code here"},[["OBSOLETE]]],
		["MethodA",{ "some new code here"}]
	]
	---

	After calling this function would modify the original array to something like:
	
	---
	[
		["MethodA",{ "some new code here"}]
	]
	---

Example: Conditional

	The array :

	---
	[
		["MethodA",{ "some code dependant on MyVar being >= 10"},[["CONDITIONAL",{}]
	After calling this function would modify the original array to something like:
	
	---
	[
		["MethodA",{ "some new code here"}]
	]
	---

Authors: 
	Crashdome

---------------------------------------------------------------------------- */
params [["_typeDef",[],[[]]]];

private _privateKeys = [];
private _result = true;

try 
{
	//Process Keys
	private _i = 0;
	while { _i < (count _typeDef)} do {

		scopeName "MAIN";

		if !(typename (_typeDef#_i) == "ARRAY") then {throw format ["Not a valid key/value array %1 in %2",_typeDef#_i,_typeDef]};
		private _keyPair = _typeDef#_i;
		private _key = _keyPair#0;
		private _value = _keyPair#1;
		private _attributes = [];
		if (count _keyPair > 2) then {
			_attributes = _keyPair#2;
			if !(typename _attributes == "ARRAY") then {throw format ["Attributes for Key %1 is not an array.",_key]};
		} else {_i = _i +1;};
		
		for "_a" from 0 to (count _attributes)-1 do {

			scopeName "ATTRIBUTE_CHECK";

			private _attribute = _attributes#_a;
			if !(typename _attribute == "ARRAY") then {throw format ["Attributes %1 for Key %2 is not formatted as an array.",_a,_key]};

			private _attCommand = _attribute#0;
			if !(typename _attCommand == "STRING") then {throw format ["Attribute %1 for Key %2 is not a string.",_attCommand,_key]};
			private "_attParams";
			if (count _attribute >1) then {_attParams = _attribute#1};

			switch (toUpper _attCommand) do {
				case "OBSOLETE" : {
					_typeDef deleteat _i; 
					breakTo "Main";
				};
				case "CONDITIONAL" : {
					if !(typename _attParams == "CODE") then {throw format ["Conditional Attribute for Key %2 contains %1. Expected code block.",typename _attParams,_key]};
					if !(call _attParams) then {
						_typeDef deleteat _i; 
						breakTo "Main";
					} else {_i = _i + 1;};
				};
				case "VALIDATE_ANY" : {
					if !(typename _attParams == "ARRAY") then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",typename _attParams,_key]};
					if !(_value isEqualTypeAny _attParams) then {
						diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
					_i = _i + 1;
				};
				case "VALIDATE_ALL" : {
					if !(_value isEqualTypeALL _attParams) then {
						diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
					_i = _i + 1;
				};
				case "VALIDATE_PARAMS" : {
					if !(typename _attParams == "ARRAY") then {throw format ["Vaildate Attribute for Key %2 contains %1. Expected array.",typename _attParams,_key]};
					if !(_value isEqualTypeParams _attParams) then {
						diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
					_i = _i + 1;
				};
				case "VALIDATE_TYPE" : {
					if !(_value isEqualType _attParams) then {
						diag_log format ["XPS_fnc_preprocessTypeDefinition: Key %1 Value: $2 failed validation",_key,_value];
						_result = false;
					};
					_i = _i + 1;
				};
				default {_i = _i + 1};
			};
		};

		// Finally
		if (_key find "_" == 0) then {
			private _uid = [8] call XPS_fnc_createUniqueID;
			_privateKeys pushback [_key,_uid];
			_keyPair set [0,_uid]
		};
	};

	//Replace code blocks that reference the private key with the UID
	for "_ix" from 0 to (count _typeDef)-1 do {
		private _keyPair = _typeDef#_ix;
		private _value = _keyPair#1;
		if (typename _value == "CODE") then {
			{
				private _find = _x#0;
				private _replace = _x#1;
				private _code = [_find,_replace,_value] call xps_fnc_findReplaceKeyInCode;
				_keyPair set [1,_code];
			} foreach _privateKeys;
		};
	};

	_result;

} catch {
	diag_log "XPS_fnc_preprocessTypeDefinition: Encountered the follwing exception:";
	diag_log _exception;
	false;
};