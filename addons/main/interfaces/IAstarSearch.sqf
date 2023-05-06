#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarSearch
<Interface>

Authors:
    Crashdome

	Property: EndNode
		<HashmapObject>

	Property: Nodes
		<HashmapObject>

	Property: Path
		<Array>

	Property: StartNode
		<HashmapObject>

	Method: ProcessNextNode
---------------------------------------------------------------------------- */
[
	["EndNode","HASHMAP"],
	["Nodes","HASHMAP"],
	["Path","ARRAY"],
	["StartNode","HASHMAP"],
	["ProcessNextNode","CODE"]
]