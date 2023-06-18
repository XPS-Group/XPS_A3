#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarSearch
<Interface>

Authors:
    Crashdome

	Property: Graph
		<HashmapObject>

	Property: Path
		<Array>

	Method: AdjustEstimatedDistance

	Method: AdjustMoveCost

	Method: FilterNeighbors

	Method: Init

	Method: ProcessNextNode
---------------------------------------------------------------------------- */
[
	["Graph","HASHMAP"],
	["Path","ARRAY"],
	["Status","STRING"],
	["AdjustEstimatedDistance","CODE"], 
	["AdjustMoveCost","CODE"], 
	["FilterNeighbors","CODE"], 
	["Init","CODE"],
	["ProcessNextNode","CODE"]
]