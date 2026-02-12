#include "script_component.hpp"
/* -----------------------------------------------------------------------------
Interface: pathfinding. XPS_PF_ifc_IRoadNode
	<Interface>

Adds additional properties to <main. XPS_ifc_IAstarNode> for use with 
a <XPS_PF_typ_RoadGraphSearch> object.

Authors: 
	Crashdome
----------------------------------------------------------------------------
	Property: Width
    	<Number>

	Property: BeginPos
		<Array>
		
	Property: EndPos
    	<Array>
		
	Property: IsBridge
    	<Boolean>
		
	Property: PosASL
		<Array>
		
	Property: ConnectedTo
		<Array>
		
	Property: RoadObject
		<Anything>
		
	Property: Type
		<String>
--------------------------------------------------------------------------------*/
[
	["Width","SCALAR"],
	["BeginPos","ARRAY"],
	["EndPos","ARRAY"],
	["IsBridge","BOOL"],
	["PosASL","ARRAY"],
	["ConnectedTo","HASHMAP"],
	["RoadObject","ANY"],
	["Type","STRING"]
]
