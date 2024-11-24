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
if !(params [["_class",nil,[configFile]],"_tag"]) exitWith {false;};
disableSerialization;
_tag = [_tag] param [0,configName _class,[""]];
if (isText (_class >> "tag")) then {
	//diag_log text format ["[XPS TD parser] : changing TAG: %1",_tag];
	_tag = getText (_class >> "tag");
};

private _fnc_loadFile = {
	private _array = 0;
	switch (_type) do {
		case "ifc" : {
			_array = (call compileScript [_file,false]) call XPS_fnc_preprocessInterface;
		};
		case "enum";
		case "typ" : {
			_array = [call compileScript [_file,false],_allowNils,_preprocess,_noStack] call XPS_fnc_buildTypeDefinition;
		}; 
	};
	if (_array isEqualType []) then {
		if (_isFinal) then {
			compileFinal createHashMapFromArray _array
		} else {
			createHashMapFromArray _array
		};
	};
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
	private _preprocess = if (isNumber (_class >> "preprocess")) then {getNumber (_class >> "preprocess") isEqualTo 1} else {true};
	private _allowNils = if (isNumber (_class >> "allowNils")) then {getNumber (_class >> "allowNils") isEqualTo 1} else {true};
	private _recompile = if (isNumber (_class >> "recompile")) then {getNumber (_class >> "recompile") isEqualTo 1} else {false};
	private _preCache = if (isNumber (_class >> "preCache")) then {getNumber (_class >> "preCache") isEqualTo 1} else {false};
	private _noStack = if (isNumber (_class >> "noStack")) then {getNumber (_class >> "noStack") isEqualTo 1} else {false};
	private _isFinal = if (isNumber (_class >> "isFinal")) then {getNumber (_class >> "isFinal") isEqualTo 1} else {false};
	
	// Account if in 'debug mode' or filePatching enabled then force recompilation 
	if ((!(isnil "XPS_DebugMode") && XPS_DebugMode) || {isFilePatchingEnabled}) then { _isFinal = false; _recompile = true;}; 
	
	// If recompiling, we can ignore preCaching
	if (_recompile) then {_precache = false;};

	// Only run during preStart if preCached -OR- during preInit
	if ((_preStart && _preCache) || {!_preStart}) then {

		//use UINamespace only if preCached or compiled and cached on first mission load
		if (_preCache || {!_reCompile}) then {
			if (isNil {_typeDefinition} || {_recompile && {!_isFinal}}) then {
				//diag_log text "[XPS TD parser]  : init namespace variables";
				uiNamespace setvariable [_varName, call _fnc_loadFile];
				missionNamespace setvariable [_varName,uiNamespace getVariable _varName];
			} else {
				//diag_log text "[XPS TD parser]  : using cached";
				if (isNil {missionNamespace getVariable _varName}) then {
					missionNamespace setvariable [_varName,_typeDefinition];
				};
			};
		} else {
			//We are recompiling each mission
			//diag_log text "[XPS TD parser]  : loading always";
			missionNamespace setvariable [_varName, call _fnc_loadFile];
		};
	};
};

{
		if (isClass _x) then {[_x,_tag] call XPS_fnc_parseTypeDefClass;};
} forEach configProperties [_class];

true;
