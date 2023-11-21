#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_TypeCollection
	<TypeDefinition>
        --- prototype
        XPS_typ_TypeCollection : XPS_ifc_ICollection, XPS_ifc_ITypeRestrictor
        ---
        --- prototype
        createhashmapobject [XPS_typ_TypeCollection,[_typeRestrictor]]
        ---

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores items only if the type is allowed

Parameters: 
    _typeRestrictor (optional) - <HashmapObject> that implements <XPS_ifc_ITypeRestrictor> 

Returns:
    <HashmapObject>
---------------------------------------------------------------------------- */


[
	["#type","XPS_typ_TypeCollection"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call [#create,[_typeRestrictor]]
        ---
    
    Parameters: 
        _typeRestrictor (optional) - <HashmapObject> that implements <XPS_ifc_ITypeRestrictor> 

    Returns:
        True

    Throws:
        <XPS_typ_InvalidArgumentException> - if parameter does not implement the <XPS_ifc_ITypeRestrictor> interface
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        params [["_typeRestrictor",createhashmapobject [XPS_typ_NoTypeRestrictor],[createhashmap]]];
        if !(CHECK_IFC1(_typeRestrictor,XPS_ifc_ITypeRestrictor)) then {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"#create","_typeRestrictor parameter was an invalid type",_this]]
        };
        _self set ["_restrictor",_typeRestrictor];
        _self set ["_items",createhashmap];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_TypeCollection"
		---
	----------------------------------------------------------------------------*/
	["#str",compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_ICollection>
		<XPS_ifc_ITypeRestrictor>
	----------------------------------------------------------------------------*/
    ["@interfaces",["XPS_ifc_ICollection","XPS_ifc_ITypeRestrictor"]],
    ["_items",createhashmap],
    ["_restrictor",nil],
    /*----------------------------------------------------------------------------
    Method: AddItem
    
        --- Prototype --- 
        call ["AddItem",[_key,_item]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        _key - <HashmapKey> 
        _item - Anything - except nil

    Returns:
        True - the item is successfully added

    Throws:
        <XPS_typ_ArgumentNilException> - if a parameter was nil
        <XPS_typ_InvalidArgumentException> - if key parameter already exists in this collection - OR- if _item is not allowed 
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"AddItem",nil,_this]];};
        if ((_key == "") || (_key in (keys (_self get "_items")))) exitwith {throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"AddItem","Key already exists in this collection",_this]];};
        if (_self get "_restrictor" call ["IsAllowed",_item]) then {
            _self get "_items" set [_key,_item];
        } else {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"AddItem","Item is not allowed in this collection",_this]];
        };
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

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        if !(params [["_key",nil,[""]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"RemoveItem",nil,_this]];};
        _self get "_items" deleteAt _key;
    }],
    /* -----------------------------------------------------------------------
    Method: GetItem

        ---prototype
        call ["GetItem",[_key]]
        ---

        <XPS_ifc_ICollection>
    
    Parameters: 
        key - <HashmapKey> 

    Returns:
        Anything - The item if found otherwise nil

    -------------------------------------------------------------------------*/ 
    ["GetItem",{
        if !(params [["_key",nil,[""]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetItem",nil,_this]];};
        _self get "_items" get _key;
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
    }],
    /*----------------------------------------------------------------------------
    Method: SetItem
    
        --- Prototype --- 
        call ["SetItem",[_key, _item]]
        ---

        <XPS_ifc_ICollection>

        Replaces item at specified Key.
    
    Parameters: 
		_key - <HashmapKey>
        _item - Anything - except nil

    Returns:
        True - the item is successfully added to end of list

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
        <XPS_typ_InvalidArgumentException> - if key parameter does not exist in this collection - OR- if _item is not allowed 
    ----------------------------------------------------------------------------*/
	["SetItem",{
        if !(params [["_key",nil,[""]],["_item",nil,[]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"SetItem",nil,_this]];};
        if ((_key == "") || !(_key in (keys (_self get "_items")))) exitwith {throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"SetItem","Key does not exist in this collection",_this]];};
        if (_self get "_restrictor" call ["IsAllowed",_item]) then {
            _self get "_items" set [_key,_item];
        } else {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"SetItem","Item is not allowed in this collection",_this]];
        };
        true;
	}],
    /*----------------------------------------------------------------------------
    Method: RegisterType 
    
        --- Prototype --- 
        call ["RegisterType",_type]
        ---

        <XPS_ifc_ITypeRestrictor>
    
    Parameters: 
        _type - <Type> - used to add a type after object creation.
	----------------------------------------------------------------------------*/
    ["RegisterType",compileFinal {
        _self get "_restrictor" call ["RegisterType",_this];
    }],
    /*----------------------------------------------------------------------------
    Method: IsAllowed 
    
        --- Prototype --- 
        call ["IsAllowed",_value]
        ---

        <XPS_ifc_ITypeRestrictor>
    
    Parameters: 
        _value - Anything - Value to check to see if it is allowed to be added
	----------------------------------------------------------------------------*/
    ["IsAllowed",{
        _self get "_restrictor" call ["IsAllowed",_this];
    }]
]
