#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IDelay
	<Interface>
	---prototype
	XPS_ifc_IDelay
	---

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: AutoReset
		<Boolean>

	Property: Delay
		<Number>

	Method: Start
		<Code>

	Method: Stop
		<Code>

	Method: Reset
		<Code>

	Property: Elapsed
		<XPS_typ_EventHandler>
---------------------------------------------------------------------------- */
[
	["AutoReset","BOOL"],
    ["Delay","SCALAR"],
    ["Start","CODE"],
    ["Stop","CODE"],
    ["Reset","CODE"],
    ["Elapsed","XPS_typ_EventHandler"]
]