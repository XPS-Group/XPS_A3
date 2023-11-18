#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Stack
	<TypeDefinition>
        --- prototype
        XPS_typ_Stack : XPS_ifc_IOrderedCollection, XPS_ifc_IStack
        ---
        --- prototype
        createhashmapobject [XPS_typ_Stack]
        ---

Authors: 
	Crashdome
   
Description:
	A Last In First Out (LIFO) collection. 

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
        True
    ----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Stack"
		---
	----------------------------------------------------------------------------*/
	["#str", {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IStack>
		<XPS_ifc_IOrderedCollection>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_IStack","XPS_ifc_IOrderedCollection"]],
	["_stackArray",[],[["CTOR"]]],
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
		_self get "_stackArray" resize 0;
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
		count (_self get "_stackArray");
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
		<Boolean> - True if stack is empty, otherwise False.
    ----------------------------------------------------------------------------*/
	["IsEmpty",{
		count (_self get "_stackArray") == 0;
	}],
    /*----------------------------------------------------------------------------
    Method: Peek
    
        --- Prototype --- 
        call ["Peek"]
        ---

        <XPS_ifc_IOrderedCollection>
    
    Parameters: 
		none
		
	Returns:
		Anything - last element in the stack or nil if empty - does not remove 
		from stack
    ----------------------------------------------------------------------------*/
	["Peek",{
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
		Anything - removes and returns last element in the stack or nil if empty
    ----------------------------------------------------------------------------*/
	["Pop",{
        if !(_self call ["IsEmpty"]) then {
		    _self get "_stackArray" deleteat -1;
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
		Nothing
    ----------------------------------------------------------------------------*/
	["Push",{
		_self get "_stackArray" pushback _this;
	}]
]