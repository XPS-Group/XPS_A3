#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: unit_testing. typeHandlers. XPS_fnc_parseUnitTestClass
	
	---prototype
	_result = [_class,_tag*] call XPS_fnc_parseUnitTestClass
	---

Description:
    Internal only. Reads a Type Definition config entry from the configfile and stores the 
	data in a Unit Test singleton class. This function is recursive.

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
	_tag = getText (_class >> "tag");
};

private _fnc_loadFile = {
	params ["_file"];
	private _statement = "createhashmapobject [ [ call compileScript [""%1"",false] ,false ,true ,true ,true ] call XPS_fnc_buildTypeDefinition ];";
	private _code =  format[_statement,_file];
	call compile _code;
};

private _file = _class >> "file";

if (isText _file) then {

	_file = getText _file;
	private _varName = format ["%1_%2",_tag,configName _class];
	private _testClass = uiNamespace getVariable _varName;

	if (isNil {_testClass}) then {
		uiNamespace setvariable [_varName, [_file] call _fnc_loadFile];
		missionNamespace setvariable [_varName,uiNamespace getVariable _varName];
	} else {
		if (isFilePatchingEnabled) then {
			missionNamespace setvariable [_varName,[_file] call _fnc_loadFile];
		} else {
			missionNamespace setvariable [_varName,_testClass];
		};
	};
	XPS_UT_Engine call ["GetInstance"] call ["AddClass",[_varName+"_"+([4] call XPS_fnc_createUniqueID),missionNamespace getVariable _varName]];
};

{
		if (isClass _x) then {[_x,_tag] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [_class];

true;
