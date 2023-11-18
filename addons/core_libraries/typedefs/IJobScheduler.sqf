#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IJobScheduler
	<Interface>
	---prototype
	XPS_ifc_IJobScheduler
	---

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: CurrentUID
	<String>

	Property: CurrentItem

	Property: ProcessesPerFrame
	<Number>
	
	Method: Start
	
	Method: Stop
---------------------------------------------------------------------------- */
[
	["CurrentItem","ANYTHING"],
	["CurrentUID","STRING"],
	["ProcessesPerFrame","SCALAR"],
	["Start","CODE"],
	["Stop","CODE"]
]