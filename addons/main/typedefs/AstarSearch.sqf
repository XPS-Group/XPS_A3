#include "script_component.hpp"


[
	["#str",{"XPS_typ_AstarSearch"}],

	["#interfaces",[]],

	["#create",compileFinal {
		params [["_nodes"],["_startNodeKey"],["_endNodeKey"]];
		_self set ["Nodes",_nodes];
		_self set ["StartNode",_startNode];
		_self set ["EndNode",_endNode];
		_self set ["frontier",[]];
		_self set ["costSoFar",createhashmap];
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
	}],

	["frontierAdd",compileFinal {
		params [["_priority",nil,[0]],["_item",nil,[createhashmap]]];

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
		}
		private _neighbors = _nodes call ["GetNeighbors",[_currentNode]];
		{
			private _estDist = _nodes call ["GetEstimatedDistance",[_currentNode,_endNode]];
			private _moveCost = _nodes call ["GetMoveCost",[_currentNode]];
			private _priority = _nodes call ["GetHeuristic",[_currentNode]];

			//TODO - maybe add "CurrentNode" property so we can get previous node

			//TODO - score values and store in working graph

		} foreach _neighbors;
	}]
]