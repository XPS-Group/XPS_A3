#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: main. XPS_typ_AstarSearch
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Traverses a <HashmapObject> which implements the <XPS_ifc_IAstarGraph> interface
	to find the best path.

Parent:
	none

Implements: 
	<XPS_ifc_IAstarNode>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_typ_AstarSearch"}],
	["#type","XPS_typ_AstarSearch"],
	["@interfaces",["XPS_ifc_IAstarSearch"]],

	/*----------------------------------------------------------------------------
	Protected: cameFrom
    
    	--- Prototype --- 
    	get "cameFrom"
    	---
    
    Returns: 
		<Hashmap> - of nodes where key is index and value is previous node in graph
	-----------------------------------------------------------------------------*/
	["cameFrom",nil], //part of working graph
	/*----------------------------------------------------------------------------
	Protected: costSoFar
    
    	--- Prototype --- 
    	get "costSoFar"
    	---
    
    Returns: 
		<Hashmap> - of nodes where key is index and value is cost to reach node from start
	-----------------------------------------------------------------------------*/
	["costSoFar",nil], //part of working graph
	/*----------------------------------------------------------------------------
	Protected: frontier
    
    	--- Prototype --- 
    	get "frontier"
    	---
    
    Returns: 
		<Array> - of nodes from priority lowest to highest (higher is worse)
	-----------------------------------------------------------------------------*/
	["frontier",nil], //part of working graph
	/*----------------------------------------------------------------------------
	Protected: lastNode
    
    	--- Prototype --- 
    	get "lastNode"
    	---
    
    Returns: 
		<Hashmap> - returns last node processed in case path unsuccessfully reaches goal node
	-----------------------------------------------------------------------------*/
	["lastNode",nil],
	/*----------------------------------------------------------------------------
	Protected: getPath
    
    	--- Prototype --- 
    	call ["getPath"]
    	---
    
    Returns: 
		<Array> - of nodes from start to goal
	-----------------------------------------------------------------------------*/
	["getPath",compileFinal {
		private _status = "FAILED";
		private _start = _self get "StartNode";
		private _end = _self get "EndNode";
		private _current = _end;
		private _path = [];
		private _cameFrom = _self get "cameFrom";

		if (isNil {_cameFrom get (_current get "Index")}) then {_current = _self get "lastNode";};

		while {!(isNil "_current") && !(_current isEqualTo _start)} do {
			_path pushback _current;
			_current = _cameFrom get (_current get "Index");
		};

		if (_current isEqualTo _start) then {_status = "SUCCESS";};
		reverse _path;
		_self set ["Path",_path];
		_self set ["Status",_status];

	}],
	/*----------------------------------------------------------------------------
	Protected: frontierAdd
    
    	--- Prototype --- 
    	call ["frontierAdd",[_priority,_item]]
    	---

    Parameters:
		_priority - <Number> - the value which determines index in frontier array. Lowest first.
		_item - <Anything> - The key of the item being placed in priority queue

    Returns: 
		<Array> - of nodes from start to goal
	-----------------------------------------------------------------------------*/
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
	/*----------------------------------------------------------------------------
	Protected: frontierPullLowest
    
    	--- Prototype --- 
    	call ["frontierPullLowest"]
    	---

    Returns: 
		<Anything> - key of node that is at front of frontier queue. Item is removed from queue
	-----------------------------------------------------------------------------*/
	["frontierPullLowest",compileFinal {
		private _frontier = _self get "frontier";
		if (count _frontier > 0) exitwith {
			(_frontier deleteat 0) # 1;
		};
		nil;
	}],
	/*----------------------------------------------------------------------------
	Property: Graph
    
    	--- Prototype --- 
    	get "Graph"
    	---
    
    Returns: 
		<HashmapObject> - A graph of nodes that implement the <XPS_typ_IAstarGraph> interface
	-----------------------------------------------------------------------------*/
	["Graph",nil],
	/*----------------------------------------------------------------------------
	Property: Path
    
    	--- Prototype --- 
    	get "Path"
    	---
    
    Returns: 
		<Array> - of Node keys from start to goal
	-----------------------------------------------------------------------------*/
	["Path",[]],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---
    
    Returns: 
		<String> - the current status of the search. 

		Will be one of:
		
			- RUNNING
			- SUCCESS
			- FAILURE 
	-----------------------------------------------------------------------------*/
	["Status","RUNNING"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject [XPS_typ_AstarSearch,[_graph,_startKey*,_endKey*]]
    	---
    
	Parameters:
		_graph - <XPS_ifc_IAstarGraph> - the graph to perform the search on

    Optionals: 
		_startKey* - <Anything> - (Optional - Default : nil) 
    	_endKey* - <Anything> - (Optional - Default : nil) 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params ["_graph",["_startKey",nil,[]],["_endKey",nil,[]]];
		_self set ["Graph",_graph];
		_self set ["StartKey",_startKey];
		_self set ["EndKey",_endKey];
		_self call ["InitGraph"];
	}],
	/*----------------------------------------------------------------------------
	Method: InitGraph
    
    	--- Prototype --- 
    	call ["InitGraph"]
    	---
    
    Calls the initialization of the associated graph with the start and end keys.
	Can be used to reset pathfinding also.
	-----------------------------------------------------------------------------*/
	["InitGraph",compileFinal {
		private _graph = _self get "Graph";
		_self set ["StartNode",_graph call ["GetNodeAt",[_self get "StartKey"]]];
		_self set ["EndNode",_graph call ["GetNodeAt",[_self get "EndKey"]]];
		_self set ["frontier",[[0,_self get "StartNode"]]];
		_self set ["costSoFar",createhashmap];
		_self get "costSoFar" set [_self get "StartNode" get "Index",0];
		_self set ["cameFrom",createhashmap];
		_self set ["Path",[]];
	}],
	/*----------------------------------------------------------------------------
	Method: ProcessNextNode
    
    	--- Prototype --- 
    	call ["ProcessNextNode"]
    	---
    
    Causes the AstarSearch object to process the next node in frontier queue and place
	it onto the working graph.
	-----------------------------------------------------------------------------*/
	["ProcessNextNode",compileFinal {
		private _graph = _self get "Graph";
		private _endNode = _self get "EndNode";
		private _currentNode = _self call ["frontierPullLowest"];
		if (isNil "_currentNode" || (_endNode get "Index") isEqualTo (_currentNode get "Index")) exitwith {
			_self call ["getPath"];
		};
		private _prevNode = _self get "cameFrom" get (_currentNode get "Index");

		private _neighbors = _graph call ["GetNeighbors",[_currentNode,_prevNode]];

		{
			private _costSoFarMap = _self get "costSoFar";
			private _estDist = _graph call ["GetEstimatedDistance",[_x,_endNode]];
			private _moveCost = _graph call ["GetMoveCost",[_currentNode,_x]];
			private _costSofar = (_costSoFarMap get (_currentNode get "Index")) + _moveCost;
			private _priority = _costSoFar + _estDist;
			private _costSoFarX = _costSoFarMap get (_x get "Index");

			if (isNil {_costSoFarX} || {_costSoFar < _costSoFarX}) then {
				_costSoFarMap set [_x get "Index", _costSoFar];
				_self call ["frontierAdd",[_priority,_x]];
				_self get "cameFrom" set [_x get "Index", _currentNode];
			}

		} foreach _neighbors;

		_self set ["lastNode",_currentNode];
	}]
]