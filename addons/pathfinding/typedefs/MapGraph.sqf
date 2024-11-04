#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_MapGraph
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Creates a square grid map to the bounds of the worldSize based on a specified
	size of each square using a <XPS_PF_ifc_ILayerBuilder> to define the values
	of each Sector

Parent:
	none

Implements: 

	<pathfinding.XPS_PF_ifc_IMapGraph>

	<main.XPS_ifc_IAstarGraph>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str", compileFinal {"XPS_PF_typ_MapGraph"}],
	["#type","XPS_PF_typ_MapGraph"],
	["@interfaces",["XPS_PF_ifc_IMapGraph","XPS_ifc_IAstarGraph"]],
	/*----------------------------------------------------------------------------
	Protected: buildGraph
	
		--- Prototype --- 
		call ["buildGraph"]
		---
	
	Parameters: 
		none
	
	Returns: 
		<Hashmap> - of sectors (each a <hashmap> in and of itself) where key is [x,y] index from [0,0] to [numXSectors,numYSectors] (not a world position)
	-----------------------------------------------------------------------------*/
	["buildGraph",compileFinal {

		private _sectors = _self get "Sectors";
		private _sectorSize = _self get "SectorSize";
		private _sectorRadius = _self get "SectorRadius";
		private _gridWidth = _self get "GridWidth";

		// Set SubPosition Offset (same for each sector - based on Sector size) 
		// Creates a 3x3 grid of offset positions within sector with Indices of:
		//
		// 	-------
		// 	|6|7|8|
		// 	-------
		// 	|3|4|5|
		// 	-------
		// 	|0|1|2|
		// 	-------
		//
		private _subPosSize = _sectorRadius/2;
		private _subPositions = [];
		for "_spY" from 1 to 3 do {
			for "_spX" from 1 to 3 do {
				_subPositions pushBack [(_subPosSize*_spX),(_subPosSize*_spY)]
			};
		};

		// Create Sector with Index
		for "_yAxis" from 0 to _gridWidth - 1 do {
			for "_xAxis" from 0 to _gridWidth - 1 do {
				//Set Index and Positions
				private _sector = _sectors get [_xAxis,_yAxis];

				if (isNil "_sector") then {
					//_sector = createHashmapObject [XPS_PF_typ_MapNode,[_xAxis,_yAxis]];
					_sector = createHashMapFromArray [["Index",[_xAxis,_yAxis]]];
					private _index = _sector get "Index";
					private _posRef = [_sectorSize * _xAxis,_sectorSize * _yAxis];
					_sector set ["PosRef", _posRef];
					_sector set ["PosCenter", [(_sectorSize * _xAxis)+_sectorRadius,(_sectorSize * _yAxis)+_sectorRadius]];
					_sector set ["SubPositionOffsets",_subPositions];

					_sectors set [_index,_sector];
				};
			};
		};
	}],	
	/*----------------------------------------------------------------------------
	Protected: buildLayer
	
		--- Prototype --- 
		call ["buildLayer",[_layerBuilder,_useSubpositions*]]
		---
	
	Parameters: 
		_layerBuilder - <HashmapObject> - which implements the <XPS_PF_ifc_ILayerBuilder> interface
		_useSubpositions* - <Boolean> - (Optional - Default : false) creates a 3x3 grid within the sector
	
	Returns: 
		<Hashmap> - of sectors (each a <hashmap> in and of itself) where key is [x,y] index from [0,0] to [numXSectors,numYSectors] (not a world position)
	-----------------------------------------------------------------------------*/
	["buildLayer",compileFinal {
		params [["_layerBuilder",nil,[createhashmap]]];

		private _sectors = _self get "Sectors";
		private _sectorSize = _self get "SectorSize";
		private _sectorRadius = _self get "SectorRadius";
		private _gridWidth = _self get "GridWidth";

		for "_yAxis" from 0 to _gridWidth - 1 do {
			for "_xAxis" from 0 to _gridWidth - 1 do {
				private _sector = _sectors get [_xAxis,_yAxis];
				_layerBuilder call ["AddLayerData",[_sector,_sectorSize,_sectorRadius]];
			};
		};
	}],	
	/*----------------------------------------------------------------------------
	Protected: posToIndex
	
		--- Prototype --- 
		call ["posToIndex",[_pos]]
		---
	
	Parameters: 
		_pos - <Array> - 2D or 3D position array
	
	Returns: 
		<Array> - Index of sector containing position
	-----------------------------------------------------------------------------*/
	["posToIndex",compileFinal {
        if !(params [["_pos",nil,[[]],[2,3]]]) exitWith {nil;};

        private _sectorSize = _self get "SectorSize";

        private _x = floor ((_pos select 0) / _sectorSize);
        private _y = floor ((_pos select 1) / _sectorSize);

        [_x,_y];

	}],
	/*----------------------------------------------------------------------------
	Protected: posToSubIndex
	
		--- Prototype --- 
		call ["posToSubIndex",[_pos]]
		---
		SubPositions - a 3x3 grid within sector with Indices of:
		
			-------
			|6|7|8|
			-------
			|3|4|5|
			-------
			|0|1|2|
			-------
	
	Parameters: 
		_pos - <Array> - 2D or 3D position array
	
	Returns: 
		<Number> - Index of subposition in sector containing position (0 to 8)
	-----------------------------------------------------------------------------*/
	["posToSubIndex",compileFinal {
        if !(params [["_pos",nil,[[]],[2,3]]]) exitWith {nil;};

		private _sector = _self get "Sectors" get (_self call ["posToIndex",_pos]);
		private _posRef = _sector get "PosRef";
        private _subSectorSize = (_self get "SectorSize")/2;

        private _x = floor ((_pos select 0) - (_posRef select 0));
        private _y = floor ((_pos select 1) - (_posRef select 1));

		floor (_x / _subsectorSize) + floor (_y / _subSectorSize)*3; 

	}],
	/*----------------------------------------------------------------------------
	Property: SectorSize
	
		--- Prototype --- 
		get "SectorSize"
		---
	
	Returns: 
		<Number> - the length of one side of the sector in meters
	-----------------------------------------------------------------------------*/
	["SectorSize",nil],
	/*----------------------------------------------------------------------------
	Property: SectorRadius
	
		--- Prototype --- 
		get "SectorRadius"
		---
	
	Returns: 
		<Number> - the distance from center to perpendicular point of edge (1/2 SectorSize)
	-----------------------------------------------------------------------------*/
	["SectorRadius",nil],
	/*----------------------------------------------------------------------------
	Property: GridWidth
	
		--- Prototype --- 
		get "GridWidth"
		---
	
	Returns: 
		<Number> - The number of sectors across X or Y axis
	-----------------------------------------------------------------------------*/
	["GridWidth",nil],
	/*----------------------------------------------------------------------------
	Property: Sectors
	
		--- Prototype --- 
		get "Sectors"
		---

		<pathfinding.XPS_PF_ifc_IMapGraph.Sectors>
	
	Returns: 
		<Hashmap> - a Multidimensional <hashmap> where key is [x,y] index of sector and value is a <hashmap> of sub-values
	-----------------------------------------------------------------------------*/
	["Sectors",createhashmap],
	/*----------------------------------------------------------------------------
	Constructor: #create
	
		--- Prototype --- 
		_result = createHashmapObject ["XPS_PF_typ_MapGraph",[_sectorSize*]]
		---
	
	Optionals: 
		_sectorSize* - <Number> - (Optional - Default : 1000) size of the square in meters

	Returns:
		_result - <HashmapObject> - the map grid
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_sectorSize",1000,[0]]];
		_self set ["SectorSize",_sectorSize];
		_self set ["SectorRadius",_sectorSize/2];
		_self set ["GridWidth", ceil(worldSize/_sectorSize)];
		_self set ["Sectors",createhashmap];
		_self call ["buildGraph"];
	}],	
	/*----------------------------------------------------------------------------
	Method: AddLayer
	
		--- Prototype --- 
		call ["AddLayer",[_layerBuilder]]
		---

		<pathfinding.XPS_PF_ifc_IMapGraph.AddLayer>

	Description:
		Adds a new layer to Sector Data and Heuristics
	
	Parameters: 
		_layerName - <String> - a name for the layer to use as key. If already exists, will overwrite.
		_layerBuilder - <HashmapObject> - which implements the <XPS_PF_ifc_ILayerBuilder> interface to produce values for each sector
		_useSubpositions* - <Boolean> - (Optional - Default : false) creates a 3x3 grid within the sector

	Returns:
		Nothing
	-----------------------------------------------------------------------------*/
	["AddLayer",compileFinal {
		if !(params [["_layerBuilder",nil,[createhashmap]]]) exitWith {false};
		if !( CHECK_IFC1(_layerBuilder,XPS_PF_ifc_ILayerBuilder)) exitWith {false};
		private _layer = _self call ["buildLayer",[_layerBuilder]];
	}],
	["CheckWaterTravel", compileFinal {

		params ["_sectorAPos","_sectorBPos"];
		private _waterTravel = false;
		private _dist = _sectorAPos distance _sectorBPos;
		private _inc = ceil(_dist / 15);
		private _waterDistance = 0;
		_a = ((_sectorBPos select 0) - (_sectorAPos select 0))/_inc;
		_b = ((_sectorBPos select 1) - (_sectorAPos select 1))/_inc;

		for "_i" from 0 to _inc do {
			_heightASL = getTerrainHeightASL [(_sectorAPos select 0) + (_a*_i),(_sectorAPos select 1) + (_b*_i)];
			if (_heightASL < -0.3) then {
				_waterTravel = true;
				_waterDistance = _waterDistance + _inc;
			};
		};
		
		[_waterTravel,_waterDistance];
	}],
	/*----------------------------------------------------------------------------
	Method: GetEstimate
    
    	--- Prototype --- 
    	call ["GetEstimate",[_current,_end]]
    	---

		<main.XPS_ifc_IAstarGraph.GetEstimate>
    
    Optionals: 
		_current - <Hashmap> - current sector
		_end - <Hashmap> - goal sector
	-----------------------------------------------------------------------------*/
	["GetEstimate",compileFinal {
		params ["_current","_end"];
		private _pos1 = _current get "PosCenter";
		private _pos2 = _end get "PosCenter";
		_pos1 distance _pos2;
	}],
	/*----------------------------------------------------------------------------
	Method: GetNeighbors
    
    	--- Prototype --- 
    	call ["GetNeighbors",[_current,_prev,_doctrine]]
    	---

		<main.XPS_ifc_IAstarGraph.GetNeighbors>
    
    Optionals: 
		_current - <Hashmap> - current sector
		_prev - <Hashmap> - previous sector
		_doctrine - <Hashmap> - doctrine to use
	-----------------------------------------------------------------------------*/
	["GetNeighbors",compileFinal {
		params [["_current",nil,[createhashmap]],"_prev"];

		private _neighbors = [];
		private _index = _current get "Index";
        { 
            private _a = (_index#0) + (_x#0);
            private _b = (_index#1) + (_x#1);
			private _isPrev = false;
			if !(isNil "_prev") then {_isPrev = ([_a,_b] isEqualTo (_prev get "Index"))};
			if !(_isPrev) then {
				private _neighbor = _self get "Sectors" get [_a,_b];
				if !(isNil "_neighbor") then {
					_neighbors pushBack _neighbor;
				};
			};
        } forEach [[-1,-1],[0,-1],[1,-1],[-1,0],[1,0],[-1,1],[0,1],[1,1]];

		_neighbors;
	}],
	/*----------------------------------------------------------------------------
	Method: GetCost
    
    	--- Prototype --- 
    	call ["GetCost",[_current,_next,_doctrine]]
    	---

		<main.XPS_ifc_IAstarGraph.GetCost>
    
    Optionals: 
		_current - <Hashmap> - current sector of working graph 
		_next - <Hashmap> - connected sector
		_doctrine - <Hashmap> - doctrine to use
	-----------------------------------------------------------------------------*/
	["GetCost",compileFinal {
		params ["_current","_next"];
		private _pos1 = _current get "PosCenter";
		private _pos2 = _next get "PosCenter";
		_pos1 distance _pos2;
	}],
	/*----------------------------------------------------------------------------
	Method: GetNodeAt
    
    	--- Prototype --- 
    	call ["GetNodeAt",[_pos]]
    	---

		<main.XPS_ifc_IAstarGraph.GetNodeAt>
    
    Optionals: 
		_pos - <Array> - current position to search
	-----------------------------------------------------------------------------*/
	["GetNodeAt",compileFinal {
		if !(params [["_pos",nil,[[]],[2,3]]]) exitWith {nil};
		
		private _index = _self call ["posToIndex",[_pos]];

		// If out of bounds, clamp to edge
		for "_i" from 0 to 1 do {
    		if (_index#_i <= 0) then {_index set [_i,1];};
    		if (_index#_i >= worldSize) then {_index set [_i,worldSize - 1];};
		};
    
		_self get "Sectors" get _index;
	}],
	/*----------------------------------------------------------------------------
	Method: Init

    	--- Prototype --- 
    	call ["Init"]
    	---

		<main.XPS_ifc_IAstarGraph.Init>

	Returns:
		Nothing
	-----------------------------------------------------------------------------*/
	["Init", {}]
]