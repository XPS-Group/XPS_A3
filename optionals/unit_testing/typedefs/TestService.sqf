/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestService
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestService : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createHashmapObject [XPS_UT_typ_TestService]
	---

Authors: 
	Crashdome

Description:
	The service object which handles the loading and running of the Test Classes defined in the config file.

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestService"],
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
	["#create", compileFinal {
		// diag_log "Creating TestService";
		_self set ["_testClassCollection",createHashmapObject [XPS_typ_OrderedCollection]];

		_self set ["_unitTestCollection",createHashmapObject [XPS_typ_TypeCollectionN,
				createHashmapObject [XPS_typ_HashmapObjectTypeRestrictor,["XPS_UT_typ_UnitTest"]]]];
		_self set ["CollectionChanged",(_self get "_unitTestCollection") get "CollectionChanged"];

		_self set ["_onStateChanged",createHashmapObject [XPS_typ_Event]];
		_self set ["StateChanged",createHashmapObject [XPS_typ_EventHandler,[_self get "_onStateChanged"]]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestService"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],

	["_testClassCollection",nil],
	["_unitTestCollection",nil],
	["_onStateChanged",nil],
	/*----------------------------------------------------------------------------
	Protected: initTest
    
    	--- Prototype --- 
    	call ["initTest",[_class]]
    	---
    
    Parameters: 
		_class - <XPS_UT_typ_TestClass> 
	-----------------------------------------------------------------------------*/
	["initTest", compileFinal {
		params ["_class"];
		private _className = _class get "Description";
		_self call ["updateTest",[[_className,""],["Result","Initializing"]]];
		_class call ["InitTest"];
		_self call ["updateTest",[[_className,""],["Result","Inititalized"]]];

	}],
	/*----------------------------------------------------------------------------
	Protected: runTest
    
    	--- Prototype --- 
    	call ["runTest",[_class,_method]]
    	---
    
    Parameters: 
		_class - <XPS_UT_typ_TestClass> 
		_method - <string> - name of method on _class to run
	-----------------------------------------------------------------------------*/
	["runTest", compileFinal {
		params ["_class","_method"];
		private _className = _class get "Description";
		// diag_log text ("Testing:" + str [_className,_method]);
		_self call ["updateTest",[[_className,_method],["Result","Running"]]];
		private _startTime = diag_ticktime;
		private _result = false;
		try {
			_result = _class call [_method];
			if (isNil "_result" || {!_result}) exitWith {
				_self call ["updateTest",[[_className,_method],["Result","Failed"]]];
			};
			_self call ["updateTest",[[_className,_method],["Result","Passed"]]];
		} catch {
			_self call ["updateTest",[[_className,_method],["Result","Failed"]]];
			if (_exception isEqualType createhashmap && {
				(_exception getOrDefault ["#type",[]]) arrayIntersect ["XPS_typ_Exception"] isNotEqualTo [];}
			) then {
				private _details = _self get "_unitTestCollection" call ["GetItem",[_className,_method]] get "Details";
				_details pushBack ["Exception",_exception get "#type" select 0];
				_details pushBack ["Source",_exception get "Source"];
				_details pushBack ["Target",_exception get "Target"];
				_details pushBack ["Message",_exception get "Message"];
				_details pushBack ["Data",str (_exception get "Data")];
			} else {
				throw _exception
			}
		};
		_self get "_unitTestCollection" call ["GetItem",[_className,_method]] get "Details" pushBack ["Execution Time",str (diag_tickTime - _startTime)];
	}],
	
	/*----------------------------------------------------------------------------
	Protected: finalizeTest
    
    	--- Prototype --- 
    	call ["finalizeTest",[_class]]
    	---
    
    Parameters: 
		_class - <XPS_UT_typ_TestClass> 
	-----------------------------------------------------------------------------*/
	["finalizeTest", compileFinal {
		params ["_class"];
		private _className = _class get "Description";
		_self call ["updateTest",[[_className,""],["Result","Finalizing"]]];
		_class call ["FinalizeTest"];
		_self call ["updateTest",[[_className,""],["Result","Finished"]]];
	}],
	
	/*----------------------------------------------------------------------------
	Protected: updateTest
    
    	--- Prototype --- 
    	call ["updateTest",[[_className,_methodName],[_key,_value]]]
    	---
    
    Parameters: 
		_className - <string> - name of class
		_methodName - <string> - name of method or "" if header
		_key - <string> - the key of the <XPS_UT_typ_UnitTest> class to update
		_value - <anything> - the value to set the key to
	-----------------------------------------------------------------------------*/
	["updateTest", compileFinal {
		private _list = _self get "_unitTestCollection";
		_list call ["UpdateItem",_this];
	}],
	/*----------------------------------------------------------------------------
	Method: LoadTests
    
    	--- Prototype --- 
    	call ["LoadTests"]
    	---
    
	-----------------------------------------------------------------------------*/
	["LoadTests", compileFinal {
		private _classes = _self get "_testClassCollection";
		private _unitTests = _self get "_unitTestCollection";
		private _tests = XPS_UT_TestClasses call ["GetInstance"] call ["GetClasses"];
		{
			private _class = _x;
			private _className = _x get "Description";
			_classes call ["AddItem",_class];
			_unitTests call ["AddItem",[[_className,""],createHashmapObject [XPS_UT_typ_UnitTest,[_className,""]]]];
			{
				_unitTests call ["AddItem",[[_className,_x],createHashmapObject [XPS_UT_typ_UnitTest,[_className,_x]]]];
			} forEach (_class get "TestOrder");
		} forEach _tests;
		_self get "_onStateChanged" call ["Invoke",[_self,["Reset"]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: AddToSelected
    
    	--- Prototype --- 
    	call ["AddToSelected",[_className,_methodName]]
    	---
    
	Changes "IsSelected" to true

    Parameters: 
		_className - <string> - name of class
		_methodName - <string> - name of method or "" if header
	-----------------------------------------------------------------------------*/
	["AddToSelected", compileFinal {
		_self call ["updateTest",[_this,["IsSelected",true]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: RemoveFromSelected
    
    	--- Prototype --- 
    	call ["RemoveFromSelected",[_className,_methodName]]
    	---
    
	Changes "IsSelected" to false
	
    Parameters: 
		_className - <string> - name of class
		_methodName - <string> - name of method or "" if header
	-----------------------------------------------------------------------------*/
	["RemoveFromSelected", compileFinal {
		_self call ["updateTest",[_this,["IsSelected",false]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: RunAll
    
    	--- Prototype --- 
    	call ["RunAll"]
    	---
    
	Runs all unit tests
	-----------------------------------------------------------------------------*/
	["RunAll", compileFinal {
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
				} forEach _orderedList;
				// Finalize Class
				_service call ["finalizeTest",[_class]];
			} forEach (_service get "_testClassCollection" call ["GetItems"]);
		};		
		_self get "_onStateChanged" call ["Invoke",[_self,["Finished"]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: RunSelected
    
    	--- Prototype --- 
    	call ["RunSelected"]
    	---
    
	Runs only selected unit tests
	-----------------------------------------------------------------------------*/
	["RunSelected", compileFinal {
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
					} forEach _orderedList;
					// Finalize Class
					_service call ["finalizeTest",[_class]];
				};
			} forEach (_service get "_testClassCollection" call ["GetItems"]);
		};		
		_self get "_onStateChanged" call ["Invoke",[_self,["Finished"]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: Reload
    
    	--- Prototype --- 
    	call ["Reload"]
    	---
    
	Reloads unit tests from config file
	-----------------------------------------------------------------------------*/
	["Reload", compileFinal {
		XPS_UT_TestClasses call ["GetInstance"] call ["LoadClasses"];
		_self get "_testClassCollection" call ["Clear"];
		_self get "_unitTestCollection" call ["Clear"];
		_self call ["LoadTests"];
		_self get "_onStateChanged" call ["Invoke",[_self,["Reload"]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: Reset
    
    	--- Prototype --- 
    	call ["Reset"]
    	---
    
	Resets all unit tests
	-----------------------------------------------------------------------------*/
	["Reset", compileFinal {		
		private _unitTests = _self get "_unitTestCollection"; 
		{
			_unitTests call ["UpdateItem",[[_x get "ClassName",_x get "MethodName"],["Result","Not Run"]]];
			_x get "Details" resize 0;
		} forEach (_unitTests call ["GetItems"]);
		_self get "_onStateChanged" call ["Invoke",[_self,["Reset"]]];
	}],
	
	/*----------------------------------------------------------------------------
	Method: GetDetails
    
    	--- Prototype --- 
    	call ["GetDetails",_unitTest]
    	---
    
	Parameters:
		_unitTest - <XPS_UT_typ_UnitTest>
	-----------------------------------------------------------------------------*/
	["GetDetails", compileFinal {
		+(_self get "_unitTestCollection" call ["GetItem",_this] get "Details");
	}],
	
	/*----------------------------------------------------------------------------
	EventHandler: StateChanged
    
    	--- Prototype --- 
    	get "StateChanged"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["StateChanged",nil],
	/*----------------------------------------------------------------------------
	EventHandler: CollectionChanged
    
    	--- Prototype --- 
    	get "CollectionChanged"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["CollectionChanged",nil]
]
