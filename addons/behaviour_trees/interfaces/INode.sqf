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
	<String>

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