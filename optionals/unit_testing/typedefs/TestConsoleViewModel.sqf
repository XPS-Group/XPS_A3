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
		diag_log "Creating VM";
		_self set ["_testCollection",createhashmapobject [XPS_typ_OrderedCollection]];
		
		_self set ["_onUpdateUnitTest",createhashmapobject [XPS_typ_Event]];
		_self set ["UpdateUnitTest",createhashmapobject [XPS_typ_EventHandler,[_self get "_onUpdateUnitTest"]]];

		private _service = createhashmapobject [XPS_UT_typ_TestService];
		_Self set ["_testService",_service];
		_service get "CollectionChanged" call ["Add",[_self,"onTestServiceCollectionChanged"]];
	}],
	["#delete",{
		diag_log "Deleting VM";
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
	["_testService",nil],
	["_onUpdateUnitTest",nil],
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
	["onTestServiceCollectionChanged",{
		params ["_sender","_args"];
		_args params ["_method","_args2"];
		_args2 params ["_classID","_item"];
		
		private _index = _self get "_testCollection" call ["FindItem",[_classID]];
		private _eventType = "";
		switch (_method) do {
			case "AddItem" : {
				_index = _self get "_testCollection" call ["AddItem",[_classID]];
				_eventType = "Added";
			};
			case "RemoveItem" : {
				_self get "_testCollection" call ["RemoveItem",[_index]];
				_eventType = "Removed";
			};
			case "SetItem" : {
				_eventType = "Replaced";
			};
			case "UpdateItem" : {
				_eventType = "Updated"
			};
		};
		
		_self get "_onUpdateUnitTest" call ["Invoke",[_self,[_eventType,[_index,_item]]]];

	}],
	["AddToSelected",{
		private _classID = _self get "_testCollection" call ["GetItem",_this];
		_self get "_testService" call ["AddToSelected",_classID];
	}],
	["RemoveFromSelected",{
		private _classID = _self get "_testCollection" call ["GetItem",_this];
		_self get "_testService" call ["RemoveFromSelected",_classID];
	}],
	["LoadTests",{_self get "_testService" call ["LoadTests"]}],
	["Close",{
		_self get "_testService" get "CollectionChanged" call ["Remove",[_self,"onTestServiceCollectionChanged"]];
		_self set ["_testCollection",nil];
		_self set ["_testService",nil];
		_self set ["_onUpdateUnitTest",nil];
	}],
	["UpdateUnitTest",nil]
]