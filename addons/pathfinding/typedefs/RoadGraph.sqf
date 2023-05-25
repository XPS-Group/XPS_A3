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
	["#str",compileFinal {"XPS_PF_typ_RoadGraph"}],
	["#interfaces",["XPS_ifc_IAstarGraph"]],
	["_getConnectedToData",{
		if !(params [["_from",nil,[createhashmap]],["_to",nil,[createhashmap]],["_fromWidth",nil,[0]],["_toWidth",nil,[0]]]) exitwith {diag_log ["_getConnectedToPathData",_from,_to]};
		
		private _rhPath = [];
		private _lhPath = [];

		private _posA = _from get "PosASL";
		private _bPosA = _from get "BeginPos";
		private _ePosA = _from get "EndPos";

		private _posB = _to get "PosASL";
		private _bPosB = _to get "BeginPos";
		private _ePosB = _to get "EndPos";

		private _closest = [[0,0,0],[0,0,0]];
		private _distance = 9999;
		{
			private _dist = (_x#0) distance2D (_x#1);
			if (_dist < _distance) then {
				_distance = _dist;
				_closest = _x;
			};
		} foreach [[_bPosA,_bPosB],[_bPosA,_ePosB],[_ePosA,_bPosB],[_ePosA,_ePosB]];

		private _headA = _posA getdir (_closest#0);
		private _rhS = _posA getpos [_fromWidth , _headA + 90];_rhS set [2,_posA#2];
		private _lhS = _posA getpos [_fromWidth , _headA - 90];_lhS set [2,_posA#2];
		private _rhMS = (_closest#0) getpos [_fromWidth,_headA + 90];_rhMS set [2,_closest#0#2];
		private _lhMS = (_closest#0) getpos [_fromWidth,_headA - 90];_lhMS set [2,_closest#0#2];
		
		private _headB = _posB getdir (_closest#1);
		private _rhE = _posB getpos [_toWidth,_headB-90];_rhE set [2,_posB#2];
		private _lhE = _posB getpos [_toWidth,_headB+90];_lhE set [2,_posB#2];
		private _rhME = (_closest#1) getpos [_toWidth,_headB-90];_rhME set [2,_closest#1#2];
		private _lhME = (_closest#1) getpos [_toWidth,_headB+90];_lhME set [2,_closest#1#2];

		private _rhI = [_rhS,_rhMS,_rhME,_rhE] call XPS_PF_fnc_lineIntersect2D;
		private _lhI = [_lhS,_lhMS,_lhME,_lhE] call XPS_PF_fnc_lineIntersect2D;

		_rhPath pushback _rhS;
		_lhPath pushback _lhS;
		if !(count _rhI == 0) then {_rhI set [2,_posB#2];_rhPath pushback _rhI;};
		if !(count _lhI == 0) then {_lhI set [2,_posB#2];_lhPath pushback _lhI;};
		_rhPath pushback _rhE;
		_lhPath pushback _lhE;

		[_rhPath,_lhPath];
	}],
	/*----------------------------------------------------------------------------
	Proteccted: addRoadToGraph
    
    	--- Prototype --- 
    	call ["addRoadToGraph",[_object,_typeDef*]]
    	---
    
	Parameters:
		_object - <Object> - a Road object

	Optionals: 
		_typeDef - <TypeDefinition> - (Optional - Default : XPS_PF_typ_RoaddNode)
	-----------------------------------------------------------------------------*/
	["addRoadToGraph",compileFinal {
		params [["_object",objNull,[objNull]],["_typeDef",XPS_PF_typ_RoadNode,[[]]]];
		if !(_object isEqualto objNull) then {
			private _hmo = createhashmapobject [_typeDef,[str _object,_object]];
			_self get "Items" set [str _object,_hmo];
		};
	}],
	/*----------------------------------------------------------------------------
	Proteccted: setConnectedToPathData
    
    	--- Prototype --- 
    	call ["setConnectedToPathData",[_from,_to]]
    	---
    
	Parameters:
		_from - <XPS_PF_typ_RoadNode> - the node coming from
		_to - <XPS_PF_typ_RoadNode> - the node going to
	-----------------------------------------------------------------------------*/
	["setConnectedToPathData",compileFinal {
		if !(params [["_from",nil,[createhashmap]],["_to",nil,[createhashmap]]]) exitwith {diag_log ["setConnectedToPathData",_from,_to]};
		
		//Get Driving Data
		private _fromWidth = (_from get "Width")/5.5; if (_widthA == 0) then {_widthA=1.8;};
		private _toWidth = (_to get "Width")/5.5; if (_widthB == 0) then {_widthB=1.8;};

		_result = _self call ["_getConnectedToData",[_from,_to,_fromWidth,_toWidth]];
		private _rhPath = _result#0;
		private _lhPath = _result#1;

		_from get "ConnectedToPath" get "RHDrive" set [_to get "Index",_rhPath];
		_from get "ConnectedToPath" get "LHDrive" set [_to get "Index",_lhPath];
		private _revLHPath = +_lhPath;
		private _revRHPath = +_rhPath;
		reverse _revLHPath;
		reverse _revRHPath;
		_to get "ConnectedToPath" get "RHDrive" set [_from get "Index",_revLHPath];
		_to get "ConnectedToPath" get "LHDrive" set [_from get "Index",_revRHPath];
		
		//Get Walking Data
		_fromWidth = if (_from get "Type" == "TRAIL") then {0.5} else {(_from get "Width")/2.5};
		_toWidth = if (_to get "Type" == "TRAIL") then {0.5} else {(_to get "Width")/2.5};

		_result = _self call ["_getConnectedToData",[_from,_to,_fromWidth,_toWidth]];
		private _rhPath = _result#0;
		private _lhPath = _result#1;

		_from get "ConnectedToPath" get "RHWalk" set [_to get "Index",_rhPath];
		_from get "ConnectedToPath" get "LHWalk" set [_to get "Index",_lhPath];
		private _revLHPath = +_lhPath;
		private _revRHPath = +_rhPath;
		reverse _revLHPath;
		reverse _revRHPath;
		_to get "ConnectedToPath" get "RHWalk" set [_from get "Index",_revLHPath];
		_to get "ConnectedToPath" get "LHWalk" set [_from get "Index",_revRHPath];
	}],
	/*----------------------------------------------------------------------------
	Proteccted: getAllConnected
    
    	--- Prototype --- 
    	call ["getAllConnected",[_node]]
    	---
    
    	Sets ConnectedTo property with custom algorithm (as opposed to simply "roadsConnectedTo" command)

	Parameters:
		_node - <HashmapObject> - the node to check
	-----------------------------------------------------------------------------*/
	["getAllConnected",compileFinal {
		params [["_node",nil,[createhashmap]]];
		private _object = _node get "RoadObject";
		private _ct = _node get "ConnectedTo";
		private _roadArray = [];
		{
			private _type = (getroadinfo _x)#0;
			private _ct1 = _ct get _type;
			if !(_x isEqualto objNull || (str _x) == (str _object) || (str _x) in keys _ct1) then {
				_roadArray pushbackunique _x;
			};
		} foreach roadsconnectedto _object;

		private _pos = _node get "PosASL";
		private _bPos = _node get "BeginPos";
		private _ePos = _node get "EndPos";
		private _width = (_node get "Width")/3;
		if (_width == 0) then {_width = 5.5};
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
			if !(_r isEqualto objNull || (str _r) == (str _object) || (str _r) in keys _ct1) then {
				_roadArray pushbackunique _r;
			};
			_x resize 2;
		} foreach [_bposC,_bPosL,_bPosR,_eposC,_ePosL,_ePosR,_bposC,_bPosL,_bPosR,_eposC,_ePosL,_ePosR];

		{
			private _type = (getroadinfo _x)#0;
			private _ct1 = _ct get _type;
			_ct1 set [str _x,_x];
			private _rct = _self get "Items" get (str _x);
			_rct get "ConnectedTo" get _type set [str _object,_object];

			_self call ["setConnectedToPathData",[_node, _rct]];
		} foreach _roadArray;
		
		_m = createmarker [str _bPosC,_bPosC]; 
		_m setmarkershape "rectangle"; 
		_m setmarkercolor "ColorBlue"; 
		_m setmarkersize [_width,0.1]; 
		_m setmarkerdir (_pos getdir _bPosC); 
		_m = createmarker [str _ePosC,_ePosC]; 
		_m setmarkershape "rectangle"; 
		_m setmarkercolor "ColorBlack"; 
		_m setmarkersize [_width,0.1]; 
		_m setmarkerdir (_pos getdir _ePosC);  
	}],
	/*----------------------------------------------------------------------------
	Proteccted: buildGraph
    
    	--- Prototype --- 
    	call ["buildGraph"]
    	---
    
    Gets all Road Objects in World and builds a working graph for searching
	-----------------------------------------------------------------------------*/
	["buildGraph",compileFinal {
		private _roads = nearestterrainobjects [[worldsize/2,worldsize/2],["MAIN ROAD","ROAD","TRACK","TRAIL"],worldSize,false,false];
		_self set ["Items",createhashmap];
		{_self call ["addRoadToGraph",[_x]];} foreach _roads;
		{_self call ["getAllConnected",[_x]];} foreach values (_self get "Items");
		
	}],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createhashmapobject [XPS_PF_typ_RoadGraph,[_roadGraphDoctrine*]];
    	---

	Parameters:
		_roadGraphDoctrine* - <RoadGraphDoctrine> - (Optional - Default : default 
		<RoadGraphDoctrine>) - A <HashmapObject> which injects heuristics
		and other properties for pathfinding 

	Returns:
		_result - <HashmapObject> 
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_roadGraphDoctrine",createhashmapobject [XPS_PF_typ_RoadGraphDoctrine],[createhashmap]]];
		_self set ["RoadGraphDoctrine",_roadGraphDoctrine];
		_self set ["_graphMarkersEnabled",false];
		_self set ["_graphMarkers",[]];
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
	/*----------------------------------------------------------------------------
	Property: Items
    
    	--- Prototype --- 
    	get "Items"
    	---
    
    Returns: 
		<Hashmap> - All <XPS_PF_typ_RoadNodes> represented in a searchable graph
	-----------------------------------------------------------------------------*/
	["Items",nil],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---
		<main.XPS_ifc_IAstarGraph.Init>
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

		<main.XPS_ifc_IAstarGraph.GetEstimatedDistance>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_endPos - <Array> - goal position
	-----------------------------------------------------------------------------*/
	["GetEstimatedDistance",compileFinal {
		params ["_current","_end"];
		(_current get "RoadObject") distance2D (_end get "RoadObject");
	}],
	/*----------------------------------------------------------------------------
	Method: GetNeighbors
    
    	--- Prototype --- 
    	call ["GetNeighbors",[_currentPos,_endPos]]
    	---

		<main.XPS_ifc_IAstarGraph.GetNeighbors>
    
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
		// if (count _result == 0) then {
		// 	private _m = createmarker [str str(_current get "Index"),_current get "RoadObject"];
		// 	_m setmarkercolor "ColorRed";
		// 	_m setmarkertype "hd_dot";
		// 	_m setMarkerSize [0.5,0.5];
		// } else {
		// 	private _m = createmarker [str str(_current get "Index"),_current get "RoadObject"];
		// 	_m setmarkercolor "ColorGrey";
		// 	_m setmarkertype "hd_dot";
		// 	_m setMarkerSize [0.3,0.3];
		// };

		_result;
	}],
	/*----------------------------------------------------------------------------
	Method: GetMoveCost
    
    	--- Prototype --- 
    	call ["GetMoveCost",[_currentPos,_nextPos]]
    	---

		<main.XPS_ifc_IAstarGraph.GetMoveCost>
    
    Optionals: 
		_currentPos - <Array> - current position of working graph 
		_nextPos - <Array> - connected road location
	-----------------------------------------------------------------------------*/
	["GetMoveCost",compileFinal {
		params ["_current","_next"];
		private _pathPoints = _current get "ConnectedToPath" get (_self get "RoadGraphDoctrine" get "Drive") get (_next get "Index");
		if (isNil "_pathpoints") exitwith {diag_log ["RoadGraph:GetMoveCost:_pathpoints is nil from/to:",_current get "Index",_next get "Index"];99999;};
		private _cost = 0;
		for "_i" from 1 to (count _pathPoints)-1 do {_cost = _cost + (_pathPoints#(_i-1) distance2D _pathPoints#_i)};
		_cost = _cost * (_self call ["heuristic",[_next]]);
		_cost;
	}],
	/*----------------------------------------------------------------------------
	Method: GetNodeAt
    
    	--- Prototype --- 
    	call ["GetNodeAt",[_pos]]
    	---

		<main.XPS_ifc_IAstarGraph.GetNodeAt>
    
    Optionals: 
		_pos - <Array> - current position to look for nearest road object (within 50m)
	-----------------------------------------------------------------------------*/
	["GetNodeAt",compileFinal {
		if !(params [["_pos",nil,[[]],[2,3]]]) exitwith {nil};
		private _roads = nearestTerrainObjects [_pos,_self get "RoadGraphDoctrine" get "RoadTypes",50,true];
		_self get "Items" get (str (_roads#0));
	}],
	/*----------------------------------------------------------------------------
	Method: ToggleGraphMarkers
    
    	--- Prototype --- 
    	call ["ToggleGraphMarkers"]
    	---
    
    Toggles markers on/off on the map for each road segment.

	Color Index

		- Black : General Road segment with only 2 connecting roads
		- Orange : TRAIL road segment with only 2 connecting roads
		- White : BRIDGE segment with only 2 connecting roads 
		- Green : A segment with more than 2 connecting roads (junction)
		- Blue : A segment with 1 connecting road (end point)
		- Red : A segment with no other connecting roads (possible error)
	-----------------------------------------------------------------------------*/
	["ToggleGraphMarkers",compileFinal {
		private _enabled = _self get "_graphMarkersEnabled";
		private _markers = _self get "_graphMarkers";

		switch (_enabled) do {
			case false: {
				{
					private _hm = _x;
					//Get which color it should be
					private _color = "ColorBlack"; 
					private _rct = [];
					{_rct append values (_hm get "ConnectedTo" get _x);}foreach ["MAIN ROAD","ROAD","TRACK","TRAIL"];
					if (count _rct < 2) then {_color = "ColorBlue"}; 
					if (_hm get "IsBridge") then {_color = "ColorWhite"}; 
					if (_hm get "Type" == "TRAIL") then {_color = "ColorOrange"};
					if (count _rct < 1) then {_color = "ColorRed"}; 
					if (count _rct > 2) then {_color = "ColorGreen"};  

					//Create the marker
					_m = createmarker [_hm get "Index",_hm get "RoadObject"]; 
					_m setmarkertype "hd_dot"; 
					_m setmarkercolor _color; 
					_m setmarkersize [0.4,0.4];  
					_markers pushback (_hm get "Index");
				} foreach values (_self get "Items");
			};
			default {
				{deleteMarker _x} foreach _markers;
				_markers resize 0;
			};
		};
		_self set ["_graphMarkersEnabled",!_enabled];
	}],
	/*----------------------------------------------------------------------------
	Method: SmoothPath
    
    	--- Prototype --- 
    	call ["SmoothPath",[_path]]
    	---
    
    Smooths a given path by removing any nodes that may be unnecessary

	Parameters:
		_path - <Array> - An array of <RoadNodes> that represent a path
	-----------------------------------------------------------------------------*/
	["SmoothPath",{
		params [["_path",[],[[]]]];

		if (count _path < 3) exitwith {};

		private _i = 1;
		while {_i < (count _path)-1} do {

			private _first = _path#(_i-1);
			private _second = _path#(_i);
			private _third = _path#(_i+1);

			// Else check if C is actually closer than B
			private _posA = _first get "PosASL";
			private _posB = _second get "PosASL";
			private _posC = _third get "PosASL";
			private _checkPositions = [_third get "BeginPos",_third get "EndPos"];
			
			if ((_posA distance2D (_checkPositions#0)) < (_posA distance2D _posB) || (_posA distance2D (_checkPositions#1)) < (_posA distance2D _posB)) then {
				_path deleteAt _i;
			} else {
				_i = _i + 1;
			};
		};
	}]
]