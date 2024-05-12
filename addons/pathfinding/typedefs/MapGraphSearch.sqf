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
	["#base",XPS_typ_AstarSearch],
	["_currentIsWaterTravel",false],
	/*----------------------------------------------------------------------------
	Protected: canTraverse
	
		---prototype
		_result = _self call ["canTraverse",[_toNode,_fromNode]];
		---

	Parameters:
		_toNode - <HashmapObject> - the node traversing to
		_fromNode - <HashmapObject> - the node traversing from

	Returns:
		_result - <Boolean> - if node to node traversal is capable using the property <main.XPS_typ_AstarSearch.Doctrine>
	-----------------------------------------------------------------------------*/
	["canTraverse",compileFinal {
		params [["_toNode",nil,[createhashmap]],["_fromNode",nil,[createhashmap]]];

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
		_self set ["_currentIsWaterTravel",_isWaterCrossing];
        _canTraverse;
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

		// Exempt Air Units with no bias
		if (_capabilities get "CanUseAir" && ((values _weights) isEqualTo [0,0,0,0]) ) exitwith {_moveCost}; 

		private _toTerrain = _toNode get "Terrain";
			private _typeTo = _toTerrain get "Type";
        	private _toHeight = _toTerrain get "HeightModifier";   
			
		private _fromTerrain = _fromNode get "Terrain";
			//private _typeFrom = _fromTerrain get "Type";
        	private _fromHeight = _fromTerrain get "HeightModifier";

		private _sectorDistance = _moveCost; // base moveCost is a function of distance already

        private _adjustedCost = _moveCost;

		private _isWaterTravel = _self get "_currentIsWaterTravel";
     

        switch (_typeTo) do {
            case "WATER": {
                _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "WaterModifier") * _waterWeight);
                if (_heightWeight isNotEqualTo 0) then {
                    _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                };
            };

            case "BRIDGE": {
                if (_isWaterTravel) exitwith {_adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "WaterModifier") * _waterWeight);};
                if (_capabilities get "CanUseRoads") then { 
                    if (_roadWeight isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "RoadModifier") * _roadWeight);
                    };
                } else {  
                    if (_heightWeight isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                    };
                    if (_densityWeight isNotEqualTo 0 && _maxDensity isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toTerrain get "DensityModifier")/_maxDensity) * _densityWeight);
                    };
                };
            };

            case "COAST": {
                if (_isWaterTravel) exitwith {_adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "WaterModifier") * _waterWeight);};
                if (((_capabilities get "CanUseRoads") && (_toTerrain get "HasRoads")) || ((_capabilities get "CanUseTrails") && (_toTerrain get "HasTrails"))) then { 
                    if (_roadWeight isNotEqualTo 0) then {
                            _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "RoadModifier") * _roadWeight);
                    };
                } else { 
                    if (_heightWeight isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                    };
                    if (_densityWeight isNotEqualTo 0 && _maxDensity isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toTerrain get "DensityModifier")/_maxDensity) * _densityWeight);
                    };
                }; 
            };

            case "LAND": {
                if (((_capabilities get "CanUseRoads") && (_toTerrain get "HasRoads")) || ((_capabilities get "CanUseTrails") && (_toTerrain get "HasTrails"))) then { 
                    if (_roadWeight isNotEqualTo 0) then {
                            _adjustedCost = _adjustedCost + (_adjustedCost * (_toTerrain get "RoadModifier") * _roadWeight);
                    };
                } else { 
                    if (_heightWeight isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toHeight - _fromHeight)/_sectorDistance) * _heightWeight );
                    };
                    if (_densityWeight isNotEqualTo 0 && _maxDensity isNotEqualTo 0) then {
                        _adjustedCost = _adjustedCost + (_adjustedCost * ((_toTerrain get "DensityModifier")/_maxDensity) * _densityWeight);
                    };
                };
            };
        };
		//diag_log [_typeTo,_moveCost,_adjustedCost];
        _adjustedCost;
	}],
	/*----------------------------------------------------------------------------
	Method: FilterNeighbors

		<main.XPS_typ_AstarSearch.FilterNeighbors>
	-----------------------------------------------------------------------------*/
	["FilterNeighbors",compileFinal {
		params [["_neighbors",nil,[[]]]];
		
		if (count _neighbors < 1) exitwith {[]};

		private _fromNode = _self get "currentNode";
		private _i = 0;
		while { _i < count _neighbors } do {
			private _canTraverse = _self call ["canTraverse",[_neighbors#_i , _fromNode]];
			if !(_canTraverse) then {
				_neighbors deleteat _i;
			} else {_i = _i + 1;};
		};
	}]
]