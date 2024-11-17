#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Stack
	<TypeDefinition>
        --- prototype
        XPS_typ_Stack : XPS_ifc_IStack
        ---
        --- prototype
        createHashmapObject [XPS_typ_Stack]
        ---

Authors: 
	Crashdome
   
Description:
	A Last In First Out (LIFO) collection. 
    A.k.a a First In Last Out (FILO) collection.

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_Stack"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---
    
    Return:
        <True>
    ----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Stack"
		---
	----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IStack>
		<XPS_ifc_IList>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_IStack"]],
	["_stackArray",[],[["CTOR"]]],
    /*----------------------------------------------------------------------------
    Method: Clear
    
        --- Prototype --- 
        call ["Clear"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Clear", compileFinal {
		_self get "_stackArray" resize 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Count
    
        --- Prototype --- 
        call ["Count"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Number> - the number of elements in the stack
    ----------------------------------------------------------------------------*/
	["Count", compileFinal {
		count (_self get "_stackArray");
	}],
    /*----------------------------------------------------------------------------
    Method: IsEmpty
    
        --- Prototype --- 
        call ["IsEmpty"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Boolean> - <True> if stack is empty, otherwise <False>.
    ----------------------------------------------------------------------------*/
	["IsEmpty", compileFinal {
		count (_self get "_stackArray") isEqualTo 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Peek
    
        --- Prototype --- 
        call ["Peek"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Anything> - last element in the stack or nil if empty - does not remove 
		from stack
    ----------------------------------------------------------------------------*/
	["Peek", compileFinal {
        if !(_self call ["IsEmpty"]) then {
		    _self get "_stackArray" select -1;
        } else {nil};
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
	["Pop", compileFinal {
        if !(_self call ["IsEmpty"]) then {
		    private _stack = _self get "_stackArray";
            _stack deleteat (count _stack - 1);
        } else {nil};
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
		True
    ----------------------------------------------------------------------------*/
	["Push", compileFinal {
		_self get "_stackArray" pushBack _this;
        true;
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
		True if value was added, False if already exists
    ----------------------------------------------------------------------------*/
	["PushUnique", compileFinal {
		if (_self get "_queueArray" pushBackUnique _this isEqualTo -1) exitwith {false};
        true;
	}]
]