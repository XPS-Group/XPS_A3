#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: action_planning. XPS_AP_ifc_IAction
<Interface>
	---prototype
	XPS_AP_ifc_IAction
	---

Authors:
    Crashdome
----------------------------------------------------------------------------

	Property: Blackboard
	<HashmapObject>

	Property: Considerations
	<HashmapObject>

	Property: Preconditions
	<Array>

	Property: Postconditions
	<Array>

	Property: Status
	<String>

	Method: Init
		<code>

	Method: Execute
		<code>

	Method: GetScore
		<code>

---------------------------------------------------------------------------- */
[
	["Blackboard", "HASHMAP"],
	["Considerations", "HASHMAP"],
	["Preconditions","ARRAY"],
	["Postconditions","ARRAY"],
	["Status","STRING"],
	["Init","CODE"],
	["Execute","CODE"],
	["GetScore","CODE"]

]