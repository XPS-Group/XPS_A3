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
	//Set defaults as local vars
	private _properties = +XPS_type_Defaults;

	//Get property values in config
	{
		private _propName = _x select [1]; //remove the underscore to get prop name
		if (isNumber (_class >> _propName)) then {_properties set [_x, getNumber (_class >> _propName) isEqualTo 1]};
	} foreach keys _properties;

	values _properties params keys _properties;
	
	// Account if in 'debug mode' - force recompilation and no compileFinal
	if (!(isnil "XPS_DebugMode") && {XPS_DebugMode}) then { _isFinal = false; _recompile = true;}; 
	
	// If recompiling, we can ignore preCaching (recompile happens on Eden / Mission init - no need to run preStart for any reason)
	if (_recompile) then {_precache = false;};

	// Only run during preStart if preCached -OR- during preInit
	if ((_preStart && _preCache) || {!_preStart}) then {

		//use UINamespace only if preCached or compiled and cached on first mission load
		if (_preCache || {!_recompile}) then {
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
