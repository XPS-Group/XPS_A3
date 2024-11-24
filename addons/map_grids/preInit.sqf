#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: map_grids. XPS_MG

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS MG preInit]";

// Static Class Instantiations --------------------------------------------
/* -------------------------------------------------------------------------
Variable: map_grids. XPS_MG_HexGrid
	<Static>

Description:
	Used to calculate index positions of a hex grid.

	See <XPS_MG_typ_HexGrid> for more info on operations.

Returns: 
	<Static> - of <XPS_MG_typ_HexGrid>
---------------------------------------------------------------------------*/
if (isNil "XPS_MG_HexGrid") then {XPS_MG_HexGrid = compileFinal createHashmapObject [XPS_MG_typ_HexGrid];};

/* -------------------------------------------------------------------------
Variable: map_grids. XPS_MG_SquareGrid
	<Static>

Description:
	Used to calculate index positions of a hex grid.

	See <XPS_MG_typ_SquareGrid> for more info on operations.

Returns: 
	<Static> - of <XPS_MG_typ_SquareGrid>
---------------------------------------------------------------------------*/
if (isNil "XPS_MG_SquareGrid") then {XPS_MG_SquareGrid = compileFinal createHashmapObject [XPS_MG_typ_SquareGrid];};

diag_log text "[XPS MG preInit End]";

ADDON = true;