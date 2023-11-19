/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestConsoleViewModel
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestConsoleViewModel : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestConsoleViewModel, []]
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
	["#type","XPS_UT_typ_TestConsoleViewModel"],
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
		True
	-----------------------------------------------------------------------------*/
	["#create",{
		params [["_myController",createhashmap,[createhashmap]]];
		_self set ["_controller",_myController];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestConsoleViewModel"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IName>
	-----------------------------------------------------------------------------*/
	// ["@interfaces",["XPS_ADDON_ifc_IName"]],
	["_controller",nil],
	["_displayName","XPS_UT_TestConsole_display"],
	["_displayHandle",displayNull],
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
	["initTests",{

	}],
	["AddTestRow",{
		params ["_selected","_class","_method","_result"];
		private _display = _self getOrDefault ["_displayHandle",displayNull];
		{
			private _row = lnbAddRow [1500,_selected select 0];
			lnbSetValue [1500,[_row,0],_select select 1];
			lnbSetData [1500,[_row,0],_select select 2];
			lnbSetText [1500,[_row,1],_class];
			lnbSetText [1500,[_row,2],_method];
			lnbSetText [1500,[_row,3],_result];
		};
	}],
	["ShowDialog",{
		private _display = _self getOrDefault ["_displayHandle",displayNull];
		if (isNull _display) then {
			private _display = createDialog [(_self get "_displayName"),true];
			_self set ["_displayHandle",_display];
			_display setVariable ["xps_viewmodel",_self];
		};
	}],
	["CloseDialog",{
		private _display = _self getOrDefault ["_displayHandle",displayNull];
		if !(isNull _display) then {
			_display setVariable ["xps_viewmodel",nil];
			_display closeDisplay 1;
			_self set ["_displayHandle",displayNull];
		};
	}]
]