#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: behaviour_trees. XPS_BT_ifc_INode
<Interface>

Authors:
    Crashdome
----------------------------------------------------------------------------

	Property: Blackboard
	<HashmapObject>

	Property: NodeType
	<String> - should only return "COMPOSITE", "DECORATOR", "LEAF"

	Property: Status
	<String> - should only be one of the following: Nil , "SUCCESS", "FAILURE", or "RUNNING"

	Method: Init
	
	Method: Tick
---------------------------------------------------------------------------- */
[
	["Blackboard", "HASHMAP"],
	["NodeType", "STRING"],
	["Status","ANYTHING"],
	["Init","CODE"],
	["Tick","CODE"]
]