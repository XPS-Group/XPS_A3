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
    <XPS_typ_IQueue>

Flags:
	none

---------------------------------------------------------------------------- */
[
	["#str", {_self get "#type"}],
	["#type", "XPS_typ_Queue"],
	["_queueArray",[],[["CTOR"]]],
    /*----------------------------------------------------------------------------
    Method: Peek
    
        --- Prototype --- 
        call ["Peek"]
        ---

        <XPS_ifc_IQueue>
    
    Parameters: 
		none
		
	Returns:
		<Anything> - first element in the queue or nil if empty - does not remove 
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
		<Anything> - removes and returns last element in the stack or nil if empty
    ----------------------------------------------------------------------------*/
	["Pop",{
		_self get "_queueArray" deleteat -1;
	}],
    /*----------------------------------------------------------------------------
    Method: Push
    
        --- Prototype --- 
        call ["Push",_value]
        ---

        <XPS_ifc_IStack>
    
    Parameters: 
		_value - the value to push to top of the stack
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Push",{
		params ["_value"];
		_self get "_queueArray" pushback _value;
	}]
]