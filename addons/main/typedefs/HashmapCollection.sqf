#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: main. XPS_typ_HashmapCollection

Description:
<TypeDefinition> - stores only <HashmapObjects> which match <AllowedTypes> array
in a Items <hashmap>.

Parent:
    none

Implements:
    <XPS_ifc_ICollection>

Flags:
    none

Authors: 
	Crashdome
-------------------------------------------------------------------------------
    Property: AllowedTypes

        ---prototype
        get "AllowedTypes"
        ---

        <Array> of <Strings> - List of allowed types when using <AddItem> method

    Property: Items

        ---prototype
        get "Items"
        ---

        <Hashmap> - Storage of <HashmapObjects> for this collection
---------------------------------------------------------------------------- */
[
	["#str",{"XPS_typ_HashmapCollection"}],
	["#type","XPS_typ_HashmapCollection"],
    ["@interfaces",["XPS_ifc_ICollection"]],
    ["AllowedTypes",[]],
    ["Items",nil],
    /* -----------------------------------------------------------------------
    Constructor: #create

        ---prototype
        _myobj = createhashmapobject ["XPS_type_HashmapCollection",[_allowedTtypes]];
        ---
    
    Parameters: 
        _allowedTypes - <Array> of <Strings> - used to limit which types of
        <HashmapObjects> are allowed to be added to the Items store. Checks against
        the '#type' result of item added

    Returns:
        <HashmapObject>

    -------------------------------------------------------------------------*/ 
    ["#create", compileFinal {
        params [["_allowedTypes",nil,[[]]]];
        if !(isNil "_allowedTypes") then {_self set ["AllowedTypes",_allowedTypes];};
        _self set ["Items",createhashmap];
    }],

    /* -----------------------------------------------------------------------
    Method: RegisterType

        ---prototype
        call ["RegisterType",[_type]];
        ---
    
    Parameters: 
        _type - <String> - used to add a type after object creation.

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["RegisterType",compileFinal {
        if !(params [["_type",nil,[""]]]) exitwith {false;};
        private _list = _self get "AllowedTypes";
        if (_type in _list) exitwith {false;};
        _list pushback _type;
        true;
    }],

    /* -----------------------------------------------------------------------
    Method: AddItem

        ---prototype
        call ["AddItem",[_key,_item]];
        ---
    
    Parameters: 
        _key - Anything - Key used when adding to <Items> store
        _item - <HashmapObject> - to add to <Items> store

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[createhashmap]]]) exitwith {false;};
        if !("Items" in (keys _self)) exitwith {false;};
        if ((_key == "") || (_key in (keys (_self get "Items")))) exitwith {false;};
        private _allowlist = _self get "AllowedTypes";
        private _types = _item get ["#type"];
        if !(count (_types arrayIntersect _allowlist) > 0) exitwith {false;};
        (_self get "Items") set [_key,_item];
        true;
    }],

    /* -----------------------------------------------------------------------
    Method: RemoveItem

        ---prototype
        call ["RemoveItem",[_key]];
        ---
    
    Parameters: 
        _key - Anything - Key of item to remove from <Items> store

    Returns:
        <Boolean> - <True> if successfully added, otherwise <False>

    -------------------------------------------------------------------------*/ 
	["RemoveItem",compileFinal {
        if !(params [["_key",nil,[""]]]) exitwith {false;};
        if !("Items" in (keys _self)) exitwith {false;};
        if !(_key in (keys (_self get "Items"))) exitwith {false;};
        _self deleteAt _key;
        true;
    }]
]