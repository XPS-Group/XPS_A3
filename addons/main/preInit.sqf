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

/* -------------------------------------------------------------------------
Variable: main. XPS_DebugMode

Description:
	This returns true if game was launched with the -debug parameter -OR- XPS_DEBUG macro is forcefully defined.
	The effects it has when true is to force:
	
	- No obfuscation of 'private' properties
	- No compileFinal of Type Definitions (ignores isFinal = 1)
	- Always recompile (forces recompile = 1)

	If false, the above operate as normal or as defined according to the class properties

Returns: 
	<Boolean> 
---------------------------------------------------------------------------*/

diag_log text "[XPS preInit]";
private _start = diag_ticktime;

XPS_DebugMode = uinamespace getvariable "XPS_DebugMOde";

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
diag_log text format ["[XPS preInit End: %1 secs]",diag_tickTime - _start];