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
		diag_log "Creating V";
		params ["_display"];
		_self set ["_displayHandle",_display];
		private _viewModel = createhashmapobject [XPS_UT_typ_TestConsoleViewModel];
		_self set ["_viewModel",_viewModel];
		_viewModel get "UpdateUnitTest" call ["Add",[_self,"onUpdateUnitTest"]];
		_viewModel get "StateChanged" call ["Add",[_self,"onTestServiceStateChanged"]];
	}],
	["#delete",{
		diag_log "Deleting V";
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
	["clearSelected",{
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1500;
		_listBox lnbsetcurselrow -1;
	}],
	["onTestServiceStateChanged",{
		params ["_sender","_args"];
		_args params ["_state"];

		private _display = _self get "_displayHandle";
		private _buttons = [];
		switch (_state) do {
			case "Running" : {
				_display displayCtrl 1400 ctrlEnable false;
				_display displayCtrl 1401 ctrlEnable false;
				_display displayCtrl 1600 ctrlEnable false;
				_display displayCtrl 1601 ctrlEnable false;
				_display displayCtrl 1602 ctrlEnable false;
			};
			case "Reset" : {
				_display displayCtrl 1400 ctrlEnable true;
				_display displayCtrl 1401 ctrlEnable true;
				_display displayCtrl 1600 ctrlEnable true;
				_display displayCtrl 1601 ctrlEnable true;
				_display displayCtrl 1602 ctrlEnable false;
			};
			case "Finished" : {
				_display displayCtrl 1400 ctrlEnable true;
				_display displayCtrl 1401 ctrlEnable true;
				_display displayCtrl 1600 ctrlEnable true;
				_display displayCtrl 1601 ctrlEnable true;
				_display displayCtrl 1602 ctrlEnable true;
			};
		};
	}],
	["onUpdateUnitTest",{
		params ["_sender","_args"];
		_args params ["_eventType","_args2"];
		_args2 params ["_index","_data"];
		
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1500 ;

		if (_eventType isNotEqualTo "Updated") then {
			//private _color = [[1,1,1,1],[0,0,1,0.5]] select (_data get "MethodName" isEqualTo "");

			switch (_eventType) do {
				case "Added" : {
					private _id = [_data get "ClassName",_data get "MethodName"];
					private _testClass = ["",_data get "ClassName"] select (_data get "MethodName" isEqualTo "");
					private _testMethod = _data get "MethodName";
					private _result = _data get "Result";
					private _isSelected = _data get "IsSelected";
					private _row = _listbox lnbAddRow [""];
					_listBox lnbSetData [[_row,0],_id];
					if (_isSelected) then {_listBox lnbSetPicture [[_row,0],"\A3\ui_f\data\map\groupicons\waypoint.paa"];};	
					_listBox lnbSetText [[_row,1],_testclass];
					_listBox lnbSetText [[_row,2],_testmethod];
					_listBox lnbSetText [[_row,3],_result];
					_listBox lnbSetColor [[_row,3],[0,1,1,1]];
					_listBox lnbSetText [[_row,4],""];
				};
				case "Removed" : {
					_listBox lnbDeleteRow _index;
				};
				case "Replaced" : {
					private _testClass = ["",_data get "ClassName"] select (_data get "MethodName" isEqualTo "");
					private _testMethod = _data get "MethodName";
					private _result = _data get "Result";
					private _isSelected = _data get "IsSelected";
					_listBox lnbSetPicture [[_index,0],["","\A3\ui_f\data\map\groupicons\waypoint.paa"] select _isSelected];	
					_listBox lnbSetText [[_index,1],_testclass];
					_listBox lnbSetText [[_index,2],_testmethod];
					_listBox lnbSetText [[_index,3],_result];
				};
			};
		} else {
			_data params ["_property","_value"];
			switch (_property) do {
				case "IsSelected" : {
					_listBox lnbSetPicture [[_index,0],["","\A3\ui_f\data\map\groupicons\waypoint.paa"] select _value];	
				};
				case "Result" : {
					_listBox lnbSetText [[_index,3],_value];
					switch (_value) do {
						case "Passed" : {_listBox lnbSetColor [[_index,3],[0,1,0,1]];};
						case "Failed" : {_listBox lnbSetColor [[_index,3],[1,0,0,1]];};
						default {_listBox lnbSetColor [[_index,3],[0,1,1,1]];};
					};
				};
			};

		};

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
	["XPS_UT_TestConsole_display_load",{
		_self get "_viewModel" call ["LoadTests"];
	}],
	["XPS_UT_TestConsole_select_buttonClick",{
		private _row = lnbCurSelRow 1500;
		_self get "_viewModel" call ["AddToSelected",_row];
	}],
	["XPS_UT_TestConsole_unselect_buttonClick",{
		private _row = lnbCurSelRow 1500;
		_self get "_viewModel" call ["RemoveFromSelected",_row];
	}],
	["XPS_UT_TestConsole_tests_LBSelChanged",{
		params ["_control", "_lbCurSel"];
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1501;
		if (_lbCurSel < 0) exitwith {lnbClear _listbox;};
		private _details = _self get "_viewModel" call ["GetDetails",_lbCurSel];

		lnbClear _listbox;
		{_listBox lnbAddRow [_x#0,_x#1];} foreach _details;
	}],
	["XPS_UT_TestConsole_display_unLoad",{
		_self set ["_displayHandle",displayNull];
		private _vm = _self get "_viewModel";
		_self set ["_viewModel",nil];
		_vm get "UpdateUnitTest" call ["Remove",[_self,"onUpdateUnitTest"]];
		_vm call ["Close"];
	}],
	["XPS_UT_TestConsole_reset_buttonClick",{
		_self call ["clearSelected"];
		_self get "_viewModel" call ["Reset"];
	}],
	["XPS_UT_TestConsole_reload_buttonClick",{
		_self call ["clearSelected"];
		_self get "_viewModel" call ["Reload"];
	}],
	["XPS_UT_TestConsole_runAll_buttonClick",{
		_self call ["clearSelected"];
		_self get "_viewModel" call ["RunAll"];
	}],
	["XPS_UT_TestConsole_runSelected_buttonClick",{
		_self call ["clearSelected"];
		_self get "_viewModel" call ["RunSelected"];
	}]
]