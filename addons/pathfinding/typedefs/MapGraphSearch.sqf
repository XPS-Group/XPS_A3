#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_MapGraphSearch
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	
	An A* Search object for <MapGraphs>

Parent:
	<main. XPS_typ_AstarSearch>

Implements: 
	
	<main.XPS_ifc_IAstarSearch>

Flags: 
	none

	Protected: cameFrom
    
		<main.XPS_typ_AstarSearch.cameFrom>

	Protected: costSoFar
    
		<main.XPS_typ_AstarSearch.costSoFar>
		
	Protected: frontier
    
		<main.XPS_typ_AstarSearch.frontier>
		
	Protected: lastNode
    
		<main.XPS_typ_AstarSearch.lastNode>
		
	Protected: getPath
    
		<main.XPS_typ_AstarSearch.getPath>
		
	Protected: frontierAdd
    
		<main.XPS_typ_AstarSearch.frontierAdd>
		
	Protected: frontierPullLowest
    
		<main.XPS_typ_AstarSearch.frontierPullLowest>
		
	Property: Graph
    
		<main.XPS_typ_AstarSearch.Graph>
		
	Property: Doctrine
    
		<main.XPS_typ_AstarSearch.Doctrine>
		
	Property: Path
    
		<main.XPS_typ_AstarSearch.Path>
		
	Property: Status
    
		<main.XPS_typ_AstarSearch.Status>
		
	Method: AdjustEstimatedDistance
    
		<main.XPS_typ_AstarSearch.AdjustEstimatedDistance>

--------------------------------------------------------------------------------*/
[
	["#str",compileFinal {"XPS_PF_typ_MapGraphSearch"}],
	["#type","XPS_PF_typ_MapGraphSearch"],
	["#base",XPS_typ_AstarSearch"],
	/*----------------------------------------------------------------------------
	Method: AdjustMoveCost
    
		<main.XPS_typ_AstarSearch.AdjustMoveCost>
	-----------------------------------------------------------------------------*/
	["AdjustMoveCost",compileFinal {
		params ["_moveCost"];
	}],
	/*----------------------------------------------------------------------------
	Method: FilterNeighbors

		<main.XPS_typ_AstarSearch.FilterNeighbors>
	-----------------------------------------------------------------------------*/
	["FilterNeighbors",compileFinal {
		params ["_neighbors"];
		for "_i" from 0 to (count _neighbors)-1 do {
			if !(_self call ["canTraverse",[_current,_prev,_doctrine]]) then {
				_neighbors deleteat _i;
			};
		};
	}]
]