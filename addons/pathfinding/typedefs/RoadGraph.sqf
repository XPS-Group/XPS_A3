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

	<XPS_PF_ifc_IRoadGraph>
	
	<main.XPS_ifc_IAstarGraph>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_PF_typ_RoadGraph"}],
	["#type","XPS_PF_typ_RoadGraph"],
	["@interfaces",["XPS_PF_ifc_IRoadGraph","XPS_ifc_IAstarGraph"]],
	["_getConnectedToPath",compilefinal {
		if !(params [["_fromPoint",nil,[[]],[3]],["_direction",nil,[0]],["_toObject",nil,[createhashmap]],["_toWidth",nil,[0]],["_nextObject",nil,[createhashmap]],["_nextWidth",nil,[0]],["_dirOffset",nil,[0]]]) exitwith {diag_log ["_getConnectedToPath:",_fromPoint,_toObject,_toWidth,_nextObject,_dirOffset]};
		if (_fromPoint isEqualTo [0,0,0]) then {diag_log ["_getConnectedToPath:",_fromPoint,_toObject,_toWidth,_nextObject,_dirOffset]};

		private _posA = _toObject get "PosASL";
		private _bPosA = _toObject get "BeginPos";
		private _ePosA = _toObject get "EndPos";

		private _posB = _nextObject get "PosASL";
		private _bPosB = _nextObject get "BeginPos";
		private _ePosB = _nextObject get "EndPos";

		private _int = [_bPosA,_ePosA,_bPosB,_ePosB] call XPS_PF_fnc_lineIntersect2d;
		private _dirA = 0;
		private _dirB = 0;

		if (isNil "_int" || count _int isEqualTo 0) then {
			_dirA = _posA getdir _posB;
			_dirB = _posA getdir _posB;
		} else {
			_dirA = _posA getdir _int;
			_dirB = _int getdir _posB;
		}; 

		private _headA = _bposA getdir _eposA;
		private _headB = _bposB getdir _eposB;
		private _posS = _posA;
		private _posE = _eposB ;

		if (abs (_headA - _dirA) > 90) then {_headA = _eposA getdir _bposA;}; 
		if (abs (_headB - _dirB) > 90) then {_headB = _eposB getdir _bposB;_posE = _bPosB;}; 

		private _posS = _posS getpos [_toWidth,_headA + _dirOffset]; _posS set [2,_posA#2];
		private _posE = _posE getpos [_nextWidth,_headB + _dirOffset]; _posE set [2,_posB#2];

		private _points = [];
		if ((_posS distance2d _posE)*1.15 < (_fromPoint distance2d _posE)) then {_points pushback _posS;_fromPoint = _posS;};
		private _p1 = _frompoint;
		private _p2 = _frompoint getpos [5,_direction];
		private _p3 = _bPosB getpos [_nextWidth,_headB + _dirOffset];
		private _p4 = _ePosB getpos [_nextWidth,_headB + _dirOffset];
		
		_m = createmarker ["db"+ str _fromPoint,_fromPoint]; 
		_m setmarkertype "mil_circle"; 
		_m setmarkercolor "ColorOrange"; 
		_m setmarkersize [0.25,0.25]; 
		_m = createmarker ["db"+ str str _posE,_posE]; 
		_m setmarkertype "mil_circle"; 
		_m setmarkercolor "ColorBlack"; 
		_m setmarkersize [0.25,0.25]; 


		private _intersect = [_p1,_p2,_p3,_p4] call XPS_PF_fnc_lineIntersect2D;
		private _intPoints = [];
		if !(isNil "_intersect" || count _intersect isEqualTo 0) then {
			if ((_intersect distance2d _posE < _fromPoint distance2d _posE) && (_intersect distance2d _fromPoint < _fromPoint distance2d _posE)) then {
				private _iB = _intersect getpos [(_intersect distance _frompoint)/2,_intersect getdir _frompoint]; 
				private _iE = _intersect getpos [(_intersect distance _posE)/2,_intersect getdir _posE]; 
				_intPoints pushback _iB;
				_intPoints pushback _intersect;
				_intPoints pushback _iE;
				for "_p" from 0.1 to 0.5 step 0.1 do {
					private _nPos = _p bezierInterpolation _intPoints;
					//if !(roadAt _nPos isEqualTo (_toObject get "RoadObject")) then {
						_points pushback _nPos;
					//};
				};
				_m = createmarker ["db"+ str _intersect,_intersect]; 
				_m setmarkertype "mil_circle"; 
				_m setmarkercolor "ColorYellow"; 
				_m setmarkersize [0.25,0.25]; 
			};
		};
		_points;
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
			_self get "Roads" set [str _object,_hmo];
		};
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
			if !(_x isEqualto objNull || (str _x) isEqualTo (str _object) || (str _x) in keys _ct) then {
				_roadArray pushbackunique _x;
			};
		} foreach roadsconnectedto _object;

		private _pos = _node get "PosASL";
		private _bPos = _node get "BeginPos";
		private _ePos = _node get "EndPos";
		private _width = (_node get "Width")/2;
		if (_width isEqualTo 0) then {_width = 5.5};
		private _bPosC = _pos getpos [(_pos distance _bPos)+0.02,(_pos getDir _bPos)];
		private _bPosL = _bPosC getpos [_width,(_pos getDir _bPosC)-90];
		private _bPosR = _bPosC getpos [_width,(_pos getDir _bPosC)+90];
		private _ePosC = _pos getpos [(_pos distance _ePos)+0.02,(_pos getDir _ePos)];
		private _ePosL = _ePosC getpos [_width,(_pos getDir _ePosC)-90];
		private _ePosR = _ePosC getpos [_width,(_pos getDir _ePosC)+90];
		{
			_x resize 2;
			private _r = roadAt _x;
			if !(_r isEqualto objNull || (str _r) isEqualTo (str _object) || (str _r) in keys _ct || abs((getposASL _r)#2)-(_pos#2)>2) then {
				_roadArray pushbackunique _r;
			};
		} foreach [_bposC,_bPosL,_bPosR,_eposC,_ePosL,_ePosR];

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

		{
			_ct set [str _x,_x];
			private _rct = _self get "Roads" get (str _x);
			_rct get "ConnectedTo" set [str _object,_object];

		} foreach _roadArray;
		
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
		_self set ["Roads",createhashmap];
		{_self call ["addRoadToGraph",[_x]];} foreach _roads;
		{_self call ["getAllConnected",[_x]];} foreach values (_self get "Roads");
		
	}],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createhashmapobject [XPS_PF_typ_RoadGraph,[_roadGraphDoctrine*]];
    	---

	Parameters:
		_roadGraphDoctrine* - <XPS_PF_typ_RoadGraphDoctrine> - (Optional - Default : default <XPS_PF_typ_RoadGraphDoctrine>) - A <HashmapObject> which injects heuristics and other properties for pathfinding 

	Returns:
		_result - <HashmapObject> 
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		_self set ["_graphMarkersEnabled",false];
		_self set ["_graphMarkers",[]];
		_self call ["buildGraph"];
	}],
	/*----------------------------------------------------------------------------
	Property: Roads
    
    	--- Prototype --- 
    	get "Roads"
    	---
    
    Returns: 
		<Hashmap> - All <XPS_PF_typ_RoadNodes> represented in a searchable graph
	-----------------------------------------------------------------------------*/
	["Roads",createhashmap],
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
		if !(params [["_current",nil,[createhashmap]],"_prev"]) exitwith {nil};
		
		private _result = [];
		private _neighbors = [];
		private _road = _current get "RoadObject";
		_neighbors append (values (_current get "ConnectedTo"));
		private _prevRoadObject = if (isNil "_prev") then {objNull} else {_prev get "RoadObject"};
		
		{
			if !(_x isEqualTo _prevRoadObject || _x isEqualTo (_current get "RoadObject")) then {
				_result pushback (_self get "Roads" get str _x);
			};
		} foreach _neighbors;
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
		if !(params [["_current",nil,[createhashmap]],["_next",nil,[createhashmap]]]) exitwith {nil};
		
		(_current get "PosASL") distance (_next get "PosASL");
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
		private _roads = nearestTerrainObjects [_pos,["MAIN ROAD","ROAD","TRACK","TRAIL"],50,true];
		if (count _roads > 0) exitwith {
			_self get "Roads" get (str (_roads#0));
		};
		nil;
	}],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---
		<main.XPS_ifc_IAstarGraph.Init>
	Used to reset any working values if needed. Unused in this instance.

	Returns:
		Nothing
	-----------------------------------------------------------------------------*/
	["Init",{}],
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
					_rct append values (_hm get "ConnectedTo");
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
				} foreach values (_self get "Roads");
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
	["SmoothPath", compileFinal {
		params [["_path",[],[[]]]];

		if (count _path > 3) then {
			private _i = 1;
			while {_i < (count _path)-1} do {

				private _first = _path#(_i-1);
				private _second = _path#(_i);
				private _third = _path#(_i+1);

				private _posA = _first get "PosASL";
				private _posB = _second get "PosASL";
				private _posC = _third get "PosASL";
				private _checkPositions = [_third get "BeginPos",_third get "EndPos"];
				
				// Check if C is actually closer than B and delete if so
				if ((_posA distance2D (_checkPositions#0)) < (_posA distance2D _posB) || (_posA distance2D (_checkPositions#1)) < (_posA distance2D _posB)) then {
					_path deleteAt _i;
				} else {
					_i = _i + 1;
				};
			};		
		};
	}],
	//TODO : Move this to Formation AI because it can only work in that situation
	["CalculateDrivePath", compileFinal {
		params [["_start",nil,[[]],[2,3]],["_end",nil,[[]],[2,3]],["_path",[],[[]]],["_side","",[""]]];

		if (isNil "_start") then {_start = (_path deleteAt 0) get "PosASL"};
		if (isNil "_end") then {_end = (_path deleteAt (count _path -1)) get "PosASL"};
		if !(_side in ["RHDrive","LHDrive","RHWalk","LHWalk"]) then {_side = "RHDrive"};

		_self call ["SmoothPath",[_path]];

		private _mP = _start;
		{
			_m = createmarker [str str str str str (_x get "PosASL"),_x get "PosASL"];
			_m setmarkertype "mil_arrow";
			_m setmarkercolor "ColorRed";
			_m setmarkersize [0.5,0.5];
			_m setmarkerdir (_mP getdir (getmarkerpos _m));
			_mP = getmarkerpos _m;
		} foreach _path;

		//CALCULATE PATH
		private _fromPoint = +_start;
		private _direction = _fromPoint getdir ((_path#0) get "PosASL");
		private _result = [_fromPoint];
		_i = 0;
		while {_i < (count _path)-1} do {

			private _toObject = _path#(_i);
			private _nextObject = _path#(_i+1);
			private _dirOffset = 0;
			private _divisor = [];

			switch (_side) do {
				case "LHDrive" : {_dirOffset = -90; _divisor = [5.5,1.8];};
				case "RHDrive" : {_dirOffset = 90; _divisor = [5.5,1.8];};
				case "LHWalk" : {_dirOffset = -90; _divisor = [2.5,4];};
				case "RHWalk" : {_dirOffset = 90; _divisor = [2.5,4];};
			};

			private _toWidth = (_toObject get "Width")/(_divisor#0); if (isnil "_toWidth" || _toWidth isEqualTo 0) then {_toWidth=(_divisor#1);};
			private _nextWidth = (_nextObject get "Width")/(_divisor#0); if (isnil "_nextWidth" || _nextWidth isEqualTo 0) then {_nextWidth=(_divisor#1);};

			_result append (_self call ["_getConnectedToPath",[_fromPoint,_direction,_toObject,_toWidth,_nextObject,_nextWidth,_dirOffset]]);
			_fromPoint = _result select -1;
			_direction = (_result select -2) getdir _fromPoint;
			_i = _i + 1;
		};
		_result pushback _end;
		_result;
	}]
]