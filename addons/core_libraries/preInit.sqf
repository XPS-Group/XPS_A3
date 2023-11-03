#include "script_component.hpp"

ADDON = false;

// Singleton Class Instantiations ------------------------------------------
/* -------------------------------------------------------------------------
Variable: core. XPS_MissionCodeStack
	<Singleton>

	--- prototype
	XPS_MissionCodeStack get "#type"
	---

Description:
	A <HashmapObject> which is used to aide with Exceptions

	See <XPS_typ_MissionCodeStack> for more info on operations.

Returns: 
	<Singleton> - of <XPS_typ_MissionCodeStack>
---------------------------------------------------------------------------*/
["XPS_MissionCodeStack",XPS_typ_MissionCodeStack] call XPS_fnc_createSingleton;


ADDON = true;