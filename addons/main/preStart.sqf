#include "script_component.hpp"

with uiNamespace do{
	// diag_log "[XPS preStart]";
	{
		if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
	} foreach configProperties [configFile >> QXPS_CFG_BASECLASSNAME];
	// diag_log "[XPS preStart End]";
};