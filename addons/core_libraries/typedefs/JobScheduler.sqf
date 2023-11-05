#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_JobScheduler
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A collection of items that are processed in order received

Parent:
	<XPS_typ_HashmapCollection>

Implements: 
	<XPS_ifc_IJobScheduler>

Flags: 
	none

---------------------------------------------------------------------------- */
[
	["#str",compileFinal {_self get "#type"}],
	["#type","XPS_typ_JobScheduler"],
	["#base",XPS_typ_HashmapCollection],
	["@interfaces",["XPS_ifc_IJobScheduler"]],
	["_handle",nil],
	/*----------------------------------------------------------------------------
	Protected: popQueue
    
    	--- Prototype --- 
    	call ["popQueue"]
    	---

    Returns: 
		Nothing 
	-----------------------------------------------------------------------------*/
	["popQueue",compileFinal {
		private _queue = _self get "Queue";
		if (count _queue > 0) then {
			private _next = _queue deleteAt 0;
			_self set ["CurrentItem",_next#1];
			_self set ["CurrentUID",_next#0];
		} else {
			_self set ["CurrentItem",nil];
			_self set ["CurrentUID",nil];
		};
	}],
	/*----------------------------------------------------------------------------
    Property: AllowedTypes
		<XPS_typ_Hashmapcollection.AllowedTypes>

    Property: Items
		<XPS_typ_Hashmapcollection.Items>

	-------------------------------------------------------------------------------
	Property: CurrentItem
    
    	--- Prototype --- 
    	get "CurrentItem"
    	---

        <XPS_ifc_IJobScheduler>
    
    Returns: 
		<Hashmap> or <HashmapObject> - The item currently being processed
	-----------------------------------------------------------------------------*/
	["CurrentItem",nil],
	/*----------------------------------------------------------------------------
	Property: CurrentUID
    
    	--- Prototype --- 
    	get "CurrentUID"
    	---
    
    Returns: 
		<String> - The key of the item currently being processed
	-----------------------------------------------------------------------------*/
	["CurrentUID",""],
	/*----------------------------------------------------------------------------
	Property: ProcessesPerFrame
    
    	--- Prototype --- 
    	get "ProcessesPerFrame"
    	---

        <XPS_ifc_IJobScheduler>
    
    Returns: 
		<Number> - Number of times <ProcessCurrent> is called per frame
	-----------------------------------------------------------------------------*/
	["ProcessesPerFrame",1],
	/*----------------------------------------------------------------------------
	Property: Queue
    
    	--- Prototype --- 
    	get "Queue"
    	---

        <XPS_ifc_IJobScheduler>
    
    Returns: 
		<Array> - an ordered array of items to process
	-----------------------------------------------------------------------------*/
	["Queue",[]],
	/* -----------------------------------------------------------------------
    Constructor: #create

        ---prototype
        _myobj = createhashmapobject ["XPS_typ_JobScheduler",[_allowedTtypes]];
        ---

		<XPS_typ_HashmapCollection.#create>
    -------------------------------------------------------------------------*/ 
    /* -----------------------------------------------------------------------
    Method: AddItem

        ---prototype
        call ["AddItem",[_item]];
        ---

		overrides <XPS_typ_Hashmapcollection.AddItem>
    
    Parameters: 
        _item - <HashmapObject> - to add to <Items> store

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(params [["_item",nil,[createhashmap]]]) exitwith {false;};
        private _uid = [] call XPS_fnc_createUniqueID;
        if (_self call ["XPS_typ_HashmapCollection.AddItem",[_uid,_item]]) exitwith {
			(_self get "Queue") pushback [_uid,_item];
			true;
		};
		false;
    }],
	/*----------------------------------------------------------------------------
	Method: FinalizeCurrent
    
    	--- Prototype --- 
    	call ["FinalizeCurrent"]
    	---

        <XPS_ifc_IJobScheduler>
    
	-----------------------------------------------------------------------------*/
	["FinalizeCurrent",compilefinal {
		private _current = _self get "CurrentUID";
		(_self get "Items") deleteAt _current;
		_self call ["popQueue"];
	}],
	/*----------------------------------------------------------------------------
	Method: ProcessCurrent
    
    	--- Prototype --- 
    	call ["ProcessCurrent"]
    	---

        <XPS_ifc_IJobScheduler>

    Must be Overridden by child type. This method simply pops the top item in the queue
	to <CurrentItem>. Your child type should can call this method. Example override:

	---code
	["ProcessCurrent",compileFinal {
		// uses base object method to pop queue to CurrentItem
		_self call ["XPS_typ_JobScheduler.ProcessCurrent"];

		//Process the CurrentItem
		private _current = _self get "CurrentItem";
		if !(isNil {_current}) then {
			// do stuff.... 
		};
	}]
	---
	-----------------------------------------------------------------------------*/
	["ProcessCurrent",compileFinal {
		if (isNil {_self get "CurrentItem"}) then {
			_self call ["popQueue"];
		};
	}],
    /* -----------------------------------------------------------------------
    Method: RegisterType
		<XPS_typ_Hashmapcollection.RegisterType>

    -------------------------------------------------------------------------*/ 
    /* -----------------------------------------------------------------------
    Method: RemoveItem
		<XPS_typ_Hashmapcollection.RemoveItem>

    -------------------------------------------------------------------------*/ 
	
	/*----------------------------------------------------------------------------
	Method: Start
    
    	--- Prototype --- 
    	call ["Start"]
    	---

        <XPS_ifc_IJobScheduler>

		Starts processing queued items. Number of items processed per frame is set
		by <ProcessesPerFrame>
	-----------------------------------------------------------------------------*/
	["Start",compileFinal {
		private _handle = _self get "_handle";
		if (isNil "_handle") then {
			_handle = addMissionEventHandler ["EachFrame",compileFinal { 
				private _count = _thisArgs#1;
				private _limit = _thisArgs#0 get "ProcessesPerFrame";
				while {_count < _limit} do {
					_thisArgs#0 call ["ProcessCurrent"]; 
					_count = _count + 1;
				};
			}, [_self,0]];
			_self set ["_handle",_handle];
		} else {_self call ["Stop"]; _self call ["Start"];};
	}],
	/*----------------------------------------------------------------------------
	Method: Stop
    
    	--- Prototype --- 
    	call ["Stop"]
    	---

        <XPS_ifc_IJobScheduler>

		Stops processing queue
	-----------------------------------------------------------------------------*/
	["Stop",compileFinal {
		private _hndl = _self get "_handle";
		if !(isNil "_hndl") then {
			removeMissionEventHandler ["EachFrame",_handle];
			_self set ["_handle",nil];
		};
	}]
]