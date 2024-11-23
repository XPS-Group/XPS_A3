#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_OrderedCollection
	<TypeDefinition>
        --- prototype
        XPS_typ_OrderedCollection : XPS_ifc_ICollection
        ---
        --- prototype
        createHashmapObject [XPS_typ_OrderedCollection]
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
    ["#create", compileFinal {
        _self set ["_listArray",[]];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_OrderedCollection"
		---
	----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		unscheduled
	----------------------------------------------------------------------------*/
	["#flags",["sealed","unscheduled"]],
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
	["Clear", compileFinal {
        while {count (_self get "_listArray") > 0} do {
            _self call ["RemoveItem",count (_self get "_listArray")-1];
        };
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
	["Count", compileFinal {
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
	["IsEmpty", compileFinal {
		count (_self get "_listArray") isEqualTo 0;
	}],
    /*----------------------------------------------------------------------------
    Method: AddItem
    
        --- Prototype --- 
        call ["AddItem",_item]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _item - <Anything> - except nil

    Returns:
        <Number> - the index of the item

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        if (isNil "_this") exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"AddItem",nil,createHashMapFromArray [["_this",_this]]]];};
        (_self get "_listArray") pushBack _this;
    }],
    /*----------------------------------------------------------------------------
    Method: RemoveItem
    
        --- Prototype --- 
        call ["RemoveItem",_index]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _index - <Number> - Index of item to remove 

    Returns:
        <Anything> - the item removed or nil if not found

    Throws:
        <XPS_typ_InvalidArgumentException> - if parameter was nil or NaN
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        if !(_this isEqualType 0) exitWith {throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"RemoveItem",nil,createHashMapFromArray [["_this",_this]]]];};
        _self get "_listArray" deleteAt _this;
    }],
    /*----------------------------------------------------------------------------
    Method: FindItem
    
        --- Prototype --- 
        call ["FindItem",_item]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _item - <Anything> - except nil
		
	Returns:
		<Number> - index of item or -1 if not found

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["FindItem", compileFinal {
        if (isNil "_this") exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"AddItem",nil,createHashMapFromArray [["_this",_this]]]];};
        _self get "_listArray" find _this;
	}],
    /*----------------------------------------------------------------------------
    Method: GetItem
    
        --- Prototype --- 
        call ["GetItem",_index]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
		_index - can be negative (same rules as BI command 'select' for arrays)
		
	Returns:
		<Anything> - N'th element in the list or nil if empty - does not remove 
		from list

    Throws:
        <XPS_typ_InvalidArgumentException> - if parameter was nil or NaN
        <XPS_typ_ArgumentOutOfRangeException> - if index does not exist
    ----------------------------------------------------------------------------*/
	["GetItem", compileFinal {
        if !(_this isEqualType 0) exitWith {throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"RemoveItem",nil,createHashMapFromArray [["_this",_this]]]];};
		if (_this >= _self call ["Count"]) then { throw createHashmapObject [XPS_typ_ArgumentOutOfRangeException,[_self,"GetItem",nil,createHashMapFromArray [["_this",_this]]]]};

        if !(_self call ["IsEmpty"]) then {
		    _self get "_listArray" select _this;
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
    ["GetItems", compileFinal {
        private _array = _self get "_listArray";
        +_array;
    }],
    /*----------------------------------------------------------------------------
    Method: SetItem
    
        --- Prototype --- 
        call ["SetItem",[_index, _item]]
        ---

        <XPS_ifc_ICollection>

        Replaces item at specified Index.
    
    Parameters: 
		_index - can be negative (same rules as BI command 'set' for arrays)
        _item - <Anything> - except nil

    Returns:
        <True> - the item is successfully updated

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["SetItem", compileFinal {
        if !(params [["_index",nil,[0]],["_item",nil,[]]]) exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"SetItem",nil,createHashMapFromArray [["_this",_this]]]];};
		(_self get "_listArray") set [_index,_item];
        true;
	}],
    /*----------------------------------------------------------------------------
    Method: UpdateItem
    
        --- Prototype --- 
        call ["UpdateItem",[_index, [_key, _value]]]
        ---

        <XPS_ifc_ICollection>

        Updates item key/value pair at specified Index. 
        Will throw an exception if Item updated is not a <Hashmap> or <HashmapObject>. Use SetItem instead.
    
    Parameters: 
		_index - can be negative (same rules as BI command 'select' for arrays)
        _key - the property of the item if it is a <Hashmap> or <HashmapObject>
        _value - the value to set the property if it is a <Hashmap> or <HashmapObject>

    Returns:
        <True> - the item is successfully updated

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
        <XPS_typ_ArgumentOutOfRangeException> - if index does not exist
        <XPS_typ_InvalidArgumentException> - if index does not contain  <hashmap> or <hashmapobject>
    ----------------------------------------------------------------------------*/
	["UpdateItem", compileFinal {
        if !(params [["_index",nil,[0]],["_propertyArray",nil,[[]],[2]]]) exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"UpdateItem",nil,createHashMapFromArray [["_this",_this]]]];};
		if (_index >= _self call ["Count"]) then { throw createHashmapObject [XPS_typ_ArgumentOutOfRangeException,[_self,"UpdateItem",nil,createHashMapFromArray [["_this",_this]]]]};
        private _item = _self call ["GetItem",_index];
        if (_item isEqualType createhashmap) then {
            _propertyArray params ["_key","_value"];
            _item set [_key,_value];
        } else {
            throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"UpdateItem",nil,createHashMapFromArray [["_this",_this]]]]
        };
        true;
	}],
    /*----------------------------------------------------------------------------
    Method: InsertItem
    
        --- Prototype --- 
        call ["InsertItem",[_index, [_item1, _item2*]]]
        ---

        <XPS_ifc_ICollection>

        Inserts items at the specified index 
        
    Parameters: 
		_index - can be negative (same rules as BI command 'insert' for arrays)
        _array - array of items to be added

    Returns:
        <True> - the item is successfully updated

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["InsertItem", compileFinal {
        if !(params [["_index",nil,[0]],["_itemArray",nil,[[]]]]) exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"UpdateItem",nil,createHashMapFromArray [["_this",_this]]]];};
		
        _self get "_listArray" insert [_index,_propertyArray,false];

        true;
	}]
]