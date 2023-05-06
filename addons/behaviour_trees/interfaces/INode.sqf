#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: behaviour_trees. XPS_BT_ifc_INode
<Interface>

Authors:
    Crashdome

	Property: NodeType
	<String> - should only return "COMPOSITE", "DECORATOR", "LEAF"

	Property: Blackboard
	<HashmapObject>

	Method: Init
	
	Method: Tick
---------------------------------------------------------------------------- */
[
	["NodeType", "STRING"],
	["Blackboard", "HASHMAP"],
	["Init","CODE"],
	["Tick","CODE"]
]