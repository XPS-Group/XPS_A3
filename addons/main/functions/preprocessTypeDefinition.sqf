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

private _keys = [];

//Find Keys with underscore
for "_i" from 0 to (count _array)-1 do {
	private _key = _array#_i#0;
	if (_key find "_" == 0) then {
		private _uid = [8] call XPS_fnc_createUniqueID;
		_keys pushback [_key,_uid];
		_array#_i set [0,_uid]
	};
};

//Replace code blocks that reference that key with the UID
for "_i" from 0 to (count _array)-1 do {
	private _value = _array#_i#1;
	if (typename _value == "CODE") then {
		private _str = str _value;
		{
			private _find = """" insert [2,_x#0];
			private _replace = """" insert [2,_x#1];
			_str regexreplace [_find,_replace];
			_array#_i set [1,call compile _str];
		} foreach _keys;
	};
};