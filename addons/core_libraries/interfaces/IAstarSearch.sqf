#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarSearch
<Interface>

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: Path
		<Array>

	Property: Status

	Method: AdjustEstimatedDistance

	Method: AdjustMoveCost

	Method: FilterNeighbors

	Method: Init

	Method: ProcessNextNode
---------------------------------------------------------------------------- */
[
	["Path","ARRAY"],
	["Status","ANYTHING"],
	["AdjustEstimatedDistance","CODE"], 
	["AdjustMoveCost","CODE"], 
	["FilterNeighbors","CODE"], 
	["Init","CODE"],
	["ProcessNextNode","CODE"]
]