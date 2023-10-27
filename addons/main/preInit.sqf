#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: main. xps_main

Description:
	This returns true once the preInit type 
	preprocessing and building has been completed

Returns: <Boolean>
---------------------------------------------------------------------------*/
ADDON = false;

//diag_log "[XPS preInit]";
{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [configFile >> QXPS_CFG_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [missionConfigFile >> QXPS_CFG_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [campaignConfigFile >> QXPS_CFG_BASECLASSNAME];

ADDON = true;
//diag_log "[XPS preInit End]";