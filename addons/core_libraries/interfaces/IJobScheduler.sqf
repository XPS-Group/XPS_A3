#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IJobScheduler
<Interface>

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