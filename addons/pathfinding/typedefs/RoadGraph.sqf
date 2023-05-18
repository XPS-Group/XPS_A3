#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_RoadGraph
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Navigates a road path using <main.XPS_typ_AstarSearch> from a starting location to an
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

	["#create",compileFinal {
		params [["_roadGraphDoctrine",createhashmapobject [XPS_PF_typ_RoadGraphDoctrine],[createhashmap]]];
		_self set ["RoadGraphDoctrine",_roadGraphDoctrine];
	}],
	/*----------------------------------------------------------------------------
	Protected: heuristic
    
    	--- Prototype --- 
    	call ["heuristic",[_next]]
    	---

		Gets the heuristic value for "move cost" based on road type.
    
    Optionals: 
		_next - <Hashmap> - road "node"
	-----------------------------------------------------------------------------*/
	["heuristic",compileFinal {
		params ["_next"];
		private _doctrineHeurs = _self get "RoadGraphDoctrine" get "Heuristics";
		private _road = _next get "RoadObject";
		private _info = getRoadInfo _road;
		private _result = _doctrineHeurs#2;
		switch (_info#0) do {
			case "MAIN ROAD" : {_result = _doctrineHeurs#0};
			case "ROAD" : {_result = _doctrineHeurs#1};
			// case "TRACK" : {_result = 1.20};
			// default {_result = 1.20};
		};
		_result;
	}],
	/*----------------------------------------------------------------------------
	Property: RoadGraphDoctrine
    
    	--- Prototype --- 
    	get "RoadGraphDoctrine"
    	---
    
    Returns: 
		<Hashmapobject> - (Default: default XPS_PF_typ_RoadGraphDoctrine) 
	-----------------------------------------------------------------------------*/
	["RoadGraphDoctrine",nil],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---

		Used to reset any working values if needed. Unused in this instance.

	Returns:
		<Nothing>
	-----------------------------------------------------------------------------*/
	["Init",compileFinal {}],
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
		if (isNil "_current") exitwith {nil};
		private _road = _current get "RoadObject";
		private _neighbors = roadsConnectedTo (_road);
		private _includeUnconnectedNeighbors = nearestTerrainObjects [_road,_self get "RoadGraphDoctrine" get "RoadTypes",25,true,true];
		_neighbors insert [-1,_includeUnconnectedNeighbors,true]; //Unique Only
		private _result = [];
		private _prevRoadObject = if (isNil "_prev") then {objNull} else {_prev get "RoadObject"};
		
		{
			if !(_x isEqualTo _prevRoadObject || _x isEqualTo (_current get "RoadObject")) then {
				_result pushback (createhashmapfromarray [
					["Index",str _x],
					["RoadObject",_x],
					["Direction",(_road getDir _x)]
				]);
			};
		} foreach _neighbors;
		

		//Debug Markers
		if (count _result == 0) then {
			private _m = createmarker [_current get "Index",getpos (_current get "RoadObject")];
			_m setmarkercolor "ColorRed";
			_m setmarkertype "hd_dot";
			_m setMarkerSize [0.5,0.5];
		} else {
			private _m = createmarker [_current get "Index",getpos (_current get "RoadObject")];
			_m setmarkercolor "ColorGreen";
			_m setmarkertype "hd_dot";
			_m setMarkerSize [0.3,0.3];
		};

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
		private _cost = (_current get "RoadObject") distance (_next get "RoadObject");
		private _dir = _current get "Direction";
		if !(isNil "_dir") then {
			private _dist = (_current get "RoadObject") distance (_next get "RoadObject");
			private _dirH = (_current get "RoadObject") getdir (_next get "RoadObject");
			private _angle = abs(_dir - _dirH);
			if (_angle >= 90) then {
				_angle = abs(_angle - 180);
			};
			_cost = (_cost * sin(_angle) ) + (_cost * cos(_angle));
		};
		_cost = _cost * (_self call ["heuristic",[_next]]);
		_cost;
	}],
	/*----------------------------------------------------------------------------
	Method: GetNodeAt
    
    	--- Prototype --- 
    	call ["GetNodeAt",[_pos]]
    	---

		<main.XPS_ifc_IAstarGraph>
    
    Optionals: 
		_pos - <Array> - current position to look for nearest road object (within 50m)
	-----------------------------------------------------------------------------*/
	["GetNodeAt",{
		params [["_pos",[0,0,0],[[]],[2,3]]];
		private _roads = nearestTerrainObjects [_pos,_self get "RoadGraphDoctrine" get "RoadTypes",50,true];
		createhashmapfromarray [["Index",str (_roads#0)],["RoadObject",(_roads#0)]];
	}],
	//TODO - Notnecessary anymore?
	["SmoothPath",{
		params [["_roadObjectArray",[],[[]]]];
		private _finalPath = [];
		if (count _roadObjectArray > 1) then {
			for "_i" from 1 to (count _roadObjectArray)-1 do {
				private _roadInfoA = getRoadInfo (_roadObjectArray#(_i-1));;
				private _roadInfoB = getRoadInfo (_roadObjectArray#(_i));
				private _a0 = _roadInfoA#6;
				private _a1 = _roadInfoA#7;
				private _b0 = _roadInfoA#6;
				private _b1 = _roadInfoA#7;
				private _lowest = [_a0 distance _b0,_b0];
				if ((_a0 distance _b1) < (_lowest#0)) then {_lowest = [_a0 distance _b1,_b1]};
				if ((_a1 distance _b0) < (_lowest#0)) then {_lowest = [_a1 distance _b0,_b0]};
				if ((_a1 distance _b1) < (_lowest#0)) then {_lowest = [_a1 distance _b1,_b1]};

				private _m = createmarker [str str str (_lowest#1),_lowest#1];
				_m setmarkercolor "ColorWhite";
				_m setmarkertype "mil_circle";
				_m setMarkerSize [0.2,0.2];

				_finalPath pushback _lowest#1;
			};
		} else {if (count _roadObjectArray == 1) then {_finalPath pushback getpos (_roadObjectArray#0)};};
		_finalPath;
	}]
]