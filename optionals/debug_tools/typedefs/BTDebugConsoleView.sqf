/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_DT_typ_BTDebugConsoleView
	<TypeDefinition>
	---prototype
	XPS_DT_typ_BTDebugConsoleView
	---
	---prototype
	createHashmapObject [XPS_DT_typ_BTDebugConsoleView, [_display]]
	---

Authors: 
	Crashdome

Description:
	Handles the Dialog Display of a XPS_DT_BTDebugConsole_display

    
Parameters: 
	_display - <Display> - The display handle this view is assigned to

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_DT_typ_BTDebugConsoleView"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_display]]
    	---
    
		Additionally creates a ViewModel (<XPS_DT_typ_BTDebugConsoleViewModel>) and attaches the 
		<onUpdateUnitBTDebug> and <onBTDebugServiceStateChanged> methods to the viewModel's 
		Event Handlers.

	Parameters: 
		_display - <Display> - The display handle this view is assigned to
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params ["_display"];
		_self set ["_displayHandle",_display];
		private _viewModel = createHashmapObject [XPS_DT_typ_BTDebugConsoleViewModel];
		_self set ["_viewModel",_viewModel];
		_viewModel get "ItemAdded" call ["Subscribe",[_self,"onItemAdded"]];
		_viewModel get "ItemChanged" call ["Subscribe",[_self,"onItemChanged"]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_DT_typ_BTDebugConsoleView"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	["_viewModel",nil],
	["_displayName","XPS_DT_BTDebugConsole_display"],
	["_displayHandle",displayNull],
    ["onItemAdded", {
        params ["_sender","_args"];
        _args params ["_node","_parentPath"];

        private _tv = _self get "_displayHandle" displayCtrl 1500;
        private _index = _tv tvAdd [_parentPath, _node get "name"];
        private _path = +_parentPath;
        _path pushback _index;
        _tv tvSetData [_path,_node get "id"];
		_tv tvSetPicture [_path,"\a3\3DEN\Data\Attributes\Shape\ellipse_ca.paa"];
		_tv tvSetPictureRight [_path,"\a3\3DEN\Data\Attributes\Shape\rectangle_ca.paa"];
		private _color = [1,1,1,1];
		switch (_node get "type") do {
			case XPS_BT_NodeType_Leaf : {_color = [0.5,1,0.5,1]};
			case XPS_BT_NodeType_Composite : {_color = [0.5,0.5,1,1]};
			case XPS_BT_NodeType_Decorator : {_color = [1,0.5,1,1]};
		};
		_tv tvSetColor [_path,_color];
		_tv tvSetSelectColor [_path,_color];
		_tv tvSetToolTip [_path,_node get "tooltip"];
        _node set ["path", _path];
		tvExpandAll _tv;
		_self call ["onItemChanged",_this];
    }],
    ["onItemChanged", {
        params ["_sender","_args"];
        _args params ["_node","_event","_eventargs"];
		private _path = _node get "path";
        private _tv = _self get "_displayHandle" displayCtrl 1500;
		
		private _color = [1,1,1,1];
		private _active = _node get "active";
		switch (_node get "status") do {
			case XPS_Status_Success : {_color = [0,0.5,0,1]};
			case XPS_Status_Failure : {_color = [0.5,0,0,1]};
			case XPS_Status_Running : {_color = [0.75,0.35,0,1]};
			default {_color = [0.5,0.5,0.5,1]};
		};
		_tv tvSetPictureRightColor [_path,_color];
		_tv tvSetPictureColor [_path,[[0,0,0,0],[1,1,0.5,1]]select _active];
		_tv tvSetPictureRightColorSelected [_path,_color];
		_tv tvSetPictureColorSelected [_path,[[0,0,0,0],[1,1,0.5,1]]select _active];
		//_tv tvSetSelected [_path, _active];
		tvExpandAll _tv;
    }],
    
	/*----------------------------------------------------------------------------
	Method: XPS_DT_BTDebugConsole_close_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_DT_BTDebugConsole_close_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_DT_BTDebugConsole_close_buttonClick", compileFinal {
		_self get "_viewModel" call ["Close"];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_DT_BTDebugConsole_close_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_DT_BTDebugConsole_close_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_DT_BTDebugConsole_close_buttonClick", compileFinal {
		closeDialog 2;
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_DT_BTDebugConsole_display_load
    
    	--- Prototype --- 
    	call ["XPS_DT_BTDebugConsole_display_load"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_DT_BTDebugConsole_display_load", compileFinal {
		_self get "_viewModel" call ["Load"];
		
        private _tv = _self get "_displayHandle" displayCtrl 1500;
		tvExpandAll _tv;
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_DT_BTDebugConsole_tests_LBSelChanged
    
    	--- Prototype --- 
    	call ["XPS_DT_BTDebugConsole_tests_LBSelChanged",[_control,_lbCurSel]]
    	---
    
    Parameters: 
		_control - <Control> - The ListNBox Control 
		_lbCurSel - <Number> - Index of selected row 
	-----------------------------------------------------------------------------*/
	["XPS_DT_BTDebugConsole_TreeSelChanged", compileFinal {
		params ["_control", "_lbCurSel"];
		private _display = _self get "_displayHandle";
		// private _listbox = _display displayCtrl 1501;
		// if (_lbCurSel < 0) exitWith {lnbClear _listbox;};
		// private _details = _self get "_viewModel" call ["GetDetails",_lbCurSel];

		// lnbClear _listbox;
		// {_listBox lnbAddRow [_x#0,_x#1];} forEach _details;
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_DT_BTDebugConsole_display_unLoad
    
    	--- Prototype --- 
    	call ["XPS_DT_BTDebugConsole_display_unLoad"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_DT_BTDebugConsole_display_unLoad", compileFinal {
		_self set ["_displayHandle",displayNull];
		private _vm = _self get "_viewModel";
		_self set ["_viewModel",nil];
		_vm get "ItemAdded" call ["Unsubscribe",[_self,"onItemAdded"]];
		_vm get "ItemChanged" call ["Unsubscribe",[_self,"onItemChanged"]];
		_vm call ["Close"];
	}]

]
