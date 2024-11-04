#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_checkInterface
	
	---prototype
	_result = [_type, _interfaces, _allowNils*] call XPS_fnc_checkInterface
	---

	---prototype
	_result = [_type, _interfaces, true] call XPS_fnc_checkInterface
	---

Description:
    Used to determine if a <Hashmap> or <HashmapObject> has the desired keys returning the desired type.

	Keys can be anything that is valid for a <HashmapKey> although strings as keys are typically used for <HashmapObjects>

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _type 
	<HashMap> or <HashmapObject> - the map/object to check

Parameter: _interfaces 
	<String>, <Hashmap>, or <Array> - an <array> of any combination of <Strings> or <Hashmaps> in the format ["Interface1","Interface2"...] string should be a global variable 
	of type <Interface>. Hashmaps should be in key/value format that is acceptable for an <Interface>.

Optional: _allowNils* 
	<Boolean> - (optional - Default: false) - used to allow keys with nil values. Nil values might be required if a <TypeDefinition> 
	contains properties 'by ref' where the <TypeDefinition> is set to nil but the concrete <HashmapObject> instantiates the property at #create.

Returns: _result
	<Boolean> - <True> if <TypeDefinition>/<Hashmap> or <HashmapObject> has keys defined with types that match <Interface> definition

Example: Check a hashmap if it supports interface
    --- Code
		MyHashmap = createhashmapfromArray [["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
		MyInterfaceA = [["PropertyA","STRING"],["Method","CODE"]];
		MyInterfaceB = [["PropertyB","SCALAR"]];
        
		private _result = [MyHashmap, ["MyInterfaceA", MyInterfaceB] ] call XPS_fnc_checkInterface; //array of multiple string or hashmap
		private _result = [MyHashmap, "MyInterfaceA" ] call XPS_fnc_checkInterface; //single string
		private _result = [MyHashmap, MyInterfaceB ] call XPS_fnc_checkInterface; //single hashmap 
		// _result is 'true' for the all the above
    ---

---------------------------------------------------------------------------- */

params [["_hashmap",createhashmap,[createhashmap]],["_interfaces",[],[[],"",createhashmap]],["_allowNils",false,[true]]];

if (_hashmap isEqualTo createhashmap || {_interfaces isEqualTo []}) exitWith {
	diag_log text (format ["XPS_fnc_checkInterface: parameters not valid.  -- Hashmap: %1 -- Interfaces: %2",_this select 0,_this select 1]);
	false;
};

if !(_interfaces isEqualType []) then {_interfaces = [_interfaces]};

private _result = true;

for "_a" from 0 to (count _interfaces -1) do {
	private _interface = [];
	// build it from string var
	if ((_interfaces#_a) isEqualType "") then {
		_interface = call compile (_interfaces#_a);
		if !(_interface isEqualType createhashmap) then {
			// Not a valid hashmap - exit without checking and fail
			diag_log text (format ["XPS_fnc_checkInterface: Interface was not a valid hashmap.  Interface provided:%1",_interfaces#_a]);
			_interface = createhashmap;
			_result = false;
		};
	};

	if (isNil {_interface}) exitWith {
		diag_log text (format ["XPS_fnc_checkInterface: Interface was nil.  Interface provided:%1",_interfaces#_a]);
		_result = false;
	};

	if !(_interface isEqualType createhashmap) exitWith {
		diag_log text (format ["XPS_fnc_checkInterface: Interface was invalid or not a hashmap.  Interface provided:%1",_interfaces#_a]);
		_result = false;
	};
	
	//Check each interface loop
	{
		[_x,_y] params ["_key","_checkType"];
		//Check key exists
		if !(_key in _hashmap) then {
			diag_log text (format ["XPS_fnc_checkInterface: Type:%1 - %2 key is missing for Interface: %3",_hashmap get "#type",_key,_interfaces#_a]);
			_result = false;
			continue;
		};
		//Check value type
		if !(_checkType in ["ANYTHING","ANY"]) then {
			private _type = typename (_hashmap get _key);
			if (isNil {_type}) then { 
				if !(_allowNils) then {
					diag_log text (format ["XPS_fnc_checkInterface: Type:%1 - %2 key set to nil during a check where they are not allowed",_hashmap get "#type",_key]);
					_result = false;
				} else {continue};
			};
			// Check if Hashmap Object and get type if exists
			if (_type == "HASHMAP") then {
				private _types = (_hashmap get _key) getOrDefault ["#type",_type];
				private _typeIfcs = (_hashmap get _key) getOrDefault ["@interfaces",_type];
				// Check type if actual instantiated object
				if (_types isEqualtype []) then {
					if (toLower _checkType in (_types apply {toLower _x})) then {
						continue;
					};
				};
				// Check Interfaces last
				if (_typeIfcs isEqualtype createhashmap) then {
					if (toLower _checkType in ((keys _typeIfcs) apply {toLower _x})) then {
						continue;
					};
				};
			};
			if !(tolower _type isEqualTo tolower _checkType) then {
				diag_log text (format ["XPS_fnc_checkInterface: Type:%1 - %2 key has a value type %3. Type %4 expected",_hashmap get "#type",_key,_type,_checkType]);
				_result = false;
			};
		};
	} forEach _interface;
};
_result;
