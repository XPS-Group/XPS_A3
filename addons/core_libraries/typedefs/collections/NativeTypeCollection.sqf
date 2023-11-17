#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_NativeTypeCollection
	<TypeDefinition>
        --- prototype
        XPS_typ_NativeTypeCollection : XPS_ifc_ICollection, XPS_typ_Collection
        ---
        --- prototype
        createhashmapobject [XPS_typ_NativeTypeCollection,[_allowedTypes]]
        ---

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores items only if the type is allowed

Parameters: 
    _allowedTypes (optional) - <Array> - in the same format as the Params command - i.e. ["",[],objNull,0]

Returns:
    <HashmapObject>
---------------------------------------------------------------------------- */


[
	["#type","XPS_typ_NativeTypeCollection"],
    /*----------------------------------------------------------------------------
    Parent: #base
        <XPS_typ_Collection>
    ----------------------------------------------------------------------------*/
    ["#base", XPS_typ_Collection],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call [#create,[_allowedTypes]]
        ---
    
    Parameters: 
        _allowedTypes (optional) - <Array> - in the same format as the Params command - i.e. ["",[],objNull,0]

    Returns:
        True
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self call ["XPS_typ_Collection.#create"];
        params [["_allowedTypes",[],[[]]]];
         _self set ["_allowed",_allowedTypes];
    }],
    /*----------------------------------------------------------------------------
    Parent: #str
		--- prototype
		"XPS_typ_NativeTypeCollection"
		---
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Parent: @interfaces
        <XPS_typ_Collection.@interfaces>
    ----------------------------------------------------------------------------*/
    ["_allowed",[]],
    /*----------------------------------------------------------------------------
    Method: RegisterType 
    
        --- Prototype --- 
        call ["RegisterType",_type]
        ---

        <XPS_ifc_ICollection>
    
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
        private _allowlist = _self get "_allowed";
        if !(_item isEqualTypeAny _allowlist) exitwith {false;};
        _self call ["XPS_typ_Collection",[_key,_item]];
        true;
    }],

    /* -----------------------------------------------------------------------
    Method: RemoveItem
		<XPS_typ_Collection.RemoveItem>

    -------------------------------------------------------------------------*/ 
    /* -----------------------------------------------------------------------
    Method: GetItems
		<XPS_typ_Collection.GetItems>

    -------------------------------------------------------------------------*/ 

]
