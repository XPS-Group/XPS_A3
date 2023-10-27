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

	Property: Queue
	<Array>

	Property: ProcessesPerFrame
	<Number>

	Method: ProcessCurrent
	
	Method: FinalizeCurrent
	
	Method: Start
	
	Method: Stop
---------------------------------------------------------------------------- */
[
	["CurrentItem","ANYTHING"],
	["CurrentUID","STRING"],
	["Queue","ARRAY"],
	["ProcessesPerFrame","SCALAR"],
	["ProcessCurrent","CODE"],
	["FinalizeCurrent","CODE"],
	["Start","CODE"],
	["Stop","CODE"]
]