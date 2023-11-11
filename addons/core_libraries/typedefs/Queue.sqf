#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Queue
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	A First In First Out (FIFO) collection. 

Parent:
    none

Implements:
    <XPS_ifc_IOrderedCollection>
    <XPS_typ_IQueue>

Flags:
	none

---------------------------------------------------------------------------- */
[
	["#str", {_self get "#type" select  0}],
	["#type", "XPS_typ_Queue"],
    ["@interfaces", ["XPS_ifc_IQueue","XPS_ifc_IOrderedCollection"]],
	["_queueArray",[],[["CTOR"]]],
    /*----------------------------------------------------------------------------
    Method: Clear
    
        --- Prototype --- 
        call ["Clear"]
        ---

        <XPS_ifc_IOrderedCollection>
    
    Parameters: 
		none
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Clear",{
		_self get "_queueArray" resize 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Count
    
        --- Prototype --- 
        call ["Count"]
        ---

        <XPS_ifc_IOrderedCollection>
    
    Parameters: 
		none
		
	Returns:
		<Number> - the number of elements in the stack
    ----------------------------------------------------------------------------*/
	["Count",{
		count (_self get "_queueArray");
	}],
    /*----------------------------------------------------------------------------
    Method: IsEmpty
    
        --- Prototype --- 
        call ["IsEmpty"]
        ---

        <XPS_ifc_IOrderedCollection>
    
    Parameters: 
		none
		
	Returns:
		<Boolean> - True if queue is empty, otherwise False.
    ----------------------------------------------------------------------------*/
	["IsEmpty",{
		count (_self get "_queueArray") == 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Peek
    
        --- Prototype --- 
        call ["Peek"]
        ---

        <XPS_ifc_IQueue>
    
    Parameters: 
		none
		
	Returns:
		Anything - first element in the queue or nil if empty - does not remove 
		from queue
    ----------------------------------------------------------------------------*/
	["Peek",{
		_self get "_queueArray" select 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Pop
    
        --- Prototype --- 
        call ["Pop"]
        ---

        <XPS_ifc_IStack>
    
    Parameters: 
		none
		
	Returns:
		Anything - removes and returns last element in the queue or nil if empty
    ----------------------------------------------------------------------------*/
	["Dequeue",{
		_self get "_queueArray" deleteat 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Push
    
        --- Prototype --- 
        call ["Push",_value]
        ---

        <XPS_ifc_IStack>
    
    Parameters: 
		_value - the value to push to top of the queue
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Enqueue",{
		params ["_value"];
		_self get "_queueArray" pushback _value;
	}]
]