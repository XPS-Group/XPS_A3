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
        <True>
    ----------------------------------------------------------------------------*/
    ["#create",{
        _self set ["_listArray",[]];
    }],
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
	["_listArray",[]],
    /*----------------------------------------------------------------------------
    Method: Clear
    
        --- Prototype --- 
        call ["Clear"]
        ---

        <XPS_ifc_IList>

        Removes all items from collection.
    ----------------------------------------------------------------------------*/
	["Clear",{
        while {count (_self get "_listArray") > 0} do {
            _self call ["RemoveItem",[count (_self get "_listArray")-1]];
        }
	}],
    /*----------------------------------------------------------------------------
    Method: Count
    
        --- Prototype --- 
        call ["Count"]
        ---

        <XPS_ifc_IList>
		
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
		
	Returns:
		<Boolean> - <True> if queue is empty, otherwise <False>.
    ----------------------------------------------------------------------------*/
	["IsEmpty",{
		count (_self get "_listArray") == 0;
	}],
    /*----------------------------------------------------------------------------
    Method: AddItem
    
        --- Prototype --- 
        call ["AddItem",[_item]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _item - <Anything> - except nil

    Returns:
        <Scalar> - the index of the item

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        if !(params [["_item",nil,[]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"AddItem",nil,_this]];};
        (_self get "_listArray") pushback _item;
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
        <Anything> - the item removed or nil if not found

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        if !(params [["_index",nil,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"RemoveItem",nil,_this]];};
        private _item = _self get "_listArray" deleteAt _index;
    }],
    /*----------------------------------------------------------------------------
    Method: FindItem
    
        --- Prototype --- 
        call ["FindItem",[_item]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _item - <Anything> - except nil
		
	Returns:
		<Scalar> - index of item or -1 if not found
    ----------------------------------------------------------------------------*/
	["FindItem",{
		params ["_item"];
        _self get "_listArray" find _item;
	}],
    /*----------------------------------------------------------------------------
    Method: GetItem
    
        --- Prototype --- 
        call ["GetItem",[_index]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
		_index - Must be a non-negative number and must not exceed index of last item
		
	Returns:
		<Anything> - N'th element in the list or nil if empty - does not remove 
		from list

    Throws:
        <XPS_typ_ArgumentOutOfRangeException> - if index does not exist
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
    }],
    /*----------------------------------------------------------------------------
    Method: SetItem
    
        --- Prototype --- 
        call ["SetItem",[_index, _item]]
        ---

        <XPS_ifc_ICollection>

        Replaces item at specified Index.
    
    Parameters: 
		_index - Must be a non-negative number and must not exceed index of last item
        _item - <Anything> - except nil

    Returns:
        <True> - the item is successfully updated

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
        <XPS_typ_ArgumentOutOfRangeException> - if index does not exist
    ----------------------------------------------------------------------------*/
	["SetItem",{
        if !(params [["_index",nil,[0]],["_item",nil,[]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"SetItem",nil,_this]];};
		if (_index < 0 || {_index >= _self call ["Count"]}) then { throw createhashmapobject [XPS_typ_ArgumentOutOfRangeException,[_self,"SetItem",nil,_this]]};
        (_self get "_listArray") set [_index,_item];
        true;
	}],
    /*----------------------------------------------------------------------------
    Method: UpdateItem
    
        --- Prototype --- 
        call ["UpdateItem",[_index, [_key*, _value*]]]
        ---

        <XPS_ifc_ICollection>

        Updates item key/value pair at specified Index. 
        Will throw an exception if Item updated is not a <Hashmap> or <HashmapObject>. Use SetItem instead.
    
    Parameters: 
		_index - Must be a non-negative number and must not exceed index of last item
        _key - the property of the item if it is a <Hashmap> or <HashmapObject>
        _value - the value to set the property if it is a <Hashmap> or <HashmapObject>

    Returns:
        <True> - the item is successfully updated

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
        <XPS_typ_ArgumentOutOfRangeException> - if index does not exist
        <XPS_typ_InvalidArgumentException> - if index does not exist
    ----------------------------------------------------------------------------*/
	["UpdateItem",{
        if !(params [["_index",nil,[0]],["_propertyArray",nil,[[]],[2]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"UpdateItem",nil,_this]];};
		if (_index < 0 || {_index >= _self call ["Count"]}) then { throw createhashmapobject [XPS_typ_ArgumentOutOfRangeException,[_self,"UpdateItem",nil,_this]]};
        private _item = _self call ["GetItem",_index];
        if (_item isEqualType createhashmap) then {
            _propertyArray params ["_key","_value"];;
            _self get "_listArray" get _index set [_key,_value];
        } else {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"UpdateItem",nil,_this]]
        };
        true;
	}]
]