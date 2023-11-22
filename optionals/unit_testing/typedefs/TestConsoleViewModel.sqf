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
		<True>
	-----------------------------------------------------------------------------*/
	["#create",{
		_self set ["_testCollection",createhashmapobject [XPS_typ_OrderedCollection]];
		_self set ["CollectionChanged",(_self get "_testCollection") get "CollectionChanged"];
	}],
	["#delete",{
		systemchat "Deleteing VM";
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
	["_testCollection",nil],
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
	["TEST",{
		private _list = _self get "_testCollection";
		_list call ["AddItem",[["Test Class A",true,"Test Class A","","No Result"]]];
		_list call ["AddItem",[["Test Class A",true,"","1","No Result"]]];
		_list call ["AddItem",[["Test Class A",true,"","2","No Result"]]];
		_list call ["AddItem",[["Test Class B",true,"Test Class B","","No Result"]]];
		_list call ["AddItem",[["Test Class B",true,"","1","No Result"]]];
		_list call ["AddItem",[["Test Class B",true,"","2","No Result"]]];
	}],
	["AddToSelected",{
		private _list = _self get "_testCollection";
		private _item = _list call ["GetItem",[_this]];
		_item set [1,true];
		_list call ["SetItem", [_this,_item]];
		systemchat str _this;
	}],
	["RemoveFromSelected",{
		private _list = _self get "_testCollection";
		private _item = _list call ["GetItem",[_this]];
		_item set [1,false];
		_list call ["SetItem", [_this,_item]];
		systemchat str _this;
	}],
	["CollectionChanged",nil]
]