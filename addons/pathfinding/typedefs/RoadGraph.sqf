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
	["#create",compileFinal {
		params [["_startPos",[0,0,0],[[]],[2,3]],["_endPos",[0,0,0],[[]],[2,3]]];
		private _roads = nearestTerrainObjects [_startPos,["Main Road","Road","Track"],50,true];
		_self set ["startPos",getpos _roads#0];
		_self set ["currentRoadObject",_roads#0];
		_roads = nearestTerrainObjects [_endPos,["Main Road","Road","Track"],50,true];
		_self set ["endPos",getpos _roads#0];
	}],
	["currentRoadObject",nil],
	["endPos",[]],
	["startPos",[]],
	["GetEstimatedDistance",compileFinal {
		params ["_currentPos","_endPos"];
		_currentPos distance _endPos;
	}],
	["GetNeighbors",compileFinal {
		params ["_currentPos"];
		private _road = roadAt _currentPos;
		private _neighbors = roadsConnectedTo _road;
		private _result = [];
		{_result pushback (getpos _x);} foreach _neighbors;
		_result;
	}],
	["GetMoveCost",compileFinal {
		params ["_currentPos","_nextPos"];
		_currentPos distance _nextPos;
	}],
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
	/*----------------------------------------------------------------------------
	Protected: myProp
    
    	--- Prototype --- 
    	get "myProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: MyProp
    
    	--- Prototype --- 
    	get "MyProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_typ_Name",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: MyMethod
    
    	--- Prototype --- 
    	call ["MyMethod",[_object*,_var1*]]
    	---
    
    Optionals: 
		_object* - <Object> - (Optional - Default : objNull) 
		_var1* - <String> - (Optional - Default : "") 
	-----------------------------------------------------------------------------*/