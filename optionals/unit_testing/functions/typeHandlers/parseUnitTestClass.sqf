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
		<string> - (Optional - Default is configName of class)  

	Return: _result
		<Array> - [ variableName, <object : XPS_UT_typ_TestClass>] or empty if not valid file

---------------------------------------------------------------------------- */
params [["_result",[],[[]]],["_class",nil,[configFile]],"_tag"];

_tag = [_tag] param [0,configName _class,[""]];
if (isText (_class >> "tag")) then {
	_tag = getText (_class >> "tag");
};

private _result = if (isNil "_result") then {[]} else {_result};

private _fnc_loadFile = {
	params ["_file"];
	private _statement = "createHashmapObject [ [ call compileScript [""%1"",false] ,false ,true ,true ,true ] call XPS_fnc_buildTypeDefinition ];";
	private _code =  format[_statement,_file];
	call compile _code;
};

private _file = _class >> "file";

if (isText _file) then {

	_file = getText _file;
	private _varName = format ["%1_%2",_tag,configName _class];
	private _testClass = uiNamespace getVariable _varName;

	if (isNil {_testClass} || isFilePatchingEnabled) then {
		uiNamespace setvariable [_varName, [_file] call _fnc_loadFile];
		missionNamespace setvariable [_varName,uiNamespace getVariable _varName];
	} else {
		missionNamespace setvariable [_varName,_testClass];
	};
	_result pushBack [_varName+"_"+([4] call XPS_fnc_createUniqueID),missionNamespace getVariable _varName];
};

{
	if (isClass _x) then {[_result,_x,_tag] call XPS_fnc_parseUnitTestClass;};
} forEach configProperties [_class];

_result;
