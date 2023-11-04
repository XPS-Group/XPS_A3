#include "script_component.hpp"

ADDON = false;

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
["XPS_MissionDebugger",call compileScript ["x\xps\addons\core\typedefs\MissionDebugger.sqf",false]] call XPS_fnc_createSingleton;


ADDON = true;