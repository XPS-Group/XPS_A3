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
	<main.XPS_ifc_IAstarGraph>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_PF_typ_MapGraph"}],
	["#type","XPS_PF_typ_MapGraph"],
	["@interfaces",["XPS_ifc_IAstarGraph"]],
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
		params [["_layerBuilder",nil,[createhashmap]],["_useSubpositions",false,[true]]];

		private _sectorSize = _self get "SectorSize";
		private _sectorRadius = _self get "SectorRadius";
		private _gridWidth = _self get "GridWidth";

		private _sectors = createhashmap;
		for "_yAxis" from 0 to _gridWidth - 1 do {
			for "_xAxis" from 0 to _gridWidth - 1 do {
				//Set Index and Positions
				private _sector = createhashmapobject [XPS_PF_typ_MapSector,[_xAxis,_yAxis]];
				private _index = _sector get "Index";
				private _posRef = _sector set ["PosRef", [_sectorSize * _xAxis,_sectorSize * _yAxis]];
				_sector set ["PosCenter", [(_sectorSize * _xAxis)+_sectorRadius,(_sectorSize * _yAxis)+_sectorRadius]];

				//Set SubPositions - Cereates a 3x3 grid within sector with Indices of:
				// -------
				// |6|7|8|
				// -------
				// |3|4|5|
				// -------
				// |0|1|2|
				// -------
				if (_useSubpositions) then {
					private _subPosSize = _sectorRadius/2;
					private _subPositions = [];
					for "_spY" from 1 to 3 do {
						for "_spX" from 1 to 3 do {
							_subPositions pushback [_posRef#0+(_subPosSize*_spX),_posRef#1+(_subPosSize*_spY)]
						};
					};
					_sector set ["SubPositions",_subPositions];
				};

				_layerBuilder call ["BuildSector",[_sector,_sectorSize,_sectorRadius]];
				_sectors set [_index,_sector];
			};
		};
		_sector set ["Heuristic",+(_layerBuilder get "Heuristic")];
		_sectors;
	}],	
	["heuristic",compileFinal {
		//TODO #4 MapGraph - Implement heuristic
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
	Property: Layers
	
		--- Prototype --- 
		get "Layers"
		---
	
	Returns: 
		<Hashmap> - a Multidimensional <hashmap> where key is [x,y] index of sector and value is a <hashmap> of sub-values
	-----------------------------------------------------------------------------*/
	["Layers",nil],
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
		_self set ["Layers",createhashmap];
	}],	
	/*----------------------------------------------------------------------------
	Method: AddLayer
	
		--- Prototype --- 
		call ["AddLayer",[_layerName, _layerBuilder, _useSubPositions*]]
		---

	Description:
		Adds a new layer to the <Layer> <hashmap>
	
	Parameters: 
		_layerName - <String> - a name for the layer to use as key. If already exists, will overwrite.
		_layerBuilder - <HashmapObject> - which implements the <XPS_PF_ifc_ILayerBuilder> interface to produce values for each sector
		_useSubpositions* - <Boolean> - (Optional - Default : false) creates a 3x3 grid within the sector

	Returns:
		Nothing
	-----------------------------------------------------------------------------*/
	["AddLayer",compileFinal {
		if !(params [["_layerName",nil,[""]],["_layerBuilder",nil,[createhashmap]],["_useSubpositions",false,[true]]]) exitwith {false};
		if !([_layerBuilder,["XPS_PF_ifc_ILayerBuilder"]] call XPS_fnc_checkInterface) exitwith {false};
		private _layers = _self get "Layers";
		if (_layerName in keys _layers) then {_layers deleteAt _layerName;};
		private _layer = _self call ["buildLayer",[_layerBuilder]];
		_layers set ["_layerName",_layer];
	}],
	["GetEstimatedDistance",compileFinal {
		params ["_currentPos","_endPos"];
		private _pos1 = _currentPos get "PosCenter";
		private _pos2 = _endPos get "PosCenter";
		_pos1 distance _pos2;
	}],
	["GetNeighbors",compileFinal {
		//TODO #2 MapGraph - Implement GetNeighbors

		//Filter by CanTraverse?
	}],
	["GetMoveCost",compileFinal {
		params ["_currentPos","_nextPos"];
		//private _pos1 = _currentPos get "PosCenter";
		//private _pos2 = _nextPos get "PosCenter";
		//_pos1 distance _pos2;
	}],
	["Init",compileFinal {true;}]
]