#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IQueue
<Interface>

	--- prototype
	XPS_ifc_IQueue : XPS_ifc_IList
	---

Authors:
    Crashdome
----------------------------------------------------------------------------

	Method: Count
		<XPS_ifc_IList.Count>
		
	Method: IsEmpty
		<XPS_ifc_IList.IsEmpty>

	Method: Clear
		<Code>

	Method: Dequeue
		<Code>
	
	Method: Enqueue
		<Code>

	Method: Peek
		<Code>

---------------------------------------------------------------------------- */
[
	["@",XPS_ifc_IList],
	["Dequeue","CODE"],
	["Enqueue","CODE"],
	["Peek","CODE"]
]