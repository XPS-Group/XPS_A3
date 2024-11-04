#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: main. XPS_Main

Description:
	This returns true once the preInit type 
	preprocessing and building has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS preInit]";
private _start = diag_ticktime;

XPS_DebugMode = uinamespace getvariable "XPS_DebugMode";

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} forEach configProperties [configFile >> QXPS_CFG_TD_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} forEach configProperties [missionConfigFile >> QXPS_CFG_TD_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} forEach configProperties [campaignConfigFile >> QXPS_CFG_TD_BASECLASSNAME];


ADDON = true;
diag_log text format ["[XPS preInit End: %1 secs]",diag_tickTime - _start];