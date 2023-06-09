#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: action_planning. XPS_AP_ifc_IAction
<Interface>

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
	
	Method: Execute

	Method: GetScore
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