#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
Interface: process_network. XPS_PN_ifc_IProcess
	<Interface>
	---prototype
	XPS_PN_ifc_IProcess
	---

Authors:
    Crashdome
----------------------------------------------------------------------------
	Property: Name
		<String>
		
	Property: Status
		<Anything>

	Method: AddInput
		<Code>

	Method: AddOutput
		<Code>

	Method: CanExecute
		<Code>

	Method: Execute
		<Code>
---------------------------------------------------------------------------- */
[
	["Name", "STRING"],
	["Status", "ANYTHING"],
	["AddInput", "CODE"],
	["AddOutput", "CODE"],
	["CanExecute", "CODE"],
	["Execute", "CODE"]
]