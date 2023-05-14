#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_checkInterface
	
	---prototype
	_result = [_type, _interfaces] call XPS_fnc_checkInterface
	---

	---prototype
	_result = [_type, _interfaces, true] call XPS_fnc_checkInterface
	---

Description:
    Used to determine if a <Hashmap> or <HashmapObject> has the desired keys returning the desired type.

	Keys can be anything that is valid for a <HashmapKey> although strings as keys are typically used for <HashmapObjects>

Parameter: _type 
	<HashMap> or <HashmapObject> - the map/object to check

Parameter: _interfaces 
	<Array> - an <array> of <Strings> in the format ["Interface1","Interface2"...] string should be a global variable of type <Interface>

Optional: _allowNils* 
	<Boolean> - (optional) default: true - used to allow keys with nil values

Returns: _result
	<Boolean> - True if <TypeDefinition> has keys defined with types that match <Interface> definition

Example: Check a hashmap if it supports interface
    --- Code
		MyHashmap = createhashmapfromArray [["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];
        private _result = [MyHashmap,["MyInterface"]] call XPS_fnc_checkInterface; 
		// _result is 'true'
    ---

Authors:
     Crashdome

---------------------------------------------------------------------------- */

if !(params [["_hashmap",nil,[createhashmap]],["_interfaces",nil,[[]]],"_allowNils"]) exitwith {false;};
_allowNils = [_allowNils] param [0,true,[true]];

for "_i" from 0 to (count _interfaces -1) do {
	private _check = call compile (_interfaces#_i);
	//Check key exists
	private _key = _check#0;
	if !(_key in keys _hashmap) exitwith {false;};
	//Check value type
	if !(_check#1 in ["ANYTHING","ANY"]) then {
		private _type = typename (_hashmap get _key);
		if (isNil {_type} && !_allowNils) exitwith {false;};
		if !(_type == _check#1) exitwith {false;};
	};
};
true;
