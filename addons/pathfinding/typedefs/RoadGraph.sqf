#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_RoadGraph
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Navigates a road path for <XPS_typ_AstarSearch> from a starting location to an
	end location.

Parent:
	none

Implements: 
	<main.XPS_ifc_IAstarGraph>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_PF_typ_RoadGraph"}],
	["#interfaces",["XPS_ifc_IAstarGraph"]],
	/*----------------------------------------------------------------------------
	Protected: currentRoadObject
    
    	--- Prototype --- 
    	get "currentRoadObject"
    	---
    
    Returns: 
		<Object> - the current road object to process 
	-----------------------------------------------------------------------------*/
	["currentRoadObject",nil],
	/*----------------------------------------------------------------------------
	Protected: heuristic
    
    	--- Prototype --- 
    	call ["heuristic",[_currentPos,_nextPos]]
    	---

		<main.XPS_ifc_IAstarGraph>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_nextPos - <Array> - connected road location
	-----------------------------------------------------------------------------*/
	["heuristic",compileFinal {
		params ["_next"];
		private _road = _next get "RoadObject";
		private _info = getRoadInfo _road;
		private _result = 1.5;
		switch (_info#0) do {
			case "MAIN ROAD" : {_result = 1};
			case "ROAD" : {_result = 1.2};
			// case "TRACK" : {_result = 10};
			// default {_result = 10};
		};
		_result;
	}],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init", [_startPos*,_endPos*]]
    	---
    
    Optionals: 
		_startPos* - <Array> - (Optional - Default : [0,0,0]) 
    	_endPos* - <Array> - (Optional - Default : [0,0,0]) 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["Init",compileFinal {
	}],
	/*----------------------------------------------------------------------------
	Method: GetEstimatedDistance
    
    	--- Prototype --- 
    	call ["GetEstimatedDistance",[_currentPos,_endPos]]
    	---

		<main.XPS_ifc_IAstarGraph>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_endPos - <Array> - goal position
	-----------------------------------------------------------------------------*/
	["GetEstimatedDistance",compileFinal {
		params ["_current","_end"];
		(_current get "RoadObject") distance (_end get "RoadObject");
	}],
	/*----------------------------------------------------------------------------
	Method: GetNeighbors
    
    	--- Prototype --- 
    	call ["GetNeighbors",[_currentPos,_endPos]]
    	---

		<main.XPS_ifc_IAstarGraph>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_endPos - <Array> - goal position
	-----------------------------------------------------------------------------*/
	["GetNeighbors",compileFinal {
		params ["_current",["_prev",nil,[createhashmap]]];
		private _neighbors = roadsConnectedTo (_current get "RoadObject");
		private _result = [];
		private _prevRoadObject = if (isNil "_prev") then {objNull} else {_prev get "RoadObject"};
		_self set ["currentRoadObject",_current get "RoadObject"];
		{if !(_x isEqualTo _prevRoadObject) then {_result pushback (createhashmapfromarray [["Index",str _x],["RoadObject",_x]]);}} foreach _neighbors;
		_result;
	}],
	/*----------------------------------------------------------------------------
	Method: GetMoveCost
    
    	--- Prototype --- 
    	call ["GetMoveCost",[_currentPos,_nextPos]]
    	---

		<main.XPS_ifc_IAstarGraph>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_nextPos - <Array> - connected road location
	-----------------------------------------------------------------------------*/
	["GetMoveCost",compileFinal {
		params ["_current","_next"];
		((_current get "RoadObject") distance (_next get "RoadObject")) * (_self call ["heuristic",[_next]]);
	}],
	["GetNodeAt",{
		params [["_pos",[0,0,0],[[]],[2,3]]];
		private _roads = nearestTerrainObjects [_pos,["Main Road","Road","Track"],50,true];
		createhashmapfromarray [["Index",str (_roads#0)],["RoadObject",(_roads#0)]];
	}]
]