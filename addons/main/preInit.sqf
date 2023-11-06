#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: main. xps_main

Description:
	This returns true once the preInit type 
	preprocessing and building has been completed

Returns: <Boolean>
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS preInit]";

// XPS_DebugHeader_FNC = "private _xps_dbg_name = ""%1.%2"";private _xps_dbg_caller = if (isNil ""_xps_dbg_caller"") then {_self get ""#type"" select 0} else {_xps_dbg_caller};private _xps_dbg_context = if (isNil ""_xps_dbg_context"") then {_xps_dbg_caller + ([4] call xps_fnc_createuniqueid)} else {_xps_dbg_context};XPS_MissionDebugger call [""GetInstance""] call [""AddToCallStack"",[diag_scope,""FNC"",_xps_dbg_context,_xps_dbg_caller,_xps_dbg_name,_this,diag_stacktrace]];";
// XPS_DebugHeader_TYP = "private _xps_dbg_name = ""%1.%2"";private _xps_dbg_caller = if (isNil ""_xps_dbg_caller"") then {_self get ""#type"" select 0} else {_xps_dbg_caller};private _xps_dbg_context = if (isNil ""_xps_dbg_context"") then {_xps_dbg_caller + ([4] call xps_fnc_createuniqueid)} else {_xps_dbg_context};XPS_MissionDebugger call [""GetInstance""] call [""AddToCallStack"",[diag_scope,""FNC"",_xps_dbg_context,_xps_dbg_caller,_xps_dbg_name,_this,diag_stacktrace]];";
XPS_DebugHeader_FNC = "";
XPS_DebugHeader_TYP = "";

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
diag_log text "[XPS preInit End]";