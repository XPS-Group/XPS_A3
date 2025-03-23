#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS BT preInit]";


diag_log text "[XPS BT preInit End]";

ADDON = true;