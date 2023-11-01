#include "script_component.hpp"

ADDON = false;

// Singleton Class Instantiations ------------------------------------------
/* -------------------------------------------------------------------------
Variable: core. XPS_ExceptionHandler
	<Singleton>

	--- prototype
	XPS_ExceptionHandler get "#type"
	---

Description:
	A <HashmapObject> which is used to aide with Exceptions

	See <XPS_typ_ExceptionHandler> for more info on operations.

Returns: 
	<Singleton> - of <XPS_typ_ExceptionHandler>
---------------------------------------------------------------------------*/
["XPS_ExceptionHandler",XPS_typ_ExceptionHandler] call XPS_fnc_createSingleton;


ADDON = true;