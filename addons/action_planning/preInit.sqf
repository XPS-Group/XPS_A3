#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: action_planning. XPS_AP

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS AP preInit]";


diag_log text "[XPS AP preInit End]";

ADDON = true;