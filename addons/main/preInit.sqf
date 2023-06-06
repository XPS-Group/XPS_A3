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
	if (isClass _x) then {diag_log _x;_result = [_x] call XPS_fnc_parseTypeDefClass;diag_log [_result]};
} foreach configProperties [configFile >> QXPS_CFG_BASECLASSNAME];

ADDON = true;
//diag_log "[XPS preInit End]";