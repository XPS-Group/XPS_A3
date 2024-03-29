#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: core. XPS_Core

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS Core preInit]";

// Singleton Class Instantiations ------------------------------------------

// Static Class Instantiations --------------------------------------------
/* -------------------------------------------------------------------------
Variable: core. XPS_Enum
	<Static>

Description:
	Used to compare and inspect <Enumeration> Types.

	See <XPS_typ_Enum> for more info on operations.

Returns: 
	<Static> - of <XPS_typ_Enum>
---------------------------------------------------------------------------*/
XPS_Enum = compilefinal createhashmapobject [XPS_typ_Enum];

diag_log text "[XPS Core preInit End]";

ADDON = true;