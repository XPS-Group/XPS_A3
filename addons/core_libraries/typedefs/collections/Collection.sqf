#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Collection
	<TypeDefinition>

    	--- Prototype --- 
		XPS_typ_Collection :  XPS_ifc_ICollection
    	---
        --- prototype
        createhashmapobject [XPS_typ_Collection]
        ---

Authors: 
	Crashdome
   
Description:
<HashmapObject> which is essentially just a wrapper for a <Hashmap> 

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Collection"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---
    
    Return:
        True
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self set ["_items",createhashmap];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Collection"
		---
	----------------------------------------------------------------------------*/
	["#str",compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_ICollection>
	----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_ifc_ICollection"]],
    ["_items",createhashmap],
    /*----------------------------------------------------------------------------
    Method: AddItem
    
        --- Prototype --- 
        call ["AddItem",[_key,_item]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        key - <HashmapKey> 
        item - Anything 
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[]]]) exitwith {false;};
        if ((_key == "") || (_key in (keys (_self get "_items")))) exitwith {false;};
        (_self get "_items") set [_key,_item];
        true;
    }],
    /*----------------------------------------------------------------------------
    Method: RemoveItem
    
        --- Prototype --- 
        call ["RemoveItem",[_key]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        key - <HashmapKey> 

    Returns:
        Anything - the item removed or nil if not found
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        if !(params [["_key",nil,[""]]]) exitwith {false;};
        if !(_key in (keys (_self get "_items"))) exitwith {false;};
        _self get "_items" deleteAt _key;
    }],
    /* -----------------------------------------------------------------------
    Method: GetItems

        ---prototype
        call ["GetItems"];
        ---

        <XPS_ifc_ICollection>

    Returns:
        <Array> - A copy of the item store in an array

    -------------------------------------------------------------------------*/ 
    ["GetItems",{
        values (_self get "_items");
    }]
]
