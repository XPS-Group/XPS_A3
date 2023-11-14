#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: map_grids. XPS_MG

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, False once preInit starts, True if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS MG preInit]";


diag_log text "[XPS MG preInit End]";

ADDON = true;