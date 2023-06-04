#include "script_component.hpp"
diag_log "[XPS preInit]";

{
	if (isClass _x) then {[_x,true] call XPS_fnc_parseTypeDefClass;};
} foreach configProperties [configFile >> QXPS_CFG_BASECLASSNAME];

diag_log "[XPS preInit End]";