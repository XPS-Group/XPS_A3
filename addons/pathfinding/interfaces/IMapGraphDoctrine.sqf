#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: pathfinding. XPS_PF_ifc_IMapGraphDoctrine
<Interface>

Adds additional properties required by the MapGraph to pathfind

Authors:
    Crashdome

	Property: CanUseLand
	
	<Boolean>

	Property: CanUseTrails
	
	<Boolean>

	Property: CanUseRoads
	
	<Boolean>

	Property: CanUseWater
	
	<Boolean>

	Property: CanUseAir
	
	<Boolean>

	Property: MaxSlope
	
	<Number>

	Property: MaxDensity
	
	<Number>

	Property: Heuristics
	
	<Number>
---------------------------------------------------------------------------- */
[
	["Heuristics","ARRAY"]
    ["CanUseLand","BOOL"],
    ["CanUseTrails","BOOL"],
    ["CanUseRoads","BOOL"],
    ["CanUseWater","BOOL"],
    ["CanUseAir","BOOL"],
    ["MaxSlope","SCALAR"],
    ["MaxDensity","SCALAR"]
]