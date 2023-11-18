#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_HashmapObjectTypeCollection
    <TypeDefinition>
        --- prototype
        XPS_typ_HashmapObjectTypeCollection : XPS_ifc_ITypeCollection, XPS_typ_TypeCollection
        ---
        --- prototype
        createhashmapobject [XPS_typ_HashmapObjectTypeCollection,[_allowedTypes]]
        ---

Authors: 
	Crashdome

Description:
    Stores only <HashmapObjects> 

Parameters: 
    _allowedTypes (optional) - <Array> -of <Strings> which are <HashmapObject> '#type's

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_HashmapObjectTypeCollection"],
    /*----------------------------------------------------------------------------
    Parent: #base
        <XPS_typ_TypeCollection>
    ----------------------------------------------------------------------------*/
    ["#base", XPS_typ_TypeCollection],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call [#create,[_allowedTypes]]
        ---
    
    Parameters: 
        _allowedTypes (optional) - <Array> -of <Strings> which are <HashmapObject> '#type's

    Returns:
        True
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self call ["XPS_typ_TypeCollection.#create"];
        params [["_allowedTypes",[],[[]]]];
        if (_allowedTypes isEqualTypeAll "") then {
            _self set ["_allowed",_allowedTypes];
        };
    }],
    /*----------------------------------------------------------------------------
    Parent: #str
		--- prototype
		"XPS_typ_HashmapObjectTypeCollection"
		---
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Parent: @interfaces
        <XPS_typ_TypeCollection.@interfaces>
    ----------------------------------------------------------------------------*/
    ["_allowed",[]],
    /*----------------------------------------------------------------------------
    Method: RegisterType 
    
        --- Prototype --- 
        call ["RegisterType",_type]
        ---
    
    Parameters: 
        _type - <Type> - used to add a type after object creation. In shorthand - i.e. [] or objNull or 0 or createhashmap, etc..
	----------------------------------------------------------------------------*/
    ["RegisterType",compileFinal {
        if !(params [["_type",nil,[]]]) exitwith {false;};
        private _list = _self get "_allowed";
        if (_type in _list) exitwith {false;};
        _list pushback _type;
        true;
    }],
    /* -----------------------------------------------------------------------
    Method: AddItem

        ---prototype
        call ["AddItem",[_key,_item]];
        ---

        <XPS_ifc_ITypeCollection>
    
    Parameters: 
        _key - Anything - Key used when adding to store
        _item - <HashmapObject> - to add to the store

    Returns:
        <Boolean> - True if successfully added, otherwise False

    -------------------------------------------------------------------------*/ 
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[createhashmap]]]) exitwith {false;};
        if ((_key == "") || (_key in (keys (_self get "_items")))) exitwith {false;};
        private _allowlist = _self get "_allowed";
        private _types = _item getOrDefault ["#type",[]];
        if !(count (_types arrayIntersect _allowlist) > 0) exitwith {false;};
        (_self get "_items") set [_key,_item];
        true;
    }]

    /* -----------------------------------------------------------------------
    Method: RemoveItem
		<XPS_typ_TypeCollection.RemoveItem>

    -------------------------------------------------------------------------*/ 

    /* -----------------------------------------------------------------------
    Method: GetItems
		<XPS_typ_TypeCollection.GetItems>

    -------------------------------------------------------------------------*/ 
]