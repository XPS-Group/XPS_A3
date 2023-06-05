#include "script_component.hpp"
diag_log "[XPS preInit]";
{
	if (isClass _x) then {diag_log _x;_result = [_x] call XPS_fnc_parseTypeDefClass;diag_log [_result]};
} foreach configProperties [configFile >> QXPS_CFG_BASECLASSNAME];

diag_log "[XPS preInit End]";