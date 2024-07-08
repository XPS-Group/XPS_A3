#include "script_component.hpp"

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

XPS_DebugMode = false;
#ifdef XPS_DEBUG
	XPS_DebugMode = true;
#endif

uinamespace setvariable ["XPS_DebugMode",XPS_DebugMode];
uinamespace setvariable [XPS_PRESTART_VAR,true];
diag_log format ["XPS_DebugMode:%1",XPS_DebugMode];
with uiNamespace do{
	diag_log text "[XPS preStart]";
	private _start = diag_ticktime;
	{
		if (isClass _x) then {_result = [_x] call XPS_fnc_parseTypeDefClass;};
	} foreach configProperties [configFile >> QXPS_CFG_TD_BASECLASSNAME];
	diag_log text format ["[XPS preStart End: %1 secs]",diag_tickTime - _start];
};

uinamespace setvariable [XPS_PRESTART_VAR,false];