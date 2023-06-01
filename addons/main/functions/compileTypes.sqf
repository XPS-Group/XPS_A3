
private _fnc_parseClass = {
	if !(params [["_class",nil,[configFile]]]) exitwith {false;};
	private _file = _class >> "file";
	private _var = _class >> "var";
	private _type = _class >> "type";
	if (isText _var && isText _file && isText _type) then {
		//if (isNil {uiNamespace getVariable _var}) then {
			private _statement = "";
			switch (_type) do {
				case "ifc" : {_statement = "call compileScript [""%1"",%2];"};
				case "typ" : {_statement = "[call compileScript [""%1"",%2]] call XPS_fnc_buildTypeDefinition;"};
			};
			private _code =  format[_statement,getText _file,true];
			private _result = call compile _code;
			uiNamespace setvariable [getText _var,_result];
			missionNamespace setvariable [getText _var,_result];
			//call compile format["%1 = uiNamespace getvariable ""%1""; ",gettext _var];
		// } else {
		// 	missionNamespace setvariable [_var,_result];
		// };
	};
	{
			if (isClass _x) then {[_x] call _fnc_parseClass;};
	} foreach configProperties [_class];
};

{
		if (isClass _x) then {[_x] call _fnc_parseClass;};
} foreach configProperties [configFile >> "Enhanced_XPS_Type_Definitions"];
