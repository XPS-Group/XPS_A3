#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_findReplaceKeyInCode
	
	---prototype
	_result = [_hashmapOfKeys,_code] call XPS_fnc_findReplaceKeyInCode
	---

Description:
    
	Internal Only - although use cases outside of XPS might be useful to some. Replaces
	a key such as a private key "_key" with a different key. The values must be in quotes in code block.

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _hashmapOfKeys

	<Hashmap> - a map of (key)strings to find / and (value)string to replace it

Parameter: _code 

	<Code> - any code block

Return: _result

	<Code> - the code with replaced <strings>

Example:
	
	--- code
	private _code = {_self call "_privateKey"}; 
	private _find = "_privateKey";
	private _replace = "ABCD";
	_result = [_find,_replace,_code] call XPS_fnc_findReplaceKeyInCode
	// _result is: {_self call "ABCD"}
	---

---------------------------------------------------------------------------- */
params [["_pair",createhashmap,[createhashmap]],["_code",{},[{}]]];
private _newCodeStr = (str _code);
{
	private _findRegex = """""+" insert [1,_x];
	private _replaceRegex = """""" insert [1,_y];
	_newCodeStr = _newCodeStr regexreplace [_findRegex,_replaceRegex];
} foreach _pair;
call compile _newCodeStr; //Have to 'call' otherwise double brackets: {{ code }}
