#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarSearch
<Interface>

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: Graph
		<HashmapObject>

	Property: Path
		<Array>

	Property: Status
		<String>

	Property: StartKey

	Property: EndKey

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
	["StartKey","ANYTHING"],
	["EndKey","ANYTHING"],
	["AdjustEstimatedDistance","CODE"], 
	["AdjustMoveCost","CODE"], 
	["FilterNeighbors","CODE"], 
	["Init","CODE"],
	["ProcessNextNode","CODE"]
]