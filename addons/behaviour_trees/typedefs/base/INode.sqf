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

	Property: NodeType
	<Enumeration>

	Property: Status
	<Enumeration>

	Method: Init
		<code>

	Method: Tick
		<code>

---------------------------------------------------------------------------- */
[
	["NodeType", "STRING"],
	["Status","ANYTHING"],
	["Init","CODE"],
	["Tick","CODE"]
]
