#include "script_component.hpp"

ADDON = false;

XPS_DebugHeader_FNC = "private _xps_dbg_name = ""%1.%2"";private _xps_dbg_caller = if (isNil ""_xps_dbg_caller"") then {_self get ""#type"" select 0} else {_xps_dbg_caller};private _xps_dbg_context = if (isNil ""_xps_dbg_context"") then {_xps_dbg_caller + ([4] call xps_fnc_createuniqueid)} else {_xps_dbg_context};XPS_MissionDebugger call [""GetInstance""] call [""AddToCallStack"",[diag_scope,""FNC"",_xps_dbg_context,_xps_dbg_caller,_xps_dbg_name,_this,diag_stacktrace]];"
XPS_DebugHeader_TYP = "private _xps_dbg_name = ""%1.%2"";private _xps_dbg_caller = if (isNil ""_xps_dbg_caller"") then {_self get ""#type"" select 0} else {_xps_dbg_caller};private _xps_dbg_context = if (isNil ""_xps_dbg_context"") then {_xps_dbg_caller + ([4] call xps_fnc_createuniqueid)} else {_xps_dbg_context};XPS_MissionDebugger call [""GetInstance""] call [""AddToCallStack"",[diag_scope,""FNC"",_xps_dbg_context,_xps_dbg_caller,_xps_dbg_name,_this,diag_stacktrace]];"

// Singleton Class Instantiations ------------------------------------------
/* -------------------------------------------------------------------------
Variable: core. XPS_MissionDebugger
	<Singleton>

	--- prototype
	XPS_MissionDebugger get "#type"
	---

Description:
	A <HashmapObject> which is used to aide with Exceptions

	See <XPS_typ_MissionDebugger> for more info on operations.

Returns: 
	<Singleton> - of <XPS_typ_MissionDebugger>
---------------------------------------------------------------------------*/
["XPS_MissionDebugger",XPS_typ_MissionDebugger] call XPS_fnc_createMissionDebugger;


ADDON = true;