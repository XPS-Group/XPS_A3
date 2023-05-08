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
	<main.XPS_ifc_IAstarNodes>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_PF_typ_RoadGraph"}],
	["#interfaces",["XPS_ifc_IAstarNodes"]],
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
	Protected: endPos
    
    	--- Prototype --- 
    	get "endPos"
    	---
    
    Returns: 
		<Array> - final goal position 
	-----------------------------------------------------------------------------*/
	["endPos",[]],
	/*----------------------------------------------------------------------------
	Protected: startPos
    
    	--- Prototype --- 
    	get "startPos"
    	---
    
    Returns: 
		<Array> - starting position
	-----------------------------------------------------------------------------*/
	["startPos",[]],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_typ_RoadGraph",[_startPos*,_endPos*]]
    	---
    
    Optionals: 
		_startPos* - <Array> - (Optional - Default : [0,0,0]) 
    	_endPos* - <Array> - (Optional - Default : [0,0,0]) 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_startPos",[0,0,0],[[]],[2,3]],["_endPos",[0,0,0],[[]],[2,3]]];
		private _roads = nearestTerrainObjects [_startPos,["Main Road","Road","Track"],50,true];
		_self set ["startPos",getpos _roads#0];
		_self set ["currentRoadObject",_roads#0];
		_roads = nearestTerrainObjects [_endPos,["Main Road","Road","Track"],50,true];
		_self set ["endPos",getpos _roads#0];
	}],
	/*----------------------------------------------------------------------------
	Method: GetEstimatedDistance
    
    	--- Prototype --- 
    	call ["GetEstimatedDistance",[_currentPos,_endPos]]
    	---

		<main.XPS_ifc_IAstarNodes>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_endPos - <Array> - goal position
	-----------------------------------------------------------------------------*/
	["GetEstimatedDistance",compileFinal {
		params ["_currentPos","_endPos"];
		_currentPos distance _endPos;
	}],
	/*----------------------------------------------------------------------------
	Method: GetNeighbors
    
    	--- Prototype --- 
    	call ["GetNeighbors",[_currentPos,_endPos]]
    	---

		<main.XPS_ifc_IAstarNodes>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_endPos - <Array> - goal position
	-----------------------------------------------------------------------------*/
	["GetNeighbors",compileFinal {
		params ["_currentPos"];
		private _road = roadAt _currentPos;
		private _neighbors = roadsConnectedTo _road;
		private _result = [];
		private _prevRoadObject = _self get "currentRoadObject";
		_self set ["currentRoadObject",_road];
		{if !(_x isEqualTo _prevRoadObject) then {_result pushback (getpos _x);}} foreach _neighbors;
		_result;
	}],
	/*----------------------------------------------------------------------------
	Method: GetMoveCost
    
    	--- Prototype --- 
    	call ["GetMoveCost",[_currentPos,_nextPos]]
    	---

		<main.XPS_ifc_IAstarNodes>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_nextPos - <Array> - connected road location
	-----------------------------------------------------------------------------*/
	["GetMoveCost",compileFinal {
		params ["_currentPos","_nextPos"];
		_currentPos distance _nextPos;
	}],
	/*----------------------------------------------------------------------------
	Method: GetHeuristic
    
    	--- Prototype --- 
    	call ["GetHeuristic",[_currentPos,_nextPos]]
    	---

		<main.XPS_ifc_IAstarNodes>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_nextPos - <Array> - connected road location
	-----------------------------------------------------------------------------*/
	["GetHeuristic",compileFinal {
		params ["_currentPos","_nextPos"];
		private _road = roadAt _nextPos;
		private _info = gteRoadInfo _road;
		private _result = 0;
		switch (_info#0) do {
			case "MAIN ROAD" : {_result = 0};
			case "ROAD" : {_result = 1};
			case "TRACK" : {_result = 2};
			default {_result = 0};
		};
		_result;
	}]
]