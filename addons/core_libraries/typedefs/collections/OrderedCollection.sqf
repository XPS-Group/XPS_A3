#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_OrderedCollection
	<TypeDefinition>
        --- prototype
        XPS_typ_OrderedCollection : XPS_ifc_ICollection
        ---
        --- prototype
        createhashmapobject [XPS_typ_OrderedCollection]
        ---

Authors: 
	Crashdome
   
Description:
	A collection which is ordered by a numerical index.  

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_OrderedCollection"],
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
		"XPS_typ_OrderedCollection"
		---
	----------------------------------------------------------------------------*/
	["#str", {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_ICollection>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_ICollection"]],
	["_listArray",[],[["CTOR"]]],
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
	["Count",{
		count (_self get "_listArray");
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
		<Boolean> - True if queue is empty, otherwise False.
    ----------------------------------------------------------------------------*/
	["IsEmpty",{
		count (_self get "_listArray") == 0;
	}],
    /*----------------------------------------------------------------------------
    Method: AddItem
    
        --- Prototype --- 
        call ["AddItem",[_index,_item]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _item - Anything - except nil

    Returns:
        True - the item is successfully added to end of list

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        if !(params [["_item",nil,[]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"AddItem",nil,_this]];};
        (_self get "_listArray") pushback _item;
        true;
    }],
    /*----------------------------------------------------------------------------
    Method: RemoveItem
    
        --- Prototype --- 
        call ["RemoveItem",[_index]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _index - <Scalar> - Index of item to remove 

    Returns:
        Anything - the item removed or nil if not found

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        if !(params [["_index",nil,[""]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"RemoveItem",nil,_this]];};
        _self get "_listArray" deleteAt _index;
    }],
    /*----------------------------------------------------------------------------
    Method: GetItem
    
        --- Prototype --- 
        call ["GetItem",[_index]]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		_index - Must be a non-negative number and must not exceed index of last item
		
	Returns:
		Anything - N'th element in the list or nil if empty - does not remove 
		from list
    ----------------------------------------------------------------------------*/
	["GetItem",{
		params [["_index",0,[0]]];
		if (_index < 0 || {_index >= _self call ["Count"]}) then { throw createhashmapobject [XPS_typ_ArgumentOutOfRangeException,[_self,"GetItem",nil,_this]]};

        if !(_self call ["IsEmpty"]) then {
		    _self get "_listArray" select _index;
        } else {nil};
	}],
    /* -----------------------------------------------------------------------
    Method: GetItems

        ---prototype
        call ["GetItems"];
        ---

        <XPS_ifc_ICollection>

    Returns:
        <Array> - A deep copy of the item store in an array

    -------------------------------------------------------------------------*/ 
    ["GetItems",{
        +(_self get "_listArray");
    }]
]