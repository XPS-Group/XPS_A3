#include "script_component.hpp"

ADDON = false;

// XPS_UT_Engine - Singleton Class Instantiation
["XPS_UT_Engine",call compileScript ["typedefs\Engine.sqf",true]] call XPS_fnc_createSingleton;

// XPS_UT_Assert - Static Class Instantiation
["XPS_UT_Assert","typedefs\Assert.sqf"] call XPS_fnc_createStaticFromFile;

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [configFile >> QXPS_UT_CFG_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [missionConfigFile >> QXPS_UT_CFG_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [campaignConfigFile >> QXPS_UT_CFG_BASECLASSNAME];

ADDON = true;