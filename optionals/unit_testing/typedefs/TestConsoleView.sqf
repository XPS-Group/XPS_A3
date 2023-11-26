/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestConsoleView
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestConsoleView : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestConsoleView, []]
	---

Authors: 
	Crashdome

Description:
	Handles the Dialog Display of a XPS_UT_TestConsole_display

    
Optionals: 
	_var1* - <Object> - (Optional - Default : objNull) 
	_var2* - <String> - (Optional - Default : "") 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestConsoleView"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_Name>
	-----------------------------------------------------------------------------*/
	// ["#base",XPS_typ_Name],
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
	["#create",{
		params ["_display"];
		_self set ["_displayHandle",_display];
		private _viewModel = createhashmapobject [XPS_UT_typ_TestConsoleViewModel];
		_self set ["_viewModel",_viewModel];
		_viewModel get "CollectionChanged" call ["Add",[_self,"onCollectionChanged"]];
		_viewModel call ["TEST"];
	}],
	["#delete",{
		_self get "_viewModel" get "CollectionChanged" call ["Remove",[_self,"onCollectionChanged"]];
		_self set ["_viewModel",nil];
		diag_log "Deleteing V";
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestConsoleView"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IName>
	-----------------------------------------------------------------------------*/
	// ["@interfaces",["XPS_ADDON_ifc_IName"]],
	["_viewModel",nil],
	["_displayName","XPS_UT_TestConsole_display"],
	["_displayHandle",displayNull],
	["onCollectionChanged",{
		diag_log _this;
		params ["_sender","_args"];
		_args params ["_method","_index","_item"];
		_item params ["_data","_isSelected","_testclass","_testmethod","_result"];
		
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1500 ;
		switch (_method) do {
			case "AddItem" : {
				private _row = _listbox lnbAddRow [""];
				if (_isSelected) then {_listBox lnbSetPicture [[_row,0],"\A3\ui_f\data\map\groupicons\waypoint.paa"];};	
				_listBox lnbSetText [[_row,1],_testclass];
				_listBox lnbSetText [[_row,2],_testmethod];
				_listBox lnbSetText [[_row,3],_result];
			};
			case "RemoveItem" : {
				_listBox lnbDeleteRow _index;
			};
			case "SetItem" : {
				_listBox lnbSetPicture [[_index,0],["","\A3\ui_f\data\map\groupicons\waypoint.paa"] select _isSelected];	
				_listBox lnbSetText [[_index,1],_testclass];
				_listBox lnbSetText [[_index,2],_testmethod];
				_listBox lnbSetText [[_index,3],_result];
			};
		}
	}],
	/*----------------------------------------------------------------------------
	Protected: myProp
    
    	--- Prototype --- 
    	get "myProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: MyProp
    
    	--- Prototype --- 
    	get "MyProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: MyMethod
    
    	--- Prototype --- 
    	call ["MyMethod",[_object*,_var1*]]
    	---
    
    Optionals: 
		_object* - <Object> - (Optional - Default : objNull) 
		_var1* - <String> - (Optional - Default : "") 
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_select_buttonClick",{
		private _row = lnbCurSelRow 1500;
		_self get "_viewModel" call ["AddToSelected",_row];
	}],
	["XPS_UT_TestConsole_unselect_buttonClick",{
		private _row = lnbCurSelRow 1500;
		_self get "_viewModel" call ["RemoveFromSelected",_row];
	}],
	["XPS_UT_TestConsole_tests_LBSelChanged",{

	}],
	["Close",{
		private _display = _self getOrDefault ["_displayHandle",displayNull];
		if !(isNull _display) then {
			_display setVariable ["xps_view",nil];
			_display closeDisplay 1;
			_self set ["_displayHandle",displayNull];
		};
	}]
]