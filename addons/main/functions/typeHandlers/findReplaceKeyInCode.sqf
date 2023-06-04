#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_findReplaceKeyInCode
	
	---prototype
	_result = [_find,_replace,_code] call XPS_fnc_preprXPS_fnc_findReplaceKeyInCodeocessTypeDefinition
	---

Description:
    
	Replaces a key such as a private key "_key" with a different key. The values must be in quotes in code block.

Parameter: _find 

	<String> - the string to find

Parameter: _replace 

	<String> - the string to replace found string

Parameter: _code 

	<Code> - any code block

Return: _result

	<Code> - the code with replaced <strings>

Example:
	
	---
	private _code = {_self call "_privateKey"}; // note _privateKey is in quotes
	private _find = "_privateKey";
	private _replace = "ABCD";
	_result = [_find,_replace,_code] call XPS_fnc_preprXPS_fnc_findReplaceKeyInCodeocessTypeDefinition
	// _result is: {_self call "ABCD"}
	---

Authors: 
	Crashdome

---------------------------------------------------------------------------- */
params [["_find","",[""]],["_replace","",[""]],["_code",{},[{}]]];

private _findRegex = """""+" insert [1,_find];
private _replaceRegex = """""" insert [1,_replace];
private _newCodeStr = (str _code) regexreplace [_findRegex,_replaceRegex];
call compile _newCodeStr; //Have to 'call' otherwise double brackets: {{ code }}