#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_AstarSearch
	<TypeDefinition>

    	--- Prototype --- 
		XPS_typ_AstarSearch :  XPS_ifc_IAstarSearch
    	---

    	--- Code --- 
    	_result = createHashmapObject ["XPS_typ_AstarSearch",[_graph,_startKey,_endKey]]
    	---

Authors: 
	Crashdome

Description:
	Traverses a <HashmapObject> which implements the <XPS_ifc_IAstarGraph> interface
	to find the best path.
	
Parameters:
	_graph - <XPS_ifc_IAstarGraph> - the graph to perform the search on
	_startKey - <Anything> 
	_endKey - <Anything> 

Returns:
	_result - <HashmapObject>
--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_AstarSearch"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create",[_graph,_startKey,_endKey]]
    	---
    
	Parameters:
		_graph - <XPS_ifc_IAstarGraph> - the graph to perform the search on
		_startKey - <Anything> 
    	_endKey - <Anything> 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		if !(params [["_graph",nil,[createhashmap]],["_startKey",nil,[]],["_endKey",nil,[]]]) exitwith {nil;};
		if !(CHECK_IFC1(_graph,XPS_ifc_IAstarGraph)) then {diag_log text format["XPS_typ_AstarSearch: %1 does not pass interface check for XPS_ifc_IAstarGraph",_graph]};
		_self set ["_workingGraph",_graph];
		_self set ["_workingStartKey",_startKey];
		_self set ["_workingEndKey",_endKey];
		_self call ["Init"];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_AstarSearch"
		---
	----------------------------------------------------------------------------*/
	["#str",compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IAstarSearch>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IAstarSearch"]],
	["_workingGraph",nil],
	["_workingStartKey",nil],
	["_workingEndKey",nil],
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
	Protected: currentNode
    
    	--- Prototype --- 
    	get "currentNode"
    	---
    
    Returns: 
		<Hashmap> - returns current node being processed
	-----------------------------------------------------------------------------*/
	["currentNode",nil],
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
		private _status = "FAILURE";
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
	Property: Doctrine
    
    	--- Prototype --- 
    	get "Doctrine"
    	---
    
    Returns: 
		<HashmapObject> - A <HashmapObject> of heuristical values to apply to the graph
	-----------------------------------------------------------------------------*/
	["Doctrine",nil],
	/*----------------------------------------------------------------------------
	Property: Path
    
    	--- Prototype --- 
    	get "Path"
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Returns: 
		<Array> - of Node keys from start to goal
	-----------------------------------------------------------------------------*/
	["Path",[]],
	/*----------------------------------------------------------------------------
	Property: Status
    
    	--- Prototype --- 
    	get "Status"
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Returns: 
		<String> - the current status of the search. 

		Will be one of:
		
			- INITIALIZED
			- RUNNING
			- SUCCESS
			- FAILURE 
	-----------------------------------------------------------------------------*/
	["Status",nil],
	/*----------------------------------------------------------------------------
	Method: AdjustEstimatedDistance
    
    	--- Prototype --- 
    	call ["AdjustEstimatedDistance",[_estDist,_fromNode,_toNode]]
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Optionals: 
		_estDist - <Number> 
		_fromNode - <HashmapObject>
		_toNode - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["AdjustEstimatedDistance",compileFinal {
		params ["_estDist","_fromNode","_toNode"];
		_estDist;
	}],
	/*----------------------------------------------------------------------------
	Method: AdjustMoveCost
    
    	--- Prototype --- 
    	call ["AdjustMoveCost",[_moveCost,_fromNode,_toNode]]
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Parameters: 
		_moveCost - <Number> 
		_fromNode - <HashmapObject>
		_toNode - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["AdjustMoveCost",compileFinal {
		params ["_moveCost","_fromNode","_toNode"];
		_moveCost;
	}],
	/*----------------------------------------------------------------------------
	Method: FilterNeighbors
    
    	--- Prototype --- 
    	call ["FilterNeighbors",[_neighbors]]
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Optionals: 
		_neighbors - <Array> 
	-----------------------------------------------------------------------------*/
	["FilterNeighbors",compileFinal {
		params ["_neighbors"];
		_neighbors;
	}],
	/*----------------------------------------------------------------------------
	Method: Init
    
    	--- Prototype --- 
    	call ["Init"]
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Calls the initialization of the associated graph with the start and end keys.
	Can be used to reset pathfinding also.
	-----------------------------------------------------------------------------*/
	["Init",compileFinal {
		private _graph = _self get "_workingGraph";
		_self set ["StartNode",_graph call ["GetNodeAt",[_self get "_workingStartKey"]]];
		_self set ["EndNode",_graph call ["GetNodeAt",[_self get "_workingEndKey"]]];
		_self set ["frontier",[[0,_self get "StartNode"]]];
		_self set ["costSoFar",createhashmap];
		_self get "costSoFar" set [_self get "StartNode" get "Index",0];
		_self set ["cameFrom",createhashmap];
		_self set ["Path",[]];
		_self set ["Status","INITIALIZED"];
	}],
	/*----------------------------------------------------------------------------
	Method: ProcessNextNode
    
    	--- Prototype --- 
    	call ["ProcessNextNode"]
    	---
		
		<XPS_ifc_IAstarSearch>
    
    Causes the AstarSearch object to process the next node in frontier queue and place
	it on to the working graph.
	-----------------------------------------------------------------------------*/
	["ProcessNextNode",compileFinal {
		private _graph = _self get "_workingGraph";
		private _endNode = _self get "EndNode";
		private _currentNode = _self call ["frontierPullLowest"];
		_self set ["currentNode",_currentNode];
		if (isNil "_currentNode" || (_endNode get "Index") isEqualTo (_currentNode get "Index")) exitwith {
			_self call ["getPath"];
		};
		private _prevNode = _self get "cameFrom" get (_currentNode get "Index");

		private _neighbors = _graph call ["GetNeighbors",[_currentNode,_prevNode]];
		_self call ["FilterNeighbors",[_neighbors]];

		{
			private _costSoFarMap = _self get "costSoFar";
			private _estDist = _self call ["AdjustEstimatedDistance",[_graph call ["GetEstimatedDistance",[_x,_endNode]],_x,_endNode]];
			private _moveCost = _self call ["AdjustMoveCost",[_graph call ["GetMoveCost",[_currentNode,_x]],_currentNode,_x]];
			private _costSofar = (_costSoFarMap get (_currentNode get "Index")) + _moveCost;
			private _priority = _costSoFar + _estDist;
			//diag_log [_x get "Index",_estDist,_costSoFar,_priority];
			private _costSoFarX = _costSoFarMap get (_x get "Index");

			if (isNil {_costSoFarX} || {_costSoFar < _costSoFarX}) then {
				_costSoFarMap set [_x get "Index", _costSoFar];
				_self call ["frontierAdd",[_priority,_x]];
				_self get "cameFrom" set [_x get "Index", _currentNode];
			};

		} foreach _neighbors;

		_self set ["lastNode",_currentNode];
		if !(_self get "Status" == "RUNNING") then {_self set ["Status","RUNNING"]};
	}]
]