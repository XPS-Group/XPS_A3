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
		<Anything>

	Method: AdjustEstimate
		<code>

	Method: AdjustCost
		<code>

	Method: FilterNeighbors
		<code>

	Method: Init
		<code>

	Method: ProcessNextNode
		<code>

---------------------------------------------------------------------------- */
[
	["Path","ARRAY"],
	["Status","ANYTHING"],
	["AdjustEstimate","CODE"], 
	["AdjustCost","CODE"], 
	["FilterNeighbors","CODE"], 
	["Init","CODE"],
	["ProcessNextNode","CODE"]
]