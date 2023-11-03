#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: main. xps_main

Description:
	This returns true once the preInit type 
	preprocessing and building has been completed

Returns: <Boolean>
---------------------------------------------------------------------------*/
ADDON = false;

//diag_log text "[XPS preInit]";
{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [configFile >> QXPS_CFG_I_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [missionConfigFile >> QXPS_CFG_I_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [campaignConfigFile >> QXPS_CFG_I_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [configFile >> QXPS_CFG_TD_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [missionConfigFile >> QXPS_CFG_TD_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [campaignConfigFile >> QXPS_CFG_TD_BASECLASSNAME];

ADDON = true;
//diag_log text "[XPS preInit End]";