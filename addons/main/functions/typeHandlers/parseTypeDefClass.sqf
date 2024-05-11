#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_parseTypeDefClass
	
	---prototype
	_result = [_class,_tag*] call XPS_fncparseTypeDefClass
	---

Description:
    Internal only. Reads a Type Definition config entry from the configfile and stores the 
	data in the UI and Mission namespace for caching purposes. This function 
	is recursive.

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _class
		<Config> - the class and assocaiated subclasses to parse 

	Optional: _tag*
		<string> - (Optiona - Default is configName of class)  

	Return: _result
		<Boolean> - <True> is successful, otherwise false

---------------------------------------------------------------------------- */
if !(params [["_class",nil,[configFile]],"_tag"]) exitwith {false;};
disableSerialization;
_tag = [_tag] param [0,configName _class,[""]];
if (isText (_class >> "tag")) then {
	//diag_log text format ["[XPS TD parser] : changing TAG: %1",_tag];
	_tag = getText (_class >> "tag");
};

private _fnc_loadFile = {
	params ["_type","_file","_allowNils","_preprocess","_noStack","_isFinal_Cmd","_headers"];
	private _statement = "";
	switch (_type) do {
		case "ifc" : {_statement = "private _ifc = [call compileScript [""%1"",false]] call XPS_fnc_preprocessInterface; if (_ifc isEqualType []) then {%5 createhashmapfromarray _ifc;};"};
		case "enum";
		case "typ" : {_statement = "private _td = [call compileScript [""%1"",false],%2,%3,%4,%6] call XPS_fnc_buildTypeDefinition; if (_td isEqualType []) then {%5 createhashmapfromarray _td;};"}; 
	};
	private _code =  format[_statement,_file,_allowNils,_preprocess,_noStack,_isFinal_Cmd,_headers];
	call compile _code;
};

//diag_log text format ["[XPS TD parser] : parsing TAG: %1 - CLASS: %2",_tag, configName _class];
private _file = _class >> "file";
private _type = _class >> "type";

if (isText _file && isText _type) then {

	_type = getText _type;
	_file = getText _file;
	private _varName = format ["%1_%2_%3",_tag,_type,configName _class];
	private _typeDefinition = uiNamespace getVariable _varName;
	private _preprocess = if (isNumber (_class >> "preprocess")) then {getNumber (_class >> "preprocess")} else {1};
	private _allowNils = if (isNumber (_class >> "allowNils")) then {getNumber (_class >> "allowNils")} else {1};
	private _recompile = if (isNumber (_class >> "recompile")) then {getNumber (_class >> "recompile")} else {0};
	private _noStack = if (isNumber (_class >> "noStack")) then {getNumber (_class >> "noStack")} else {0};
	private _isFinal = if (isNumber (_class >> "isFinal")) then {getNumber (_class >> "isFinal")} else {0};
	private _headers = if (isNumber (_class >> "headerType")) then {getNumber (_class >> "headerType")} else {0};
	
	// Account if in 'debug mode' and force recompilation
	if (!(isnil "XPS_DebugMode") && XPS_DebugMode) then { _isFinal = 0; _recompile = 1;}; 
	
	private _isFinal_Cmd = ["", "compileFinal"] select (_isFinal isEqualTo 1);

	// diag_log text format ["[XPS TD parser]  : Variable: %1 - recompile: %2",_varname,_recompile];
	if (isNil {_typeDefinition} || {(_recompile isEqualTo 1 || isFilePatchingEnabled) && {_isFinal isEqualTo 0}}) then {
		// diag_log text "[XPS TD parser]  : init namespace variables";
		uiNamespace setvariable [_varName, [_type,_file,(_allowNils isEqualTo 1),(_preprocess isEqualTo 1),(_noStack isEqualTo 1),_isFinal_Cmd,(_headers isEqualTo 1)] call _fnc_loadFile];
		missionNamespace setvariable [_varName,uiNamespace getVariable _varName];
	} else {
		// diag_log text "[XPS TD parser]  : using cached";
		missionNamespace setvariable [_varName,_typeDefinition];
	};
};

{
		if (isClass _x) then {[_x,_tag] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [_class];

true;
