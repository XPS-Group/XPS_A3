#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_typeDefToArray
	
	---prototype
	_result = [_hashmap] call XPS_fnc_typeDefToArray
	---

Description:
    Internal only. Converts a Type Definition <Hashmap> to an <Array> 
	
Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _hashmap
		<Hashmap>

	Return: _result
		<Array>

---------------------------------------------------------------------------- */
if !(params [["_hashmap",nil,[createhashmap]]]) exitwith {false};

private _result = [];
{
	_result pushback [_x,_y];
} foreach _hashmap;

_result;