#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_MapGraphSearch
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	
	An A* Search object for <MapGraphs>

Parent:
	<main. XPS_typ_AstarSearch>

Implements: 
	
	<main.XPS_ifc_IAstarSearch>

Flags: 
	none

	Protected: cameFrom
    
		<main.XPS_typ_AstarSearch.cameFrom>

	Protected: costSoFar
    
		<main.XPS_typ_AstarSearch.costSoFar>
		
	Protected: frontier
    
		<main.XPS_typ_AstarSearch.frontier>
		
	Protected: lastNode
    
		<main.XPS_typ_AstarSearch.lastNode>
		
	Protected: getPath
    
		<main.XPS_typ_AstarSearch.getPath>
		
	Protected: frontierAdd
    
		<main.XPS_typ_AstarSearch.frontierAdd>
		
	Protected: frontierPullLowest
    
		<main.XPS_typ_AstarSearch.frontierPullLowest>
		
	Property: Graph
    
		<main.XPS_typ_AstarSearch.Graph>
		
	Property: Doctrine
    
		<main.XPS_typ_AstarSearch.Doctrine>
		
	Property: Path
    
		<main.XPS_typ_AstarSearch.Path>
		
	Property: Status
    
		<main.XPS_typ_AstarSearch.Status>
		
	Method: AdjustEstimatedDistance
    
		<main.XPS_typ_AstarSearch.AdjustEstimatedDistance>

--------------------------------------------------------------------------------*/
[
	["#str",compileFinal {"XPS_PF_typ_MapGraphSearch"}],
	["#type","XPS_PF_typ_MapGraphSearch"],
	["#base",XPS_typ_AstarSearch"],
	["currentIsWaterTravel",false],
	["canTraverse",compileFinal {
		params [["_toNode",nil,[createhashmap]]],["_fromNode",nil,[createhashmap]];

		private _doctrine = _self get "Doctrine";
			private _capabilities = _doctrine get "Capabilities";
			private _weights = _doctrine get "Weights";
			private _limits = _doctrine get "Limits";

		private _toTerrain = _toNode get "Terrain";
			private _typeTo = _toTerrain get "Type";
			
		private _fromTerrain = _fromNode get "Terrain";
			private _typeFrom = _fromTerrain get "Type";

		private _canTraverse = false;

        if !(_capabilities get "CanUseAir") then {

            // First check if Land Unit is attempting to cross a Water Body or Naval unit on water
            private _isWaterCrossing = false;
            private _waterDistance = 0;

            // Land Unit Check for Water
            if ((_capabilities get "CanUseLand") 
				&& (_typeTo == "COAST" || _typeFrom == "COAST") 
				&& !((_typeTo == "BRIDGE" || _typeFrom == "BRIDGE") 
				&& ((_weights get "RoadWeight") < 0)) 
				&&  (_toTerrain get "WaterModifier" > 0.4 || _fromTerrain get "WaterModifier" > 0.4)
			) then {
                private _waterData = (_self get "Graph") call ["CheckWaterTravel",[_toNode get "PosCenter",_fromNode get "PosCenter"]];
                _isWaterCrossing = _waterData select 0;
                _waterDistance = _waterData select 1;
            };

            // Naval Unit check
            if ((_capabilities get "CanUseWater") && !(_capabilities get "CanUseLand") && _typeTo != "LAND") then {
                _isWaterCrossing = true;
            };

            if (!_isWaterCrossing) then {
				
				private _distance = (_toNode get "PosCenter") distance (_fromNode get "PosCenter");
                
				switch (_typeTo) do {
					case "COAST";
                    case "LAND": {
						if (_typeTo == "COAST") then {_canTraverse = (_capabilities get "CanUseWater");};
                        if ((_capabilities get "CanUseRoads") && (_toTerrain get "HasRoads")) then {_canTraverse = true;};
                        if ((_capabilities get "CanUseTrails") && (_toTerrain get "HasTrails")) then {_canTraverse = true;};
                        if ((_capabilities get "CanUseLand") && 
							((_toTerrain get "DensityModifier") < (_limits get "MaxDensity")) && 
							((abs((_toTerrain get "HeightModifier") - (_fromTerrain get "HeightModifier"))/_distance) < (_limits get "MaxSlope"))) then {
                            _canTraverse = true;
                        };
                    };
                    case "WATER": {
                        _canTraverse = (_capabilities get "CanUseWater") && !(_capabilities get "CanUseLand");
                    };
                    case "BRIDGE": {_canTraverse = true;};
                };
            } else {
                if (_capabilities get "CanUseLand") then {
                    _canTraverse = ((_capabilities get "CanUseWater") && (_waterDistance < (_limits get "MaxWaterDistance")));
                } else {
                    _canTraverse = (_capabilities get "CanUseWater");
                };
            };
        } else {
            _canTraverse = [true,false];
        };
		_self set ["currentIsWaterTravel",_isWaterCrossing];
        _canTraverse#0;
	}],
	/*----------------------------------------------------------------------------
	Method: AdjustMoveCost
    
		<main.XPS_typ_AstarSearch.AdjustMoveCost>
	-----------------------------------------------------------------------------*/
	["AdjustMoveCost",compileFinal {
		params ["_moveCost","_fromNode","_toNode"];

		private _doctrine = _self get "Doctrine";
			private _capabilities = _doctrine get "Capabilities";
			private _limits = _doctrine get "Limits";
				private _maxDensity = _limits get "MaxDensity";
			private _weights = _doctrine get "Weights";
				private _heightWeight = _weights get "HeightWeight";
				private _waterWeight = _weights get "WaterWeight";
				private _roadWeight = _weights get "RoadWeight";
				private _densityWeight = _weights get "DensityWeight";

		// Exempt Air Units
		if (_capabilities get "CanUseAir" && ((values _weights) isEqualTo [0,0,0,0]) ) exitwith {_moveCost}; 

		private _toTerrain = _toNode get "Terrain";
			private _typeTo = _toTerrain get "Type";
			
		private _fromTerrain = _fromNode get "Terrain";
			private _typeFrom = _fromTerrain get "Type";

        private _adjustedCost = _moveCost;

		private _isWaterTravel = _self get "curentisWaterTravel";

        // private _road = _weights select 0;
        // _road params  ["_hasRoads","_hasTrails","_hasBridge","_roadModifier"];
        // private _water = _weights select 1;
        // _water params ["_hasWater","_waterModifier"];
        // private _densityModifier = _weights select 3;

        private _toHeight = _toTerrain get "heightModifier";        
        private _fromHeight = _fromTerrain get "heightModifier";

        switch (_typeTo) do {
            case "WATER": {
                _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "WaterModifier") * _waterWeight);
                if (_heightWeight != 0) then {
                    _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                };
            };

            case "BRIDGE": {
                if (_isWaterTravel) exitwith {_adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "WaterModifier") * _waterWeight);};
                if (_capabilities get "CanUseRoads") then { 
                    if (_roadWeight != 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "RoadModifier") * _roadWeight);
                    };
                } else {  
                    if (_heightWeight != 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                    };
                    if (_densityWeight != 0 && _maxDensity !=0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toTerrain get "DensityModifier")/_maxDensity) * _densityWeight);
                    };
                };
            };

            case "COAST": {
                if (_isWaterTravel) exitwith {_adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "WaterModifier") * _waterWeight);};
                if (((_capabilities get "CanUseRoads") && _hasRoads) || ((_capabilities get "CanUseTrails") && _hasTrails)) then { 
                    if (_roadWeight != 0) then {
                            _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "RoadModifier") * _roadWeight);
                    };
                } else { 
                    if (_heightWeight != 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                    };
                    if (_densityWeight != 0 && _maxDensity !=0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toTerrain get "DensityModifier")/_maxDensity) * _densityWeight);
                    };
                }; 
            };

            case "LAND": {
                if (((_capabilities get "CanUseRoads") && _hasRoads) || ((_capabilities get "CanUseTrails") && _hasTrails)) then { 
                    if (_roadWeight != 0) then {
                            _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "RoadModifier") * _roadWeight);
                    };
                } else { 
                    if (_heightWeight != 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                    };
                    if (_densityWeight != 0 && _maxDensity !=0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toTerrain get "DensityModifier")/_maxDensity) * _densityWeight);
                    };
                };
            };
        };
        _adjustedCost;
	}],
	/*----------------------------------------------------------------------------
	Method: FilterNeighbors

		<main.XPS_typ_AstarSearch.FilterNeighbors>
	-----------------------------------------------------------------------------*/
	["FilterNeighbors",compileFinal {
		params ["_neighbors"];

		private _fromNode = _self get "currentNode";
		for "_i" from 0 to (count _neighbors)-1 do {
			private _canTraverse = _self call ["canTraverse",[_neighbors#_i , _fromNode]]
			if !(_canTraverse) then {
				_neighbors deleteat _i;
			};
		};
		_neighbors;
	}]
]