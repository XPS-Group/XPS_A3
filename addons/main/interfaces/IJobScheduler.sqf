#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IJobScheduler
<Interface>

Authors:
    Crashdome

	Property: CurrentItem
	<Hashmap> or <HashmapObject>

	Property: Queue
	<Array>

	Method: ProcessCurrent
	
	Method: FinalizeCurrent
---------------------------------------------------------------------------- */
[
	["CurrentItem","HASHMAP"],
	["Queue","ARRAY"],
	["ProcessesPerFrame","SCALAR"],
	["ProcessCurrent","CODE"],
	["FinalizeCurrent","CODE"],
	["Start","CODE"],
	["Stop","CODE"]
]