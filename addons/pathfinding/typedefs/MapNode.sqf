#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_MapNode
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Represents an individual sector in the XPS_PF_typ_MapGraph <HashmapObject>

Parent:
	none

Implements: 

	<XPS_PF_ifc_IMapNode>

	<main. XPS_ifc_IAstarNode>

Flags: 
	none

--------------------------------------------------------------------------------*/
[	
	["#str",compileFinal {"XPS_PF_typ_MapNode"}],
	["#type","XPS_PF_typ_MapNode"],
	["@interfaces",["XPS_ifc_IAstarNode"]],
	/*----------------------------------------------------------------------------
	Property: Index
    
    	--- Prototype --- 
    	get "Index"
    	---
    
		<main. XPS_ifc_IAstarNode.Index>

    Returns: 
		<Array> - Index position (key) in MapGraph
	-----------------------------------------------------------------------------*/
	["Index",nil],
	/*----------------------------------------------------------------------------
	Property: PosRef
    
    	--- Prototype --- 
    	get "PosRef"
    	---

		<XPS_PF_ifc_IMapNode.PosRef>
    
    Returns: 
		<Array> - lower bound [x,y] position in world (bottom left corner)
	-----------------------------------------------------------------------------*/
	["PosRef",nil],
	/*----------------------------------------------------------------------------
	Property: PosCenter
    
    	--- Prototype --- 
    	get "PosCenter"
    	---

		<XPS_PF_ifc_IMapNode.PosCenter>
    
    Returns: 
		<Array> - center [x,y] position of square in world
	-----------------------------------------------------------------------------*/
	["PosCenter",nil],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_typ_MapSector",[_xAxis*,__yAxis*]]
    	---
    
    Optionals: 
		_xAxis* - <Number> - (Optional - Default : 0) - X value for <Index>
    	_yAxis* - <Number> - (Optional - Default : 0) - Y value for <Index>

	Returns:
		_result - <HashmapObject> - Sector Node
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_xAxis",0,[0]],["_yAxis",0,[0]]];
		_self set ["Index",[_xAxis,_yAxis]];
	}]
]