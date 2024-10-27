#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_RoadGraphSearch
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	
	An A* Search object for <RoadGraphs>

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
		
	Property: Path
    
		<main.XPS_typ_AstarSearch.Path>
		
	Property: Status
    
		<main.XPS_typ_AstarSearch.Status>
		
	Method: AdjustEstimate
    
		<main.XPS_typ_AstarSearch.AdjustEstimate>

--------------------------------------------------------------------------------*/
[
	["#str", compileFinal {"XPS_PF_typ_RoadGraphSearch"}],
	["#type","XPS_PF_typ_RoadGraphSearch"],
	["#base",XPS_typ_AstarSearch],
	/*----------------------------------------------------------------------------
	Method: AdjustCost
    
		<main.XPS_typ_AstarSearch.AdjustCost>
	-----------------------------------------------------------------------------*/
	["AdjustCost",compileFinal {
		params ["_cost","_fromNode","_toNode"];

		private _weights = _self get "Doctrine" get "Weights";
		private _road = _toNode get "RoadObject";
		private _info = getRoadInfo _road;
		private _modifier = _weights#2;
		switch (_info#0) do {
			case "MAIN ROAD" : {_modifier = _weights#0};
			case "ROAD" : {_modifier = _weights#1};
		};
		_cost * _modifier;
	}],
	/*----------------------------------------------------------------------------
	Method: FilterNeighbors

		<main.XPS_typ_AstarSearch.FilterNeighbors>
	-----------------------------------------------------------------------------*/
	["FilterNeighbors",compileFinal {
		params ["_neighbors"];
		private _types = _self get "Doctrine" get "RoadTypes";
		private _i = 0;
		while {_i < (count _neighbors)} do {
			if !(((_neighbors#_i) get "Type") in _types) then {
				_neighbors deleteat _i;
			} else {_i = _i + 1;};
		};
	}],
	/*----------------------------------------------------------------------------
	Property: Doctrine
    
    	--- Prototype --- 
    	set ["Doctrine",_doctrine]
    	---
    	--- Prototype --- 
    	get "Doctrine"
    	---
    
	Paramters:
		_doctrine - <XPS_PF_typ_RoadGraphDoctrine>
		
    Returns: 
		<HashmapObject> - A <HashmapObject> of heuristical values to apply to the graph
	-----------------------------------------------------------------------------*/
	["Doctrine",nil]
]