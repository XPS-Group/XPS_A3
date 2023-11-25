/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestRunnerService
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestRunnerService : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestRunnerService, []]
	---

Authors: 
	Crashdome

Description:

    
Optionals: 
	_var1* - <Object> - (Optional - Default : objNull) 
	_var2* - <String> - (Optional - Default : "") 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestRunnerService"],
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
		_self set ["_testCollection",createhashmapobject [XPS_typ_OrderedCollection]];
		_self set ["CollectionChanged",(_self get "_testCollection") get "CollectionChanged"];
		_self call ["loadTests"];
	}],
	["#delete",{
		diag_log "Deleting Test Runner";
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestRunnerService"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IName>
	-----------------------------------------------------------------------------*/
	// ["@interfaces",["XPS_ADDON_ifc_IName"]],
	["_testCollection",nil],
	/*----------------------------------------------------------------------------
	Protected: myProp
    
    	--- Prototype --- 
    	get "myProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	["loadTests",{
		private _list = _self get "_testCollection";
		private _tests = XPS_UT_TestBuilder call ["BuildUnitTests"];
		{
			_list call ["AddItem",_x];
		} foreach _tests;
	}],
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
	["AddToSelected",{
		private _list = _self get "_testCollection";
		private _item = _list call ["GetItem",[_this]];
		_item set [1,true];
		_list call ["SetItem", [_this,_item]];
	}],
	["RemoveFromSelected",{
		private _list = _self get "_testCollection";
		private _item = _list call ["GetItem",[_this]];
		_item set [1,false];
		_list call ["SetItem", [_this,_item]];
	}],
	["RunAll",{}],
	["RunSelected".{}],
	["Reset"]
	["CollectionChanged",nil]
]