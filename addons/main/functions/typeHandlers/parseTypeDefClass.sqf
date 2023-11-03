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
		<Boolean> - True is successful, otherwise false

---------------------------------------------------------------------------- */
if !(params [["_class",nil,[configFile]],"_tag"]) exitwith {false;};

_tag = [_tag] param [0,configName _class,[""]];
if (isText (_class >> "tag")) then {
	//diag_log text format ["[XPS TD parser] : changing TAG: %1",_tag];
	_tag = getText (_class >> "tag");
};

private _fnc_loadFile = {
	params ["_type","_file","_allowNils","_preprocess","_noStack","_isFinal_Cmd"];
	private _statement = "";
	switch (_type) do {
		case "ifc" : {_statement = "%5 createhashmapfromarray (call compileScript [""%1"",false]);"};
		case "typ" : {_statement = /* "%5 createhashmapfromarray " */ "([call compileScript [""%1"",false],%2,%3,%4] call XPS_fnc_buildTypeDefinition);"}; // hashmap disabled until bug fix in stable branch
	};
	private _code =  format[_statement,_file,_allowNils,_preprocess,_noStack,_isFinal_Cmd];
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
	private _isFinal_Cmd = if (_isFinal==1) then {"compileFinal"} else {""};

	// diag_log text format ["[XPS TD parser]  : var: %1 - recompile: %2",_varname,_recompile];
	if (isNil {_typeDefinition}) then {
		// diag_log text "[XPS TD parser]  : init namespace variables";
		uiNamespace setvariable [_varName, [_type,_file,(_allowNils==1),(_preprocess==1),(_noStack==1),_isFinal_Cmd] call _fnc_loadFile];
		missionNamespace setvariable [_varName,uiNamespace getVariable _varName];
	} else {
		if ((_recompile == 1 || isFilePatchingEnabled) /* && _isFinal==0 */) then {
			// diag_log text "[XPS TD parser]  : recompiling";
			missionNamespace setvariable [_varName,[_type,_file,(_allowNils==1),(_preprocess==1),(_noStack==1),""] call _fnc_loadFile];
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
