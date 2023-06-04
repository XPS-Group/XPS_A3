#include "script_component.hpp"
diag_log "[XPS preStart]";

{
	if (isClass _x) then {diag_log _x;_result = [_x,false] call XPS_fnc_parseTypeDefClass;diag_log [_result,str XPS_fnc_parseTypeDefClass]};
} foreach configProperties [configFile >> QXPS_CFG_BASECLASSNAME];

diag_log "[XPS preStart End]";