/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_DT_typ_BTDebugService
	<TypeDefinition>
	---prototype
	XPS_DT_typ_BTDebugService 
	---
	---prototype
	createHashmapObject [XPS_DT_typ_BTDebugService]
	---

Authors: 
	Crashdome

Description:
	The service object which handles the loading and running of the BT Debugger defined in the config file.

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_DT_typ_BTDebugService"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
        _self set ["_nodes",[]];
		// diag_log "Creating BTDebugService";
		// _self set ["_testClassCollection",createHashmapObject [XPS_typ_OrderedCollection]];

		// _self set ["_unitBTDebugCollection",createHashmapObject [XPS_typ_TypeCollectionN,
		// 		createHashmapObject [XPS_typ_HashmapObjectTypeRestrictor,["XPS_DT_typ_UnitBTDebug"]]]];
		// _self set ["CollectionChanged",(_self get "_unitBTDebugCollection") get "CollectionChanged"];

		_self set ["_onNodeChanged",createHashmapObject [XPS_typ_Event]];
		_self set ["NodeChanged",createHashmapObject [XPS_typ_EventHandler,[_self get "_onNodeChanged"]]];

		_self set ["_onNodeAdded",createHashmapObject [XPS_typ_Event]];
		_self set ["NodeAdded",createHashmapObject [XPS_typ_EventHandler,[_self get "_onNodeAdded"]]];
	}],
    ["#delete", compileFinal {
        _self call ["unsubscribeAllNodes",[]];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_DT_typ_BTDebugService"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],

	["_nodes",nil],
    ["_rootNodeID",nil],
	["_onNodeChanged",nil],
	["_onNodeAdded",nil],
    ["_addNode", compileFinal {
        params ["_node","_parentID"];
        
        _self get "_nodes" pushback [_node,_parentID];
        _self get "_onNodeAdded" call ["Invoke",[_self,[_node,_parentID]]];

        if ("child" in _node) then {
            private _child = _node getOrDefault ["child",0];
            if (_child isEqualType createhashmap) then {
                _self call ["_addNode",[_child,_node get "id"]];
            };
        };

        if ("children" in _node) then {
            private _children = _node getOrDefault ["children",0];
            if (_children isEqualType []) then {
                { _self call ["_addNode",[_x,_node get "id"]]; } foreach _children
            };
        };

    }],

    ["handleNodeEvent", compileFinal {
        _self get "_onNodeChanged" call ["Invoke",[_self, _this]];
    }],
    ["subscribeAllNodes", compileFinal {
        {
            private _node = _x#0;
            _node get "PreTicked" call ["Subscribe", [_self, "handleNodeEvent"]];
            _node get "PostTicked" call ["Subscribe", [_self, "handleNodeEvent"]];
            _node get "StatusChanged" call ["Subscribe", [_self, "handleNodeEvent"]];
        } foreach (_self get "_nodes");
    }],
    ["unsubscribeAllNodes", compileFinal {
        {
            private _node = _x#0;
            _node get "PreTicked" call ["Unsubscribe", [_self, "handleNodeEvent"]];
            _node get "PostTicked" call ["Unsubscribe", [_self, "handleNodeEvent"]];
            _node get "StatusChanged" call ["Unsubscribe", [_self, "handleNodeEvent"]];
        } foreach (_self get "_nodes");
    }],
	/*----------------------------------------------------------------------------
	Protected: SetTree
    
    	--- Prototype --- 
    	call ["SetTree",_tree]
    	---
    
    Parameters: 
		_tree - <XPS_BT_typ_Node> - root node of tree to attach 
	-----------------------------------------------------------------------------*/
	["SetTree", compileFinal {
		params ["_btree"];
        _self call ["unsubscribeAllNodes",[]];
        private _newNodes = [];
        _self set ["_nodes",_newNodes];
        _self set ["_rootNodeID", _bTree get "id"];
        _self call ["_addNode", [_bTree]];
        _self call ["subscribeAllNodes",[]];
	}],
	/*----------------------------------------------------------------------------
	Method: Load
    
    	--- Prototype --- 
    	call ["LoadBTDebugs"]
    	---
    
	-----------------------------------------------------------------------------*/
	["Load", compileFinal {
        // {
        //     _self get "_onNodeAdded" call ["Invoke",[_self,_x]];
        // } foreach (_self get "_nodes");
        _self call ["SetTree",global_Tree];
	}],
	
	/*----------------------------------------------------------------------------
	Method: Reload
    
    	--- Prototype --- 
    	call ["Reload"]
    	---
    
	Reloads unit tests from config file
	-----------------------------------------------------------------------------*/
	// ["Reload", compileFinal {
	// 	XPS_DT_BTDebugClasses call ["GetInstance"] call ["LoadClasses"];
	// 	_self get "_testClassCollection" call ["Clear"];
	// 	_self get "_unitBTDebugCollection" call ["Clear"];
	// 	_self call ["LoadBTDebugs"];
	// 	_self get "_onStateChanged" call ["Invoke",[_self,["Reload"]]];
	// }],
	
	/*----------------------------------------------------------------------------
	Method: Reset
    
    	--- Prototype --- 
    	call ["Reset"]
    	---
    
	Resets all unit tests
	-----------------------------------------------------------------------------*/
	// ["Reset", compileFinal {		
	// 	private _unitBTDebugs = _self get "_unitBTDebugCollection"; 
	// 	{
	// 		_unitBTDebugs call ["UpdateItem",[[_x get "ClassName",_x get "MethodName"],["Result","Not Run"]]];
	// 		_x get "Details" resize 0;
	// 	} forEach (_unitBTDebugs call ["GetItems"]);
	// 	_self get "_onStateChanged" call ["Invoke",[_self,["Reset"]]];
	// }],
	
	/*----------------------------------------------------------------------------
	Method: GetDetails
    
    	--- Prototype --- 
    	call ["GetDetails",_unitBTDebug]
    	---
    
	Parameters:
		_unitBTDebug - <XPS_DT_typ_UnitBTDebug>
	-----------------------------------------------------------------------------*/
	// ["GetDetails", compileFinal {
	// 	+(_self get "_unitBTDebugCollection" call ["GetItem",_this] get "Details");
	// }],
	
	/*----------------------------------------------------------------------------
	EventHandler: NodeChanged
    
    	--- Prototype --- 
    	get "NodeChanged"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["NodeChanged",nil],
	/*----------------------------------------------------------------------------
	EventHandler: NodeAdded
    
    	--- Prototype --- 
    	get "NodeAdded"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["NodeAdded",nil]
]
