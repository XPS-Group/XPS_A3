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
	["Queue","Array"],
	["ProcessCurrent","CODE"],
	["FinalizeCurrent","CODE"]
]