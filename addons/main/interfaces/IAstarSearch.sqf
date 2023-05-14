#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarSearch
<Interface>

Authors:
    Crashdome

	Property: Graph
		<HashmapObject>

	Property: Path
		<Array>

	Method: InitGraph

	Method: ProcessNextNode
---------------------------------------------------------------------------- */
[
	["Graph","HASHMAP"],
	["Path","ARRAY"],
	["InitGraph","CODE"],
	["ProcessNextNode","CODE"]
]