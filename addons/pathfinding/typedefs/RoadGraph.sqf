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
	["addRoadToGraph",{
		params [["_object",objNull,[objNull]],["_typeDef",XPS_PF_typ_RoadNode,[[]]]];
		if !(_object isEqualto objNull) then {
			private _hmo = createhashmapobject [_typeDef,[str _object,_object]];
			_self get "Items" set [str _object,_hmo];
		};
	}],
	/*----------------------------------------------------------------------------
	Proteccted: getConnected
    
    	--- Prototype --- 
    	call ["getConnected",[_node]]
    	---
    
    	Sets ConnectedTo property with custom algorithm (as opposed to simply "roadsConnectedTo" command)

	Parameters:
		_node - <HashmapObject> - the node to check
	-----------------------------------------------------------------------------*/
	["getConnected",{
		params [["_node",nil,[createhashmap]]];
		private _object = _node get "RoadObject";
		private _ct = _node get "ConnectedTo";
		{
			private _type = (getroadinfo _x)#0;
			private _ct1 = _ct get _type;
			if !(_x isEqualto objNull || (str _x) == (str _object) || (str _x in (keys _ct1))) then {
				_ct1 set [str _x,_x];
				_self get "Items" get (str _x) get "ConnectedTo" get _type set [str _object,_object];
			};
		} foreach roadsconnectedto _object;
		private _pos = _node get "PosASL";
		private _bPos = _node get "BeginPos";
		private _ePos = _node get "EndPos";
		private _width = (_node get "Width")/3;
		private _bPosC = _pos getpos [(_pos distance _bPos)+0.75,(_pos getDir _bPos)]; 
		private _bPosL = _bPosC getpos [_width,(_pos getDir _bPosC)-90]; 
		private _bPosR = _bPosC getpos [_width,(_pos getDir _bPosC)+90]; 
		private _ePosC = _pos getpos [(_pos distance _ePos)+0.75,(_pos getDir _ePos)]; 
		private _ePosL = _ePosC getpos [_width,(_pos getDir _ePosC)-90]; 
		private _ePosR = _ePosC getpos [_width,(_pos getDir _ePosC)+90]; 
		{
			private _r = roadAt _x;
			private _type = (getroadinfo _r)#0;
			private _ct1 = _ct get _type;
			if !(_r isEqualto objNull || (str _r) == (str _object) || (str _r in (keys _ct1))) then {
				_ct1 set [str _r,_r];
				_self get "Items" get (str _r) get "ConnectedTo" get _type set [str _object,_object];
			};
		} foreach [_bposC,_bPosL,_bPosR,_eposC,_ePosL,_ePosR];
		
		_m = createmarker [str _bPosC,_bPosC]; 
		_m setmarkershape "rectangle"; 
		_m setmarkercolor "ColorBlue"; 
		_m setmarkersize [_width,0.2]; 
		_m setmarkerdir (_pos getdir _bPosC); 
		_m = createmarker [str _ePosC,_ePosC]; 
		_m setmarkershape "rectangle"; 
		_m setmarkercolor "ColorBlack"; 
		_m setmarkersize [_width,0.2]; 
		_m setmarkerdir (_pos getdir _ePosC);  
	}],
	["buildGraph",{
		private _roads = nearestterrainobjects [[worldsize/2,worldsize/2],["MAIN ROAD","ROAD","TRACK","TRAIL"],worldSize,false,false];
		_self set ["Items",createhashmap];
		{_self call ["addRoadToGraph",[_x]];} foreach _roads;
		{_self call ["getConnected",[_x]];} foreach values (_self get "Items");
		
		{
			_hm = _x;
			_color = "ColorBlack"; 
			private _rct = [];
			{_rct append values (_hm get "ConnectedTo" get _x);}foreach ["MAIN ROAD","ROAD","TRACK","TRAIL"];
			if (count _rct < 2) then {_color = "ColorBlue"}; 
			if (_hm get "IsBridge") then {_color = "ColorWhite"}; 
			if (_hm get "Type" == "TRAIL") then {_color = "ColorOrange"};
			if (count _rct < 1) then {_color = "ColorRed"}; 
			if (count _rct > 2) then {_color = "ColorGreen"};  
			_m = createmarker [_hm get "Index",_hm get "RoadObject"]; 
			_m setmarkertype "hd_dot"; 
			_m setmarkercolor _color; 
			_m setmarkersize [0.4,0.4];  
		} foreach values (_self get "Items");
	}],
	["#create",compileFinal {
		params [["_roadGraphDoctrine",createhashmapobject [XPS_PF_typ_RoadGraphDoctrine],[createhashmap]]];
		_self set ["RoadGraphDoctrine",_roadGraphDoctrine];
		_self call ["buildGraph"];
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
	["Items",nil],
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
		private _result = [];
		private _neighbors = [];
		{_neighbors append (values (_current get "ConnectedTo" get _x));} foreach (_self get "RoadGraphDoctrine" get "RoadTypes");
		private _prevRoadObject = if (isNil "_prev") then {objNull} else {_prev get "RoadObject"};
		
		{
			if !(_x isEqualTo _prevRoadObject || _x isEqualTo (_current get "RoadObject")) then {
				_result pushback (_self get "Items" get str _x);
			};
		} foreach _neighbors;
		

		//Debug Markers
		if (count _result == 0) then {
			private _m = createmarker [str str(_current get "Index"),_current get "RoadObject"];
			_m setmarkercolor "ColorRed";
			_m setmarkertype "hd_dot";
			_m setMarkerSize [0.5,0.5];
		} else {
			private _m = createmarker [str str(_current get "Index"),_current get "RoadObject"];
			_m setmarkercolor "ColorGrey";
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
		// private _dir = _current get "Direction";
		// if !(isNil "_dir") then {
		// 	private _dirH = (_current get "RoadObject") getdir (_next get "RoadObject");
		// 	private _angle = abs(_dir - _dirH);
		// 	if (_angle >= 90) then {
		// 		_angle = abs(_angle - 180);
		// 	};
		// 	_cost = (_cost * sin(_angle) ) + (_cost * cos(_angle));
		// };
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
		_self get "Items" get (str (_roads#0));
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