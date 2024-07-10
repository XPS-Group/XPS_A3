#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_preprocessInterface
	
	---prototype
	_typeDefinition = [_interface] call XPS_fnc_preprocessInterface
	// OR
	_typeDefinition = _interface call XPS_fnc_preprocessInterface
	---

Description:
    
	Preprocesses an Interface and validates key/value pairs. If Interface contains a "@" key which 
	is of type hashmap, it appends unique key/values as needed. This feature allows inheriting
	from a parent interface.

	This function will modify the original array and also return a reference to it if needed.

Authors: 
	Crashdome
------------------------------------------------------------------------------

Parameter: _type 
	<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Return: _interface
	<Interface> - or <False> if error

---------------------------------------------------------------------------- */
if !(_this isEqualType []) exitwith {false};

private _interface = _this;

if (count _this == 1 && {_this#0 isEqualTypeAll []}) then {_interface = _this#0};

try 
{
	//Process Keys
	private _i = 0;
	while { _i < (count _interface)} do {

		if (isNil {_interface#_i} || {!((_interface#_i) isEqualType [] && {count (_interface#_i) > 1})})  then {throw format ["Not a valid key/value array %1 in %2",_typeDef#_i,_typeDef]};
		
		private _keyPair = _interface#_i;
		private _key = _keyPair#0;
		private _value = _keyPair#1;

		if (_key == "@" && {_value isEqualType createhashmap}) then {
			_interface deleteat _i;
			_interface insert [-1,_value toArray false,true];
		} else {
			_i = _i + 1;
		};
	};
	_interface;

} catch {
	diag_log text "XPS_fnc_preprocessInterface: Encountered the following exception:";
	diag_log text _exception;
	diag_log _this;
	false;
};
