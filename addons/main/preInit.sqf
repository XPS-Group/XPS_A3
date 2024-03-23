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

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [configFile >> QXPS_CFG_TD_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [missionConfigFile >> QXPS_CFG_TD_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [campaignConfigFile >> QXPS_CFG_TD_BASECLASSNAME];

/* -------------------------------------------------------------------------
Variable: main. XPS_DebugMode

Description:
	This returns true if game was launched with the -debug parameter -OR- XPS_DEBUG macro is forcefully defined

Returns: 
	<Boolean> 
---------------------------------------------------------------------------*/
XPS_DebugMode = false;
#ifdef XPS_DEBUG
	XPS_DebugMode = true;
#endif

ADDON = true;
diag_log text "[XPS preInit End]";