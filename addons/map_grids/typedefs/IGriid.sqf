#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: map_grids. XPS_MG_ifc_IGrid
<Interface>

Authors:
    Crashdome
----------------------------------------------------------------------------

	Property: Cells
	<HASHMAP>

	Method: GetPositionByIndex

	Method: GetIndexByPosition

	Method: GetNearbyIndexes

	Method: GetCellByPosition

	Method: GetNearbyCells
	
---------------------------------------------------------------------------- */
[
	["Cells", "HASHMAP"],
	["GetPositionByIndex","CODE"],
	["GetIndexByPosition","CODE"],
	["GetNearbyIndexes","CODE"],
	["GetCellByPosition","CODE"],
	["GetNearbyCells","CODE"],
]