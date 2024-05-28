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
	private _preStart = uiNamespace getVariable XPS_PRESTART_VAR;
	private _preprocess = if (isNumber (_class >> "preprocess")) then {getNumber (_class >> "preprocess") isEqualTo 1} else {true1};
	private _allowNils = if (isNumber (_class >> "allowNils")) then {getNumber (_class >> "allowNils") isEqualTo 1} else {true};
	private _recompile = if (isNumber (_class >> "recompile")) then {getNumber (_class >> "recompile") isEqualTo 1} else {false};
	private _preCache = if (isNumber (_class >> "recompile")) then {getNumber (_class >> "preCache") isEqualTo 1} else {false};
	private _noStack = if (isNumber (_class >> "noStack")) then {getNumber (_class >> "noStack") isEqualTo 1} else {false};
	private _isFinal = if (isNumber (_class >> "isFinal")) then {getNumber (_class >> "isFinal") isEqualTo 1} else {false};
	private _headers = if (isNumber (_class >> "headerType")) then {getNumber (_class >> "headerType") isEqualTo 1} else {false};
	
	// Account if in 'debug mode' and force recompilation
	if (!(isnil "XPS_DebugMode") && XPS_DebugMode) then { _isFinal = false; _recompile = true;}; 
	
	private _isFinal_Cmd = ["", "compileFinal"] select (_isFinal);

	// Only cache on preStart if specified
	if ((_preStart && _preCache) || {!_preStart}) then {
		// diag_log text format ["[XPS TD parser]  : Variable: %1 - recompile: %2",_varname,_recompile];
		if (isNil {_typeDefinition} || {(_recompile isEqualTo 1 || isFilePatchingEnabled) && {_isFinal isEqualTo 0}}) then {
			// diag_log text "[XPS TD parser]  : init namespace variables";
			uiNamespace setvariable [_varName, call _fnc_loadFile];
			missionNamespace setvariable [_varName,uiNamespace getVariable _varName];
			diag_log ("CACHED: "+_varname);
		} else {
			// diag_log text "[XPS TD parser]  : using cached";
			missionNamespace setvariable [_varName,_typeDefinition];
		};
	};
};

{
		if (isClass _x) then {[_x,_tag] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [_class];

true;
