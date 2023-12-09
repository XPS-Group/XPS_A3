/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestService
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestService : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestService, []]
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
	["#type","XPS_UT_typ_TestService"],
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
		diag_log "Creating Service";
		_self set ["_testClassCollection",createhashmapobject [XPS_typ_TypeCollection,
				createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_UT_typ_TestClass"]]]]];

		_self set ["_unitTestCollection",createhashmapobject [XPS_typ_TypeCollectionN,
				createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_UT_typ_UnitTest"]]]]];
		_self set ["CollectionChanged",(_self get "_unitTestCollection") get "CollectionChanged"];

		_self set ["_onStateChanged",createhashmapobject [XPS_typ_Event]];
		_self set ["StateChanged",createhashmapobject [XPS_typ_EventHandler,[_self get "_onStateChanged"]]];
	}],
	["#delete",{
		diag_log "Deleting Test Service";
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestService"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IName>
	-----------------------------------------------------------------------------*/
	// ["@interfaces",["XPS_ADDON_ifc_IName"]],
	["_testClassCollection",nil],
	["_unitTestCollection",nil],
	["_onStateChanged",nil],
	/*----------------------------------------------------------------------------
	Protected: myProp
    
    	--- Prototype --- 
    	get "myProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	["initTest",{
		params ["_class"];
		_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",""],["Result","Initializing"]]];
		_class call ["InitTest"];
		_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",""],["Result","Inititalized"]]];

	}],
	["runTest",{
		params ["_class","_method"];
		diag_log text str [_class get "Description",_method];
		_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",_method],["Result","Running"]]];
		private _startTime = diag_ticktime;
		try {
			_class call [_method];
			_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",_method],["Result","Passed"]]];
		} catch {
			_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",_method],["Result","Failed"]]];
			if (_exception isEqualType createhashmap && {
				count ((_exception getOrDefault ["#type",[]]) arrayIntersect ["XPS_UT_typ_AssertFailedException","XPS_UT_typ_AssertInconclusiveException"]) > 0}
			) then {
				private _details = _self get "_unitTestCollection" call ["GetItem",[[_class get "Description",_method]]] get "Details";
				_details pushback ["Exception",_exception get "#type" select 0];
				_details pushback ["Source",_exception get "Source"];
				_details pushback ["Target",_exception get "Target"];
				_details pushback ["Message",_exception get "Message"];
				_details pushback ["Data",str (_exception get "Data")];
			} else {
				throw _exception
			}
		};
		_self get "_unitTestCollection" call ["GetItem",[[_class get "Description",_method]]] get "Details" pushback ["Execution Time",str (diag_tickTime - _startTime)];
	}],
	["finalizeTest",{
		params ["_class"];
		_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",""],["Result","Finalizing"]]];
		_class call ["FinalizeTest"];
		_self get "_unitTestCollection" call ["UpdateItem",[[_class get "Description",""],["Result","Finished"]]];
	}],
	["updateItem",{
		params ["_classID","_args"];
		private _list = _self get "_unitTestCollection";
		_list call ["UpdateItem",_this];
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
	["LoadTests",{
		private _classes = _self get "_testClassCollection";
		private _unitTests = _self get "_unitTestCollection";
		private _tests = XPS_UT_TestClasses call ["GetInstance"] call ["GetClasses"];
		{
			private _class = _x;
			private _className = _x get "Description";
			_classes call ["AddItem",[_className,_class]];
			_unitTests call ["AddItem",[[_className,""],createhashmapobject [XPS_UT_typ_UnitTest,[_className,""]]]];
			{
				_unitTests call ["AddItem",[[_className,_x],createhashmapobject [XPS_UT_typ_UnitTest,[_className,_x]]]];
			} foreach (_class get "TestOrder");
		} foreach _tests;
		_self get "_onStateChanged" call ["Invoke",[_self,["Reset"]]];
	}],
	["AddToSelected",{
		_self call ["updateItem",[_this,["IsSelected",true]]];
	}],
	["RemoveFromSelected",{
		_self call ["updateItem",[_this,["IsSelected",false]]];
	}],
	["RunAll",{
		_self get "_onStateChanged" call ["Invoke",[_self,["Running"]]];
		_self spawn {
			private _service = _this;
			{
				private _class = _x;
				private _orderedList = _class get "TestOrder";
				// Init Class
				_service call ["initTest",[_class]];
				//Run Class Tests
				{
					_service call ["runTest",[_class,_x]];
				} foreach _orderedList;
				// Finalize Class
				_service call ["finalizeTest",[_class]];
			} foreach (_service get "_testClassCollection" call ["GetItems"]);
		};		
		_self get "_onStateChanged" call ["Invoke",[_self,["Finished"]]];
	}],
	["RunSelected",{}],
	["Reload",{
		_self get "_testClassCollection" call ["Clear"];
		_self get "_unitTestCollection" call ["Clear"];
		_self call ["LoadTests"];
	}],
	["Reset",{
		
		private _unitTests = _self get "_unitTestCollection"; 
		{
			_unitTests call ["UpdateItem",[[_x get "ClassName",_x get "MethodName"],["Result","Not Run"]]];
			_x get "Details" resize 0;
		} foreach (_unitTests call ["GetItems"]);
	}],
	["GetDetails",{
		+(_self get "_unitTestCollection" call ["GetItem",[_this]] get "Details");
	}],
	["StateChanged",nil],
	["CollectionChanged",nil]
]