#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_JobScheduler
	<TypeDefinition>
	---prototype
	XPS_typ_JobScheduler : XPS_ifc_ICollection, XPS_ifc_ITypeRestrictor, XPS_ifc_IJobScheduler, XPS_typ_TypeCollection
	---
	---code
	createHashmapObject [XPS_typ_JobScheduler,[_allowedTypes*]];
	---

Authors: 
	Crashdome

Description:
	A collection of items that are processed in order received

Parameters: 
    _allowedTypes* - (optional) - <Array> -of <Strings> which are <HashmapObject> '#type's

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_JobScheduler"],
    /*----------------------------------------------------------------------------
    Parent: #base
        <XPS_typ_TypeCollection>
    ----------------------------------------------------------------------------*/
	["#base",XPS_typ_TypeCollection],
	/* -----------------------------------------------------------------------
    Constructor: #create
		<XPS_typ_TypeCollection.#create>
    -------------------------------------------------------------------------*/ 
	["#create", compileFinal {
		_self call ["XPS_typ_TypeCollection.#create",_this];
		_self set ["_queueObject",createHashmapObject [XPS_typ_Queue]];
	}],
    /*----------------------------------------------------------------------------
    Parent: #str
		--- prototype
		"XPS_typ_JobScheduler"
		---
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Parent: @interfaces
        <XPS_typ_TypeCollection.@interfaces> -
		<XPS_ifc_IJobScheduler> -
    ----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IJobScheduler"]],
	["_handle",nil],
	["_queueObject",nil],
	/*----------------------------------------------------------------------------
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
    
        <XPS_ifc_IJobScheduler>

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
		<Number> - Number of times <ProcessCurrent> is called per frame. Any number less than 1
		will be the equivalent of '1' per frame.
	-----------------------------------------------------------------------------*/
	["ProcessesPerFrame",1],
	/*----------------------------------------------------------------------------
	Protected: dequeue
    
    	--- Prototype --- 
    	call ["dequeue"]
    	---

		Sets <CurrentItem> and <CurrentUID> to next in queue

    Returns: 
		Nothing 
	-----------------------------------------------------------------------------*/
	["dequeue",compileFinal {
		private _next = _self get "_queueObject" call ["Dequeue"];
		if (isNil {_next}) then {
			_self set ["CurrentItem",nil];
			_self set ["CurrentUID",nil];
		} else {
			_self set ["CurrentItem",_self call ["RemoveItem",_next]];
			_self set ["CurrentUID",_next];
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: finalizeCurrent
    
    	--- Prototype --- 
    	call ["finalizeCurrent"]
    	---
    
		calls <XPS_typ_JobScheduler.dequeue> method
	-----------------------------------------------------------------------------*/
	["finalizeCurrent",compileFinal {
		_self call ["dequeue"];
	}],
	/*----------------------------------------------------------------------------
	Protected: preprocessCurrent
    
    	--- Prototype --- 
    	call ["preprocessCurrent"]
    	---

		Sets up the Currentitem and queues up next item if the current item is empty
	-----------------------------------------------------------------------------*/
	["preprocessCurrent",compileFinal {
		if (isNil {_self get "CurrentItem"}) then {
			_self call ["dequeue"];
		};
		
		if !(isNil {_self get "CurrentItem"}) then {
			if (_self call ["processCurrent"]) then {
				_self call ["finalizeCurrent"];
			};
		};
	}],
	/*----------------------------------------------------------------------------
	Protected: processCurrent
    
    	--- Prototype --- 
    	_result = call ["processCurrent"]
    	---

    	Calls "Process" on current item which expects a true/false result. 
		
		Override this method for custom proccessing.

	Returns: 
		<Boolean> - true if should move on to next item else false (keep processing current item)
	-----------------------------------------------------------------------------*/
	["processCurrent",compileFinal {
		_self get "CurrentItem" call ["Process"];
	}],
    /* -----------------------------------------------------------------------
    Method: AddItem

        ---prototype
        call ["AddItem",_item];
        ---

        <XPS_ifc_ICollection>

		overrides <XPS_typ_TypeCollection.AddItem>
    
    Parameters: 
        _item - <HashmapObject> - to add to item store

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(_this isEqualType createhashmap) exitWith {false;};
        private _uid = [] call XPS_fnc_createUniqueID;
        if (_self call ["XPS_typ_TypeCollection.AddItem",[_uid,_item]]) exitWith {
			_self get "_queueObject" call ["Enqueue",_uid];
			true;
		};
		false;
    }],
    /* -----------------------------------------------------------------------
    Method: RegisterType

		<XPS_typ_TypeCollection.RegisterType>

        <XPS_ifc_ITypeRestrictor>

    -------------------------------------------------------------------------*/ 
    /*----------------------------------------------------------------------------
    Method: IsAllowed 

		<XPS_typ_TypeCollection.IsAllowed>

        <XPS_ifc_ITypeRestrictor>
	----------------------------------------------------------------------------*/
    /* -----------------------------------------------------------------------
    Method: RemoveItem
		<XPS_typ_TypeCollection.RemoveItem>

        <XPS_ifc_ICollection>

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
					_thisArgs#0 call ["preprocessCurrent"]; 
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
			removeMissionEventHandler ["EachFrame",_hndl];
			_self set ["_handle",nil];
		};
	}]
]
