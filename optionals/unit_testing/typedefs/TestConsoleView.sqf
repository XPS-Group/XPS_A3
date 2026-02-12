/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestConsoleView
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestConsoleView
	---
	---prototype
	createHashmapObject [XPS_UT_typ_TestConsoleView, [_display]]
	---

Authors: 
	Crashdome

Description:
	Handles the Dialog Display of a XPS_UT_TestConsole_display

    
Parameters: 
	_display - <Display> - The display handle this view is assigned to

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestConsoleView"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_display]]
    	---
    
		Additionally creates a ViewModel (<XPS_UT_typ_TestConsoleViewModel>) and attaches the 
		<onUpdateUnitTest> and <onTestServiceStateChanged> methods to the viewModel's 
		Event Handlers.

	Parameters: 
		_display - <Display> - The display handle this view is assigned to
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params ["_display"];
		_self set ["_displayHandle",_display];
		private _viewModel = createHashmapObject [XPS_UT_typ_TestConsoleViewModel];
		_self set ["_viewModel",_viewModel];
		_viewModel get "UpdateUnitTest" call ["Subscribe",[_self,"onUpdateUnitTest"]];
		_viewModel get "StateChanged" call ["Subscribe",[_self,"onTestServiceStateChanged"]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestConsoleView"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	["_viewModel",nil],
	["_displayName","XPS_UT_TestConsole_display"],
	["_displayHandle",displayNull],
	/*----------------------------------------------------------------------------
	Protected: clearSelected
    
    	--- Prototype --- 
    	call ["clearSelected"]
    	---
    
	Removes the highlight (selection) bar from Test Class ListNBox
	-----------------------------------------------------------------------------*/
	["clearSelected", compileFinal {
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1500;
		_listBox lnbsetcurselrow -1;
	}],
	/*----------------------------------------------------------------------------
	Protected: onTestServiceStateChanged
    
    	--- Prototype --- 
    	call ["onTestServiceStateChanged",[_sender,[_state]]]
    	---
    
	Enables/disables Button controls depending on state

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_state - <String> - the current state of the Test Service 
	-----------------------------------------------------------------------------*/
	["onTestServiceStateChanged", compileFinal {
		params ["_sender","_args"];
		_args params ["_state"];

		private _display = _self get "_displayHandle";
		switch (_state) do {
			case "Running" : {
				_display displayCtrl 1400 ctrlEnable false;
				_display displayCtrl 1401 ctrlEnable false;
				_display displayCtrl 1600 ctrlEnable false;
				_display displayCtrl 1601 ctrlEnable false;
				_display displayCtrl 1602 ctrlEnable false;
				_display displayCtrl 1603 ctrlEnable false;
			};
			case "Reset" : {
				_display displayCtrl 1400 ctrlEnable true;
				_display displayCtrl 1401 ctrlEnable true;
				_display displayCtrl 1600 ctrlEnable true;
				_display displayCtrl 1601 ctrlEnable true;
				_display displayCtrl 1602 ctrlEnable false;
				_display displayCtrl 1603 ctrlEnable true;
			};
			case "Finished" : {
				_display displayCtrl 1400 ctrlEnable true;
				_display displayCtrl 1401 ctrlEnable true;
				_display displayCtrl 1600 ctrlEnable false;
				_display displayCtrl 1601 ctrlEnable false;
				_display displayCtrl 1602 ctrlEnable true;
				_display displayCtrl 1603 ctrlEnable true;
			};
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: onUpdateUnitTest
    
    	--- Prototype --- 
    	call ["onUpdateUnitTest",[_sender,[_eventType,[_index,_data]]]]
    	---
    
	Updates Unit Test and Details ListNBoxes with data from the modified unitTest object

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_eventType - <String> - the type of event raised (Added,Removed,Replaced,Updated)
		_index - <Number> - the index of the item 
		_data - <XPS_UT_typ_UnitTest> -or- <Array> - the complete Unit Test object or the [property, value] array of the property changed
	-----------------------------------------------------------------------------*/
	["onUpdateUnitTest", compileFinal {
		params ["_sender","_args"];
		_args params ["_eventType","_args2"];
		_args2 params ["_index","_data"];
		
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1500 ;

		if (_eventType isNotEqualTo "Updated") then {
			//private _color = [[1,1,1,1],[0,0,1,0.5]] select (_data get "MethodName" == "");

			switch (_eventType) do {
				case "Added" : {
					private _id = [_data get "ClassName",_data get "MethodName"];
					private _testClass = ["",_data get "ClassName"] select (_data get "MethodName" == "");
					private _testMethod = _data get "MethodName";
					private _result = _data get "Result";
					private _isSelected = _data get "IsSelected";
					private _row = _listbox lnbAddRow [""];
					_listBox lnbSetData [[_row,0],_id];
					if (_isSelected) then {_listBox lnbSetPicture [[_row,0],"\A3\ui_f\data\GUI\RscCommon\RscCheckbox\Checkbox_checked_ca.paa"];};	
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
					private _testClass = ["",_data get "ClassName"] select (_data get "MethodName" == "");
					private _testMethod = _data get "MethodName";
					private _result = _data get "Result";
					private _isSelected = _data get "IsSelected";
					_listBox lnbSetPicture [[_index,0],["\A3\ui_f\data\GUI\RscCommon\RscCheckbox\Checkbox_unchecked_ca.paa","\A3\ui_f\data\GUI\RscCommon\RscCheckbox\Checkbox_checked_ca.paa"] select _isSelected];	
					_listBox lnbSetText [[_index,1],_testclass];
					_listBox lnbSetText [[_index,2],_testmethod];
					_listBox lnbSetText [[_index,3],_result];
				};
			};
		} else {
			_data params ["_property","_value"];
			switch (_property) do {
				case "IsSelected" : {
					_listBox lnbSetPicture [[_index,0],["\A3\ui_f\data\GUI\RscCommon\RscCheckbox\Checkbox_unchecked_ca.paa","\A3\ui_f\data\GUI\RscCommon\RscCheckbox\Checkbox_checked_ca.paa"] select _value];	
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
	Method: XPS_UT_TestConsole_display_load
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_display_load"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_display_load", compileFinal {
		_self get "_viewModel" call ["LoadTests"];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_select_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_select_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_select_buttonClick", compileFinal {
		private _row = lnbCurSelRow 1500;
		_self get "_viewModel" call ["AddToSelected",_row];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_unselect_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_unselect_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_unselect_buttonClick", compileFinal {
		private _row = lnbCurSelRow 1500;
		_self get "_viewModel" call ["RemoveFromSelected",_row];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_tests_LBSelChanged
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_tests_LBSelChanged",[_control,_lbCurSel]]
    	---
    
    Parameters: 
		_control - <Control> - The ListNBox Control 
		_lbCurSel - <Number> - Index of selected row 
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_tests_LBSelChanged", compileFinal {
		params ["_control", "_lbCurSel"];
		private _display = _self get "_displayHandle";
		private _listbox = _display displayCtrl 1501;
		if (_lbCurSel < 0) exitWith {lnbClear _listbox;};
		private _details = _self get "_viewModel" call ["GetDetails",_lbCurSel];

		lnbClear _listbox;
		{_listBox lnbAddRow [_x#0,_x#1];} forEach _details;
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_display_unLoad
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_display_unLoad"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_display_unLoad", compileFinal {
		_self set ["_displayHandle",displayNull];
		private _vm = _self get "_viewModel";
		_self set ["_viewModel",nil];
		_vm get "UpdateUnitTest" call ["Unsubscribe",[_self,"onUpdateUnitTest"]];
		_vm call ["Close"];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_reset_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_reset_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_reset_buttonClick", compileFinal {
		_self call ["clearSelected"];
		_self get "_viewModel" call ["Reset"];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_reload_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_reload_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_reload_buttonClick", compileFinal {
		_self call ["clearSelected"];
		_self get "_viewModel" call ["Reload"];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_close_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_close_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_close_buttonClick", compileFinal {
		// private _display = _self get "_displayHandle";
		closeDialog 2;
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_runAll_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_runAll_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_runAll_buttonClick", compileFinal {
		_self call ["clearSelected"];
		_self get "_viewModel" call ["RunAll"];
	}],
	/*----------------------------------------------------------------------------
	Method: XPS_UT_TestConsole_runSelected_buttonClick
    
    	--- Prototype --- 
    	call ["XPS_UT_TestConsole_runSelected_buttonClick"]
    	---
    
	Called by Display Event
	-----------------------------------------------------------------------------*/
	["XPS_UT_TestConsole_runSelected_buttonClick", compileFinal {
		_self call ["clearSelected"];
		_self get "_viewModel" call ["RunSelected"];
	}]
]
