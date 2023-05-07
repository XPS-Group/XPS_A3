#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: folder. XPS_typ_AstarSearch
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Traverses a <HashmapObject> which implements the <XPS_ifc_IAstarNodes> hasInterface
	to find the shortest path.

Parent:
	none

Implements: 
	<XPS_ifc_IAstarNode>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_typ_AstarSearch"}],

	["#interfaces",[]],

	["#create",compileFinal {
		params ["_nodes",["_startNodeKey",nil,[]],["_endNodeKey",nil,[]]];
		_self set ["Nodes",_nodes];
		_self set ["StartNode",_startNodeKey];
		_self set ["EndNode",_endNodeKey];
		_self set ["frontier",[]];
		_self set ["costSoFar",createhashmap];
		_self get "costSoFar" set [_startNodeKey,0];
		_self set ["cameFrom",createhashmap];
		_self set ["Path",[]];
	}],

	["cameFrom",nil], //part of working graph

	["costSoFar",nil], //part of working graph

	["frontier",nil], //part of working graph

	["getPath",compileFinal {
		private _start = _self get "StartNode";
		private _current = _self get "EndNode";
		private _path = [];
		private _cameFrom = _self get "cameFrom";

		while {!(_current isEqualTo _start)} do {
			_path pushback _current;
			_current = _cameFrom get _current;
		};

		_self set ["Path",reverse _path];
	}],

	["frontierAdd",compileFinal {
		params [["_priority",nil,[0]],"_item"];

		private _frontier = _self get "frontier";
		private _frontierSize = count _frontier;
		private _i = 0;

		while {_i <= _frontierSize - 1 && { _priority > ((_frontier select _i) select 0) }} do {
			_i = _i + 1;
		};

		_frontier insert [_i, [[_priority, _item]] ];
	}],

	["frontierPullLowest",compileFinal {
		private _frontier = _self get "frontier";
		if (count _frontier > 0) then {
			_result = (_frontier deleteat 0) select 1;
		} else {
			_result = _self get "StartNode";
		};
	}],

	["Nodes",nil],

	["Path",[]],

	["ProcessNextNode",compileFinal {
		private _nodes = _self get "Nodes";
		private _endNode = _self get "EndNode";
		private _currentNode = _self get "frontierPullLowest";
		if (_endNode isEqualTo _currentNode) exitwith {
			_self call ["getPath"];
		};

		private _neighbors = _nodes call ["GetNeighbors",[_currentNode]];
		{
			private _costSoFarMap = _self get "costSoFar";
			private _estDist = _nodes call ["GetEstimatedDistance",[_currentNode,_endNode]];
			private _moveCost = _nodes call ["GetMoveCost",[_currentNode,_x]];
			private _costSofar = _costSoFarMap get _currentNode;
			private _newCostSofar = _costSoFarMap get _currentNode + _moveCost;
			private _priority = _nodes call ["GetHeuristic",[_currentNode,_x]] + _newCostSoFar + _estDist;

			if (isNil "_costSoFar" ||  _newCostSoFar < _costSoFar) then {
				_costSoFarMap set [_x, _newCostSoFar];
				_self call ["frontierAdd",[_x,_priority]];
				_self get "cameFrom" set [_x, _currentNode];
			}

		} foreach _neighbors;
	}]
]