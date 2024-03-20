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
		diag_log "Creating TestService";
		_self set ["_testClassCollection",createhashmapobject [XPS_typ_OrderedCollection]];

		_self set ["_unitTestCollection",createhashmapobject [XPS_typ_TypeCollectionN,
				createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_UT_typ_UnitTest"]]]]];
		_self set ["CollectionChanged",(_self get "_unitTestCollection") get "CollectionChanged"];

		_self set ["_onStateChanged",createhashmapobject [XPS_typ_Event]];
		_self set ["StateChanged",createhashmapobject [XPS_typ_EventHandler,[_self get "_onStateChanged"]]];
	}],
	["#delete",{
		diag_log "Deleting TestService";
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
		private _className = _class get "Description";
		_self call ["updateTest",[[_className,""],["Result","Initializing"]]];
		_class call ["InitTest"];
		_self call ["updateTest",[[_className,""],["Result","Inititalized"]]];

	}],
	["runTest",{
		params ["_class","_method"];
		private _className = _class get "Description";
		diag_log text ("Testing:" + str [_className,_method]);
		_self call ["updateTest",[[_className,_method],["Result","Running"]]];
		private _startTime = diag_ticktime;
		private _result = false;
		try {
			_result = _class call [_method];
			if (isNil "_result" || {!_result}) exitwith {
				_self call ["updateTest",[[_className,_method],["Result","Failed"]]];
			};
			_self call ["updateTest",[[_className,_method],["Result","Passed"]]];
		} catch {
			_self call ["updateTest",[[_className,_method],["Result","Failed"]]];
			if (_exception isEqualType createhashmap && {
				count ((_exception getOrDefault ["#type",[]]) arrayIntersect ["XPS_UT_typ_AssertFailedException","XPS_UT_typ_AssertInconclusiveException"]) > 0}
			) then {
				private _details = _self get "_unitTestCollection" call ["GetItem",[_className,_method]] get "Details";
				_details pushback ["Exception",_exception get "#type" select 0];
				_details pushback ["Source",_exception get "Source"];
				_details pushback ["Target",_exception get "Target"];
				_details pushback ["Message",_exception get "Message"];
				_details pushback ["Data",str (_exception get "Data")];
			} else {
				throw _exception
			}
		};
		_self get "_unitTestCollection" call ["GetItem",[_className,_method]] get "Details" pushback ["Execution Time",str (diag_tickTime - _startTime)];
	}],
	["finalizeTest",{
		private _className = _class get "Description";
		params ["_class"];
		_self call ["updateTest",[[_className,""],["Result","Finalizing"]]];
		_class call ["FinalizeTest"];
		_self call ["updateTest",[[_className,""],["Result","Finished"]]];
	}],
	["updateTest",{
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
			_classes call ["AddItem",_class];
			_unitTests call ["AddItem",[[_className,""],createhashmapobject [XPS_UT_typ_UnitTest,[_className,""]]]];
			{
				_unitTests call ["AddItem",[[_className,_x],createhashmapobject [XPS_UT_typ_UnitTest,[_className,_x]]]];
			} foreach (_class get "TestOrder");
		} foreach _tests;
		_self get "_onStateChanged" call ["Invoke",[_self,["Reset"]]];
	}],
	["AddToSelected",{
		_self call ["updateTest",[_this,["IsSelected",true]]];
	}],
	["RemoveFromSelected",{
		_self call ["updateTest",[_this,["IsSelected",false]]];
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
	["RunSelected",{
		_self get "_onStateChanged" call ["Invoke",[_self,["Running"]]];
		_self spawn {
			private _service = _this;
			{
				private _class = _x;
				private _className = _class get "Description";
				if (_service get "_unitTestCollection" call ["GetItem",[_className,""]] getOrDefault ["IsSelected",false]) then {
					private _orderedList = _class get "TestOrder";
					// Init Class
					_service call ["initTest",[_class]];
					//Run Class Tests
					{
						if (_service get "_unitTestCollection" call ["GetItem",[_className,_x]] getOrDefault ["IsSelected",false]) then {
							_service call ["runTest",[_class,_x]];
						};
					} foreach _orderedList;
					// Finalize Class
					_service call ["finalizeTest",[_class]];
				};
			} foreach (_service get "_testClassCollection" call ["GetItems"]);
		};		
		_self get "_onStateChanged" call ["Invoke",[_self,["Finished"]]];
	}],
	["Reload",{
		XPS_UT_TestClasses call ["GetInstance"] call ["LoadClasses"];
		_self get "_testClassCollection" call ["Clear"];
		_self get "_unitTestCollection" call ["Clear"];
		_self call ["LoadTests"];
		_self get "_onStateChanged" call ["Invoke",[_self,["Reload"]]];
	}],
	["Reset",{		
		private _unitTests = _self get "_unitTestCollection"; 
		{
			_unitTests call ["UpdateItem",[[_x get "ClassName",_x get "MethodName"],["Result","Not Run"]]];
			_x get "Details" resize 0;
		} foreach (_unitTests call ["GetItems"]);
		_self get "_onStateChanged" call ["Invoke",[_self,["Reset"]]];
	}],
	["GetDetails",{
		+(_self get "_unitTestCollection" call ["GetItem",_this] get "Details");
	}],
	["StateChanged",nil],
	["CollectionChanged",nil]
]