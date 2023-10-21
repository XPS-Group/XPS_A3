#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IJobScheduler
<Interface>

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: CurrentItem
	<Hashmap> or <HashmapObject>

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
	["CurrentItem","STRING"],
	["Queue","ARRAY"],
	["ProcessesPerFrame","SCALAR"],
	["ProcessCurrent","CODE"],
	["FinalizeCurrent","CODE"],
	["Start","CODE"],
	["Stop","CODE"]
]