#include "script_component.hpp"

XPS_DebugMode = false;
#ifdef XPS_DEBUG
	XPS_DebugMode = true;
#endif

uinamespace setvariable ["XPS_DebugMode",XPS_DebugMode];

with uiNamespace do{
	diag_log text "[XPS preStart]";
	{
		if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
	} foreach configProperties [configFile >> QXPS_CFG_TD_BASECLASSNAME];
	diag_log text "[XPS preStart End]";
};