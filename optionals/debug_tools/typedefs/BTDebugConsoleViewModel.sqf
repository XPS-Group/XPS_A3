/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_DT_typ_BTDebugConsoleViewModel
	<TypeDefinition>
	---prototype
	XPS_DT_typ_BTDebugConsoleViewModel
	---
	---prototype
	createHashmapObject [XPS_DT_typ_BTDebugConsoleViewModel, []]
	---

Authors: 
	Crashdome

Description:
	Represents the model of data shown in the Unit BTDebug Console

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_DT_typ_BTDebugConsoleViewModel"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create"]
    	---
	
	Additionally creates a BTDebug Service and attaches the <onItemAddedService>
	methods to the appropriate BTDebug Service Events
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self set ["_nodes",createHashmap];
		_self set ["_activeNodes",[]];
		
		_self set ["_onItemAdded",createHashmapObject [XPS_typ_Event]];
		_self set ["ItemAdded",createHashmapObject [XPS_typ_EventHandler,[_self get "_onItemAdded"]]];

		_self set ["_onItemChanged",createHashmapObject [XPS_typ_Event]];
		_self set ["ItemChanged",createHashmapObject [XPS_typ_EventHandler,[_self get "_onItemChanged"]]];

		private _service = createHashmapObject [XPS_DT_typ_BTDebugService];
		_Self set ["_btDebugService",_service];
		_service get "NodeAdded" call ["Subscribe",[_self,"onNodeAddedService"]];
		_service get "NodeChanged" call ["Subscribe",[_self,"onNodeChangedService"]];
		
		// _self set ["StateChanged",_service get "StateChanged"];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_DT_typ_BTDebugConsoleViewModel"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	["_nodes",nil],
	["_activeNodes",nil],
	["_btDebugService",nil],
	["_onItemAdded",nil],
	["_onItemChanged",nil],
	/*----------------------------------------------------------------------------
	Protected: onNodeAddedService
    
    	--- Prototype --- 
    	call ["onNodeAddedService",[_sender,[_node,[_method,_item]]]
    	---
    
	Invokes an UpdateUnitBTDebug event

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_method - <String> - the method that originally called the evnt (AddItem,RemoveItem,Setitem,UpdateItem)
		_classID - <String> - identifier of the BTDebug Class (typically: ["Description","Method"]) 
		_item - <XPS_DT_typ_UnitBTDebug> - the actual UnitBTDebug hashmapobject that was added, removed, or changed 
	-----------------------------------------------------------------------------*/
	["onNodeAddedService", compileFinal {
		params ["_sender","_args"];
		_args params ["_node","_parentID"];
		
		private _parentPath = [];
		if !(isNil "_parentID") then {_parentPath = _self get "_nodes" get _parentID get "path"};
		private _name = (_node get "#type")#0;
		private _index = _name find  "typ_";
		if (_index > -1) then {_name = _name select [_index+4]};
		private _nodeMap = ["id", "name", "type", "status", "path", "active", "tooltip"] createhashmapfromarray [
			_node get "id",
			_name,
			_node get "NodeType",
			_node call ["Status"],	
			_parentPath,
			false,
			(_node get "#type")#0
		];
		
		_self get "_nodes" set [_node get "id",_nodeMap];
		_self get "_onItemAdded" call ["Invoke",[_self,[_nodeMap,_parentPath]]];

	}],
	["onNodeChangedService", compileFinal {
		params ["_sender","_args"];
		_args params ["_node","_data"];
		_data params ["_event","_eventargs"];
		
		private _nodeMap = _self get "_nodes" get (_node get "id");
		switch (_event) do {
			case "StatusChanged" : {_nodeMap set ["status", _eventargs];_nodeMap set ["active", _eventArgs in [XPS_Status_Running]]};
			case "PreTicked" : {_nodeMap set ["active", true]};
			case "PostTicked" : {_nodeMap set ["active", _node call ["Status",[]] in [XPS_Status_Running]]};
		};
		
		_self get "_onItemChanged" call ["Invoke",[_self,[_nodeMap,_event,_eventargs]]];

	}],
	/*----------------------------------------------------------------------------
	Method: LoadBTDebugs
    
    	--- Prototype --- 
    	call ["LoadBTDebugs"]
    	---

		Calls the test service to request all BTDebug Classes be (re)loaded into the BTDebug Service with defaults

	-----------------------------------------------------------------------------*/
	["Load", compileFinal {_self get "_btDebugService" call ["Load"]}],
	/*----------------------------------------------------------------------------
	Method: Close
    
    	--- Prototype --- 
    	call ["Close"]
    	---

		Disconnects any Event Handlers and references to a test service

	-----------------------------------------------------------------------------*/
	["Close", compileFinal {
		_self get "_btDebugService" get "NodeAdded" call ["Unsubscribe",[_self,"onNodeAddedService"]];
		_self get "_btDebugService" get "NodeChanged" call ["Unsubscribe",[_self,"onNodeChangedService"]];
		_self set ["_nodes",nil];
		_self set ["_btDebugService",nil];
		_self set ["_onItemAdded",nil];
		_self set ["_onItemChanged",nil];
	}],
	/*----------------------------------------------------------------------------
	EventHandler: StateChanged
    
    	--- Prototype --- 
    	get "StateChanged"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	// ["StateChanged",nil],
	/*----------------------------------------------------------------------------
	EventHandler: ItemAdded
    
    	--- Prototype --- 
    	get "ItemAdded"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["ItemAdded",nil],
	/*----------------------------------------------------------------------------
	EventHandler: ItemChanged
    
    	--- Prototype --- 
    	get "ItemChanged"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["ItemChanged",nil]
]
