/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestConsoleController
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestConsoleController : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestConsoleController, []]
	---

Authors: 
	Crashdome

Description:
	Handles the interaction between <XPS_UT_Engine> and a <XPS_UT_typ_TestConsoleViewModel>

    
Optionals: 
	_var1* - <Object> - (Optional - Default : objNull) 
	_var2* - <String> - (Optional - Default : "") 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestConsoleController"],
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
		private _viewModelVarName = param [0,"xps_"+([12] call XPS_fnc_createUniqueID),[""]];
		_self set ["_viewModelName",_viewModelVarName];
		uiNamespace setvariable [_viewModelVarName,createhashmapobject [XPS_UT_typ_TestConsoleViewModel,[_self]]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestConsoleController"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IName>
	-----------------------------------------------------------------------------*/
	// ["@interfaces",["XPS_ADDON_ifc_IName"]],
	["_viewModelName",nil],
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
	["ShowDialog",{
		uiNamespace getvariable (_self get "_viewModelName") call ["ShowDialog"];
	}],
	["LoadTests",{
		{
			uiNamespace getvariable (_self get "_viewModelName") call ["AddTestRow",_x];
		} foreach _this;
	}]
]