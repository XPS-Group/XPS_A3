#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Collection
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores items 

Parent:
    none

Implements:
    <XPS_ifc_ICollection>

Flags:
    none

---------------------------------------------------------------------------- */


[
	["#str",compileFinal {_self get "#type" select  0}],
	["#type","XPS_typ_Collection"],
    ["@interfaces",["XPS_ifc_ICollection"]],
    ["_items",createhashmap],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_Collection]
        ---
    
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self set ["_items",createhashmap];
    }],
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
