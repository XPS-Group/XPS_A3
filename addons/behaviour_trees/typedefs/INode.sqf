#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: behaviour_trees. XPS_BT_ifc_INode
<Interface>
		---prototype
		XPS_BT_ifc_INode
		---

Authors:
    Crashdome
----------------------------------------------------------------------------

	Property: Blackboard
	<HashmapObject>

	Property: NodeType
	<Enumeration>

	Property: Status
	<Enumeration>

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