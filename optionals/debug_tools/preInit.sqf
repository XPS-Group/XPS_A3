#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: bt_debugger. XPS_DT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS DT preInit]";


diag_log text "[XPS DT preInit End]";

ADDON = true;
