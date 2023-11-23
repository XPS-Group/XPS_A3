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
		<code>

	Method: Stop
		<code>

---------------------------------------------------------------------------- */
[
	["CurrentItem","ANYTHING"],
	["CurrentUID","STRING"],
	["ProcessesPerFrame","SCALAR"],
	["Start","CODE"],
	["Stop","CODE"]
]