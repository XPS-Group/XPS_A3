#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_TerrainLayerBuilder
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Creates a square grid map layer for a <XPS_PF_typ_MapGraph> by inspecting map/terrain 

Parent:
	none

Implements: 
	<XPS_PF_ifc_ILayerBuilder>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str", compileFinal {"XPS_PF_typ_TerrainLayerBuilder"}],
	["#type","XPS_PF_typ_TerrainLayerBuilder"],
	["@interfaces",["XPS_PF_ifc_ILayerBuilder"]],
	["LayerName","Terrain"],
	/*----------------------------------------------------------------------------
	Protected: setDensityModifier
    
    	--- Prototype --- 
    	call ["setDensityModifier",[_sector,_sectorSize]]
    	---
    
    Parameters: 
		_sector - <Hashmap> - the sector to define
		_sectorSize - <Number> - the length/width of the sector
	-----------------------------------------------------------------------------*/
	["setDensityModifier",compileFinal {
		if !(params [["_sector",nil,[createhashmap]],["_sectorSize",nil,[0]]]) exitWith {false;};

		private _densitySizeAdjust = (_sectorSize * _sectorSize) / 2500; // Normalize for 50 x 50 area
		private _searchArray = ["tree","rock","house","building","fence","wall"];
		private _densityModifier = count nearestTerrainObjects [_sector get "PosCenter", _searchArray, _sectorSize/2, false];

		_sector get (_self get "LayerName") set ["DensityModifier",_densityModifier * _densitySizeAdjust];

		true;
	}],
	/*----------------------------------------------------------------------------
	Protected: setHeightModifier
    
    	--- Prototype --- 
    	call ["setHeightModifier",[_sector]]
    	---
    
    Parameters: 
		_sector - <Hashmap> - the sector to define
	-----------------------------------------------------------------------------*/
	["setHeightModifier",compileFinal {
		if !(params [["_sector",nil,[createhashmap]]]) exitWith {false;};

		private _posRef = _sector get "PosRef";
		private _subPositions = [];
		{_subPositions pushBack [_posRef#0+(_x#0),_posRef#1+(_x#1)]} forEach (_sector get "SubPositionOffsets");
		private _numWaterAreas = 0;
		private _heightTotal = 0;
		private _isAllWater = call {!(_sector get (_self get "LayerName") get "HasBridge")};
		private _hasLand = false;
		private _hasWater = false;
		{
			private _height = getTerrainHeightASL _x;
			_heightTotal = _heightTotal + _height;
			if (_height < 0.3) then {_hasWater = true;_numWaterAreas = _numWaterAreas + 1;} else {_hasLand = true;_isAllWater = false;};
		} forEach _subPositions;

		private _layer = _sector get (_self get "LayerName");
		_layer set ["IsAllWater",_isAllWater];
		_layer set ["HasWater",_hasWater];
		_layer set ["HasLand",_hasLand];
		_layer set ["HeightModifier",_heightTotal/(count _subPositions)];
		_layer set ["WaterModifier",_numWaterAreas/(count _subPositions)];

		true;
	}],
	/*----------------------------------------------------------------------------
	Protected: setRoadModifier
    
    	--- Prototype --- 
    	call ["setRoadModifier",[_sector,_sectorRadius]]
    	---
    
    Parameters: 
		_sector - <Hashmap> - the sector to define
		_sectorRadius - <Number> - the radius of the sector 
	-----------------------------------------------------------------------------*/
	["setRoadModifier",compileFinal {
		if !(params [["_sector",nil,[createhashmap]],["_radius",nil,[0]]]) exitWith {false;};

		private _hasBridge = false;
		private _hasRoads = false;
		private _hasTrails = false;
		private _modifierList = [false,false,false,false];
		private _modifier = 1;

		{
			private _info = getRoadInfo _x;
			if (_info select 8) then {_hasBridge = true;}; 

			switch (_info select 0) do
			{
				case "MAIN ROAD": {
					_hasRoads = true;
					_modifierList set [0, true];
				};
				case "ROAD": {
					_hasRoads = true;
					_modifierList set [1, true];
				};
				case "TRACK": {
					_hasRoads = true;
					_modifierList set [2, true];
				};
				case "TRAIL": {
					_hasTrails = true;
					_modifierList set [3, true];
				};
			};
		} forEach nearestTerrainObjects [_sector get "PosCenter", ["MAIN ROAD","ROAD","TRACK","TRAIL"], _radius * 1.175, false, true];

		_sector get (_self get "LayerName") set ["HasBridge",_hasBridge]; 
		_sector get (_self get "LayerName") set ["HasRoads",_hasRoads];
		_sector	 get (_self get "LayerName") set ["HasTrails",_hasTrails];

		if !(_hasRoads || _hasTrails) then {_modifier = 0;} else {
			{
				if (_x) exitWith {};
				_modifier = _modifier - 0.1;
			} forEach _modifierList; 
		};


		_sector	 get (_self get "LayerName") set ["RoadModifier",_modifier];

		true;
	}],
	/*----------------------------------------------------------------------------
	Method: AddLayerData
    
    	--- Prototype --- 
    	call ["AddLayerData",[_sector,_sectorSize,_sectorRadius]]
    	---

		<XPS_PF_ifc_ILayerBuilder.AddLayerData>
    
    Parameters: 
		_sector - <Hashmap> - the sector to define
		_sectorSize - <Number> - the length/width of the sector
		_sectorRadius - <Number> - the radius of the sector 
	-----------------------------------------------------------------------------*/
	["AddLayerData",compileFinal {
		if !(params [["_sector",nil,[createhashmap]],["_sectorSize",nil,[0]],["_sectorRadius",nil,[0]]]) exitWith {nil;};

		_sector set [_self get "LayerName",createhashmap];

		_self call ["setRoadModifier",[_sector,_sectorRadius]];
		_self call ["setHeightModifier",[_sector]];
		_self call ["setDensityModifier",[_sector,_sectorSize]];

		private _layer = _sector get (_self get "LayerName");
		_layer set ["Type", "LAND"];
		if (_layer get "IsAllWater") then {_layer set ["Type","WATER"];};
		if (_layer get "HasWater" && _layer get "HasLand") then {_layer set ["Type","COAST"];};
		if (_layer get "HasBridge") then {_layer set ["Type","BRIDGE"];};

		_sector;
	}]
]