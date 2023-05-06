#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: main. XPS_typ_JobScheduler
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	A collection of items that are processed in order received

Parent:
	XPS_typ_HashmapCollection

Implements: 
	XPS_ifc_IJobScheduler

Flags: 
	none
	
-------------------------------------------------------------------------------
    Property: AllowedTypes
		<XPS_typ_Hashmapcollection.AllowedTypes>

    Property: Items
		<XPS_typ_Hashmapcollection.Items>

---------------------------------------------------------------------------- */
[
	["#str",{"XPS_typ_JobScheduler"}],
	["#parent","XPS_typ_HashmapCollection"],
	["interfaces",["XPS_ifc_JobScheduler"]],
	/*----------------------------------------------------------------------------
	Property: CurrentItem
    
    	--- Prototype --- 
    	get "CurrentItem"
    	---
    
    Returns: 
		<Hashmap> or <HashmapObject> - The item currently being processed
	-----------------------------------------------------------------------------*/
	["CurrentItem",nil],
	/*----------------------------------------------------------------------------
	Property: Queue
    
    	--- Prototype --- 
    	get "Queue"
    	---
    
    Returns: 
		<Array> - an ordered array of items to process
	-----------------------------------------------------------------------------*/
	["Queue",[]],
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
        if !(params [["_item",nil,[hashmap]]]) exitwith {false;};
        private _uid = call XPS_fnc_createUniqueID;
        if (_self call ["XPS_type_HashmapCollection.AddItem",[_uid,_item]]) exitwith {
			_self set ["Queue",(_self get "Queue") pushback _item];
			true;
		};
		false;
    }],
	/*----------------------------------------------------------------------------
	Method: FinalizeCurrent
    
    	--- Prototype --- 
    	call ["FinalizeCurrent"]
    	---
    
	-----------------------------------------------------------------------------*/
	["FinalizeCurrent",compilefinal {
		private _current = _self get "CurrentItem";
		(_self get "Items") deleteAt _current;
		private _queue = _self get "Queue";
		if (count _queue > 0) then {
			private _next = _queue deleteAt 0;
			_self set ["CurrentItem",_next];
		} else {
			_self set ["CurrentItem",nil];
		};
	}],
	/*----------------------------------------------------------------------------
	Method: ProcessCurrent
    
    	--- Prototype --- 
    	call ["ProcessCurrent"]
    	---
    
	-----------------------------------------------------------------------------*/
	["ProcessCurrent",{}]
    /* -----------------------------------------------------------------------
    Method: RegisterType
		<XPS_typ_Hashmapcollection.RegisterType>

    -------------------------------------------------------------------------*/ 
    /* -----------------------------------------------------------------------
    Method: RemoveItem
		<XPS_typ_Hashmapcollection.RemoveItem>

    -------------------------------------------------------------------------*/ 
]