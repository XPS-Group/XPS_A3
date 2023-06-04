
if !(params [["_class",nil,[configFile]],"_setMissionNamespace"]) exitwith {false;};
_setMissionNamespace = [_settmissionNamespace] param [0,true,[true]];

private _fnc_loadFile = {
	params ["_type","_file","_allowNils","_prep"];
	private _statement = "";
	switch (gettext _type) do {
		case "ifc" : {_statement = "call compileScript [""%1"",false];"};
		case "typ" : {_statement = "[call compileScript [""%1"",false],%2,%3] call XPS_fnc_buildTypeDefinition;"};
	};
	private _code =  format[_statement,getText _file,_allowNils,_prep];
	call compile _code;
};

diag_log ["[XPS parser]  parsing ",str _type];
private _file = _class >> "file";
private _var = _class >> "var";
private _type = _class >> "type";

if (isText _var && isText _file && isText _type) then {

	private _varName = getText _var;
	private _typeDefinition = uiNamespace getVariable _varName;
	private _preprocess = if (isNumber (_class >> "preprocess")) then {getNumber (_class >> "preprocess")} else {0};
	private _allowNils = if (isNumber (_class >> "allowNils")) then {getNumber (_class >> "allowNils")} else {1};
	private _recompile = if (isNumber (_class >> "recompile")) then {getNumber (_class >> "recompile")} else {0};

	diag_log ["[XPS parser]  : ",str [_varname,_typedefinition,_recompile]];
	if (isNil {_typeDefinition}) then {
		private _result = [_type,_file,(_allowNils==1),(_preprocess==1)] call _fnc_loadFile;
		diag_log "[XPS parser]  : setting variables";
		uiNamespace setvariable [_varName,_result];
		if (_setMissionNamespace) then {
			missionNamespace setvariable [_varName,_result];
		};
	} else {
		if (_recompile == 1) then {
			diag_log "[XPS parser]  : recompiling";
			missionNamespace setvariable [_varName,[_type,_file,(_allowNils==1),(_preprocess==1)] call _fnc_loadFile];
		} else {
			diag_log "[XPS parser]  : using cached";
			missionNamespace setvariable [_varName,_typeDefinition];
		};
	};
};
{
		if (isClass _x) then {[_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [_class];

true;
