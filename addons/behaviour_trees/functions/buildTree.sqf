#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: behaviour_tree. XPS_BT_fnc_buildTree
	
	---prototype
	_tree = [_treeDefinition] call XPS_BT_fnc_buildTree;
	---

Description:
    Builds a behaviour tree from a structured array. Array format is as follows:

	* Each Node is represented as a two element array [ "NODE_TYPE_VAR", [ ...children...] ]
		* where NODE_TYPE_VAR is a <HashmapObject> type definition encapsulated as a string
	* The children are a multidimensional array with each child as a two element array as above
	* If a node has no children, the second element of the child must be represented as an empty array
	
	For example:
	---text
		[
			"RootNode",
			[
				["ChildA",[]],
				["ChildB",
					["ChildC",[]],
					["ChildD",[]]
				],
				["ChildE",
					["ChildF",[]],
					["ChildG",
						["ChildH",[]],
						["ChildI",[]]
					]
				]
			]
		]
	---

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _treeDefinition
		<Array> - Multidimensional <array> as defined in description above  

	Return: _tree
		<HashmapObject> - A <hashmapObject> with nested children <hashmapobjects>

	Example: Simple Example
		Using the example structure in the description, it would appear like so:

		--- Code
		private _treeDef = ["RootNode",[["ChildA",[]],["ChildB",["ChildC",[]],["ChildD",[]]],["ChildE",["ChildF",[]],["ChildG",["ChildH",[]],["ChildI",[]]]]]]
		private _tree = [_treeDef] call XPS_BT_fnc_buildTree;
		---
		This results in _tree as a <hashmapobject> structured as so:

		- RootNode
			- ChildA
			- ChildB
				- ChildC
				- ChildD
			- ChildE
				- ChildF
				- ChildG
					- ChildH
					- ChildI

---------------------------------------------------------------------------- */
params [["_definition",nil,[]],["_blackboard",nil,[createhashmap]]];

private _fnc_HandleChildren = compileFinal {
	params ["_parentNode",["_children",[],[[]]]];
	
	private _nodeType = _parentNode get "NodeType";
	if (_nodeType in ["COMPOSITE","DECORATOR"]) then {
		for "_i" from 0 to (count _children)-1 do {
			private _typeDef = _children#_i#0;
			private _grandchildren = _children#_i#1;
			private _childNode = createhashmapobject [call compile _typeDef];
			_parentNode call ["AddChildNode",_childNode];
			if (count _grandchildren > 0) then {
				[_childNode, _grandChildren] call _fnc_HandleChildren;
			};
		};
	};
};

private _rootNode = createhashmapobject [call compile (_definition#0)];
_rootNode set ["Blackboard",_blackboard];
private _children = _definition#1;

[_rootNode, _children] call _fnc_HandleChildren;

_rootNode;