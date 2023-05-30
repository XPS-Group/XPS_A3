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
	["#str",{"XPS_PF_typ_TerrainLayerBuilder"}],
	["#type","XPS_PF_typ_TerrainLayerBuilder"],
	["#interfaces",["XPS_PF_ifc_ILayerBuilder"]],
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
		if !(params [["_sector",nil,[createhashmap]],["_sectorSize",nil,[0]]]) exitwith {false;};

		private _densitySizeAdjust = (_sectorSize * _sectorSize) / 2500; // Normalize for 50 x 50 area
		private _searchArray = ["tree","rock","house","building","fence","wall"];
		private _densityModifier = count nearestTerrainObjects [_sector get "PosCenter", _searchArray, _sectorSize/2, false];

		_sector set ["DensityModifier",_densityModifier * _densitySizeAdjust];

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
		if !(params [["_sector",nil,[createhashmap]]]) exitwith {false;};

		private _subPositions = _sector get "SubPositions";
		private _numWaterAreas = 0;
		private _heightTotal = 0;
		private _isAllWater = !(_sector get "HasBridge");
		private _hasLand = false;
		private _hasWater = false;
		{
			private _height = getTerrainHeightASL _x;
			_heightTotal = _heightTotal + _height;
			if (_height < 0.3) then {_hasWater = true;_numWaterAreas = _numWaterAreas + 1;} else {_hasLand = true;_isAllWater = false;};
		} foreach _subPositions;

		_sector set ["IsAllWater",_isAllWater];
		_sector set ["HasWater",_hasWater];
		_sector set ["HasLand",_hasLand];
		_sector set ["HeightModifier",_heightTotal/(count _subPositions)];
		_sector set ["WaterModifier",_numWaterAreas/(count _subPositions)];

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
		if !(params [["_sector",nil,[createhashmap]],["_radius",nil,[0]]]) exitwith {false;};

		{
			private _info = getRoadInfo _x;
			if (_info select 8) then { _sector set ["HasBridge",true]; };

			switch (_info select 0) do
			{
				case "MAIN ROAD";
				case "ROAD";
				case "TRACK": {
					_sector set ["HasRoads",true];
				};
				case "TRAIL": {
					_sector set ["HasTrails",true];
				};
			};
		} foreach nearestTerrainObjects [_sector get "PosCenter", ["MAIN ROAD","ROAD","TRACK","TRAIL"], _radius * 1.175, false, true];

		true;
	}],
	/*----------------------------------------------------------------------------
	Method: BuildSector
    
    	--- Prototype --- 
    	call ["BuildSector",[_sector,_sectorSize,_sectorRadius]]
    	---

		<XPS_PF_ifc_ILayerBuilder.BuildSector>
    
    Parameters: 
		_sector - <Hashmap> - the sector to define
		_sectorSize - <Number> - the length/width of the sector
		_sectorRadius - <Number> - the radius of the sector 
	-----------------------------------------------------------------------------*/
	["BuildSector",compileFinal {
		if !(params [["_sector",nil,[createhashmap]],["_sectorSize",nil,[0]],["_sectorRadius",nil,[0]]]) exitwith {nil;};

		_self call ["setRoadModifier",[_sector,_sectorRadius]];
		_self call ["setHeightModifier",[_sector]];
		_self call ["setDensityModifier",[_sector,_sectorSize]];

		_sector set ["Type", "LAND"];
		if (_sector get "IsAllWater") then {_sector set ["Type","WATER"];};
		if (_sector get "HasWater" && _sector get "HasLand") then {_sector set ["Type","COAST"];};
		if (_sector get "HasBridge") then {_sector set ["Type","BRIDGE"];};

		_sector;
	}]
]