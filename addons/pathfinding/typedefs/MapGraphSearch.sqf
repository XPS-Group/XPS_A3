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
	["checkCoastTravelForWater", compileFinal {

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
	};],
	["canTraverse",compileFinal {
		params [["_current",nil,[createhashmap]],["_prev",nil,[createhashmap]],["_doctrine",nil,[createhashmap]]];

		private _typeTo = _current get "Terrain" get "Type";
		private _typeFrom = _prev get "Terrain" get "Type";

		private _canTraverse = false;

        if !(_doctrine get "Capabilities" get "CanUseAir") then {

            // First check if Land Unit is attempting to cross a Water Body or Naval unit on water
            private _isWaterCrossing = false;
            private _waterDistance = 0;
            private _isCoastTravel = (_typeTo == "COAST" || _typeFrom == "COAST");
            private _isMovingToFromBridge = (_typeTo == "BRIDGE" || _typeFrom == "BRIDGE") && ((_doctrine get "Modifiers" get "RoadWeight") < 0);
            private _hasDeepWater = ((_current get "Terrain" get "WaterModifier") > 0.4) || ((_prev get "Terrain" get "WaterModifier") > 0.4);

            // Land Unit Check for Water
            if (_isCoastTravel && !(_isMovingToFromBridge) && (_doctrine get "Capabilities" get "CanUseLand") && _hasDeepWater) then {
                private _waterData = _self call ["checkCoastTravelForWater",[_current get "PosCenter",_prev get "PosCenter"]];
                _isWaterCrossing = _waterData select 0;
                _waterDistance = _waterData select 1;
            };
            // Naval Unit check
            if ((_doctrine get "Capabilities" get "CanUseWater") && !(_doctrine get "Capabilities" get "CanUseLand") && _typeTo != "LAND") then {
                _isWaterCrossing = true;
            };

            if (!_isWaterCrossing) then {
				
				private _distance = (_current get "PosCenter") distance (_prev get "PosCenter");
                
				switch (_typeTo) do {
					case "COAST";
                    case "LAND": {
						if (_typeTo == "COAST") then {_canTraverse = (_doctrine get "Capabilities" get "CanUseWater");};
                        if ((_doctrine get "Capabilities" get "CanUseRoads") && (_current get "Terrain" get "HasRoads")) then {_canTraverse = true;};
                        if ((_doctrine get "Capabilities" get "CanUseTrails") && (_current get "Terrain" get "HasTrails")) then {_canTraverse = true;};
                        if ((_doctrine get "Capabilities" get "CanUseLand") && 
							((_current get "Terrain" get "DensityModifier") < (_doctrine get "Limits" get "MaxDensity")) && 
							((abs((_current get "Terrain" get "HeightModifier") - (_prev get "Terrain" get "HeightModifier"))/_distance) < (_doctrine get "Limits" get "MaxSlope"))) then {
                            _canTraverse = true;
                        };
                    };
                    case "WATER": {
                        _canTraverse = (_doctrine get "Capabilities" get "CanUseWater") && !(_doctrine get "Capabilities" get "CanUseLand");
                    };
                    case "BRIDGE": {_canTraverse = true;};
                };
            } else {
                if (_doctrine get "Capabilities" get "CanUseLand") then {
                    _canTraverse = [((_doctrine get "Capabilities" get "CanUseWater") && (_waterDistance < (_doctrine get "Limits" get "MaxWaterDistance"))),_isWaterCrossing];
                } else {
                    _canTraverse = [(_doctrine get "Capabilities" get "CanUseWater"),_isWaterCrossing];
                };
            };
        } else {
            _canTraverse = [true,false];
        };

        _canTraverse;
	}],
	/*----------------------------------------------------------------------------
	Method: AdjustMoveCost
    
		<main.XPS_typ_AstarSearch.AdjustMoveCost>
	-----------------------------------------------------------------------------*/
	["AdjustMoveCost",compileFinal {
		params ["_moveCost"];
	}],
	/*----------------------------------------------------------------------------
	Method: FilterNeighbors

		<main.XPS_typ_AstarSearch.FilterNeighbors>
	-----------------------------------------------------------------------------*/
	["FilterNeighbors",compileFinal {
		params ["_neighbors"];
		for "_i" from 0 to (count _neighbors)-1 do {
			private _traversaldata = _self call ["canTraverse",[_current,_prev,_doctrine]]
			private _canTraverse = _traversalData#0;
			if !(_canTraverse) then {
				_neighbors deleteat _i;
			};
		};
	}]
]