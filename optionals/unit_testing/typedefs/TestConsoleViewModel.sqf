/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestConsoleViewModel
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestConsoleViewModel
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestConsoleViewModel, []]
	---

Authors: 
	Crashdome

Description:
	Represents the model of data shown in the Unit Test Console

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestConsoleViewModel"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create"]
    	---
	
	Additionally creates a Test Service and attaches the <onTestServiceCollectionChanged>
	methods to the appropriate Test Service Events
	-----------------------------------------------------------------------------*/
	["#create",{
		_self set ["_testCollection",createhashmapobject [XPS_typ_OrderedCollection]];
		
		_self set ["_onUpdateUnitTest",createhashmapobject [XPS_typ_Event]];
		_self set ["UpdateUnitTest",createhashmapobject [XPS_typ_EventHandler,[_self get "_onUpdateUnitTest"]]];

		private _service = createhashmapobject [XPS_UT_typ_TestService];
		_Self set ["_testService",_service];
		_service get "CollectionChanged" call ["Add",[_self,"onTestServiceCollectionChanged"]];
		
		_self set ["StateChanged",_service get "StateChanged"];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestConsoleViewModel"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	["_testCollection",nil],
	["_testService",nil],
	["_onUpdateUnitTest",nil],
	/*----------------------------------------------------------------------------
	Protected: onTestServiceCollectionChanged
    
    	--- Prototype --- 
    	call ["onTestServiceCollectionChanged",[_sender,[_method,[_classID, _item]]]]
    	---
    
	Invokes an UpdateUnitTest event

	Parameters:
		_sender - <Anything> - the function or hashmapobject that raised the event
		_method - <String> - the method that originally called the evnt (AddItem,RemoveItem,Setitem,UpdateItem)
		_classID - <String> - identifier of the Test Class (typically: ["Description","Method"]) 
		_item - <XPS_UT_typ_UnitTest> - the actual UnitTest hashmapobject that was added, removed, or changed 
	-----------------------------------------------------------------------------*/
	["onTestServiceCollectionChanged", compileFinal {
		params ["_sender","_args"];
		_args params ["_method","_args2"];
		_args2 params ["_classID","_item"];
		
		private _index = _self get "_testCollection" call ["FindItem",_classID];
		private _eventType = "";
		switch (_method) do {
			case "AddItem" : {
				_index = _self get "_testCollection" call ["AddItem",_classID];
				_eventType = "Added";
			};
			case "RemoveItem" : {
				_self get "_testCollection" call ["RemoveItem",_index];
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
	/*----------------------------------------------------------------------------
	Method: AddToSelected
    
    	--- Prototype --- 
    	call ["AddToSelected", _index]
    	---

		Calls the test service to request a unit test be "selected"
    
    Parameters: 
		_index - <Number> - the index of the item to "select"
	-----------------------------------------------------------------------------*/
	["AddToSelected", compileFinal {
		if (_this < 0) exitwith {};
		private _classID = _self get "_testCollection" call ["GetItem",_this];
		_self get "_testService" call ["AddToSelected",_classID];
	}],
	/*----------------------------------------------------------------------------
	Method: RemoveFromSelected
    
    	--- Prototype --- 
    	call ["RemoveFromSelected", _index]
    	---

		Calls the test service to request a unit test be "unselected"
    
    Parameters: 
		_index - <Number> - the index of the item to "unselect"
	-----------------------------------------------------------------------------*/
	["RemoveFromSelected", compileFinal {
		if (_this < 0) exitwith {};
		private _classID = _self get "_testCollection" call ["GetItem",_this];
		_self get "_testService" call ["RemoveFromSelected",_classID];
	}],
	/*----------------------------------------------------------------------------
	Method: LoadTests
    
    	--- Prototype --- 
    	call ["LoadTests"]
    	---

		Calls the test service to request all Test Classes be (re)loaded into the Test Service with defaults

	-----------------------------------------------------------------------------*/
	["LoadTests", compileFinal {_self get "_testService" call ["LoadTests"]}],
	/*----------------------------------------------------------------------------
	Method: Close
    
    	--- Prototype --- 
    	call ["Close"]
    	---

		Disconnects any Event Handlers and references to a test service

	-----------------------------------------------------------------------------*/
	["Close", compileFinal {
		_self get "_testService" get "CollectionChanged" call ["Remove",[_self,"onTestServiceCollectionChanged"]];
		_self set ["StateChanged",nil];
		_self set ["_testCollection",nil];
		_self set ["_testService",nil];
		_self set ["_onUpdateUnitTest",nil];
	}],
	/*----------------------------------------------------------------------------
	Method: RunAll
    
    	--- Prototype --- 
    	call ["RunAll"]
    	---

		Calls the test service to request running all Unit Tests 

	-----------------------------------------------------------------------------*/
	["RunAll", compileFinal {
		_self get "_testService" call ["RunAll"];
	}],
	/*----------------------------------------------------------------------------
	Method: RunSelected
    
    	--- Prototype --- 
    	call ["RunSelected"]
    	---

		Calls the test service to request running only the Unit Tests which are selected

	-----------------------------------------------------------------------------*/
	["RunSelected", compileFinal {
		_self get "_testService" call ["RunSelected"];
	}],
	/*----------------------------------------------------------------------------
	Method: Reset
    
    	--- Prototype --- 
    	call ["Reset"]
    	---

		Calls the test service to request all Unit Tests be reset to Non-Running state

	-----------------------------------------------------------------------------*/
	["Reset", compileFinal {
		_self get "_testService" call ["Reset"];
	}],
	/*----------------------------------------------------------------------------
	Method: Reload
    
    	--- Prototype --- 
    	call ["Reload"]
    	---

		Calls the test service to request everything be cleared and reloaded at default state

	-----------------------------------------------------------------------------*/
	["Reload", compileFinal {
		_self get "_testService" call ["Reload"];
	}],
	/*----------------------------------------------------------------------------
	Method: GetDetails
    
    	--- Prototype --- 
    	call ["GetDetails", _index]
    	---

		Calls the test service to request a Unit Test's Details Property
    
    Parameters: 
		_index - <Number> - the index of the item 

	-----------------------------------------------------------------------------*/
	["GetDetails", compileFinal {
		if (_this < 0) exitwith {};
		_self get "_testService" call ["GetDetails",_self get "_testCollection" call ["GetItem",_this]];
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
	EventHandler: UpdateUnitTest
    
    	--- Prototype --- 
    	get "UpdateUnitTest"
    	---

    Returns:
        <core. XPS_typ_EventHandler>

	-----------------------------------------------------------------------------*/
	["UpdateUnitTest",nil]
]