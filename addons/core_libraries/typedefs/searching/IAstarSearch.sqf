#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IAstarSearch
<Interface>

	--- prototype
	XPS_ifc_IAstarSearch
	---

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: Path
		<Array>

	Property: Status
		Anything

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