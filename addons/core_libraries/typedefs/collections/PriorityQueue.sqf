#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_PriorityQueue
	<TypeDefinition>
        --- prototype
        XPS_typ_PriorityQueue : XPS_ifc_IQueue, XPS_typ_Queue
        ---
        --- prototype
        createHashmapObject [XPS_typ_PriorityQueue]
        ---

Authors: 
	Crashdome
   
Description:
	A collection sorted by priority. 

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_PriorityQueue"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_Queue>
	-----------------------------------------------------------------------------*/
    ["#base",XPS_typ_Queue],
    /*----------------------------------------------------------------------------
    Constructor: #create

        <XPS_ifc_IQueue>
        <XPS_typ_Queue.#create>
    ----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_PriorityQueue"
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		unscheduled
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IQueue>
		<XPS_ifc_IList>
	----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Clear

        <XPS_ifc_IQueue>

        <XPS_typ_Queue.Clear>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Count

        <XPS_ifc_IQueue>

        <XPS_typ_Queue.Count>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: IsEmpty

        <XPS_ifc_IQueue>

        <XPS_typ_Queue.IsEmpty>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Peek

        <XPS_ifc_IQueue>

        <XPS_typ_Queue.Peek>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Dequeue

        <XPS_ifc_IQueue>

        <XPS_typ_Queue.Dequeue>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Enqueue
    
        --- Prototype --- 
        call ["Enqueue",[_priorityValue,_item]]
        ---

        <XPS_ifc_IQueue>
    
    Parameters: 
		_priorityValue - the value which represents the position in the queue
		_item - the item to place in the queue
		
	Returns:
		True
    ----------------------------------------------------------------------------*/
	["Enqueue", compileFinal {
		params [["_priority",0,[0]],"_item"];

		private _queue = _self get "_queueArray";
		private _queueSize = count _queue;
		private _i = 0;

		while {_i <= _queueSize - 1 && { _priority > ((_queue select _i) select 0) }} do {
			_i = _i + 1;
		};

		_queue insert [_i, [[_priority, _item]] ];
        true;
	}],
    /*----------------------------------------------------------------------------
    Method: EnqueueUnique
    
        --- Prototype --- 
        call ["EnqueueUnique",[_priorityValue,_item]]
        ---

        <XPS_ifc_IQueue>
    
    Parameters: 
		_priorityValue - the value which represents the position in the queue
		_item - the item to place in the queue. 
		
	Returns:
		True if value was added, False if already exists
    ----------------------------------------------------------------------------*/
	["EnqueueUnique", compileFinal {
		params [["_priority",0,[0]],"_item"];
        private _itemList = _self get "_queueArray" apply {_x#1};
		if (_item in _itemList) exitwith {false};
        _self call ["Enqueue",_this];
	}]
]