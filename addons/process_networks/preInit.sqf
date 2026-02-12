#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: process_networks. XPS_PN

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS PN preInit]";


diag_log text "[XPS PN preInit End]";

ADDON = true;
