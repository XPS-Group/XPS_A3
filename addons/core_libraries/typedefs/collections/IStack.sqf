#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IStack
<Interface>

	--- prototype
	XPS_ifc_IStack : XPS_ifc_IList
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

	Method: Pop
		<Code>
	
	Method: Push
		<Code>
	
	Method: PushUnique
		<Code>

	Method: Peek
		<Code>

---------------------------------------------------------------------------- */
[
	["@",XPS_ifc_IList],
	["Pop","CODE"],
	["Push","CODE"],
	["PushUnique","CODE"],
	["Peek","CODE"]
]