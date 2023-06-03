private _fnc_parseTDClass = {
	if !(params [["_class",nil,[configFile]]]) exitwith {false;};
	private _file = _class >> "file";
	private _var = _class >> "var";
	private _type = _class >> "type";
	if (isText _var && isText _file && isText _type) then {
		private _varName = getText _var;
		private _typeDefinition = uiNamespace getVariable _varName;
		if (isNil {_typeDefinition}) then {
			private _statement = "";
			switch (gettext _type) do {
				case "ifc" : {_statement = "call compileScript [""%1"",false];"};
				case "typ" : {_statement = "[call compileScript [""%1"",false]] call XPS_fnc_buildTypeDefinition;"};
			};
			private _code =  format[_statement,getText _file];
			private _result = call compile _code;
			uiNamespace setvariable [_varName,_result];
			missionNamespace setvariable [_varName,_result];
		} else {
		 	missionNamespace setvariable [_varName,_typeDefinition];
		};
	};
	{
			if (isClass _x) then {[_x] call _fnc_parseTDClass;};
	} foreach configProperties [_class];
};

{
	if (isClass _x) then {[_x] call _fnc_parseTDClass;};
} foreach configProperties [configFile >> "Enhanced_XPS_Type_Definitions"];
