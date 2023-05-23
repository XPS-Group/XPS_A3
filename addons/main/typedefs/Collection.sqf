#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: main. XPS_typ_Collection
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores items which match <AllowedTypes> array 

Parent:
    none

Implements:
    <XPS_ifc_ICollection>

Flags:
    none

Property: AllowedTypes

Property: Items
---------------------------------------------------------------------------- */


[
	["#str",compileFinal {"XPS_typ_Collection"}],
    ["#interfaces",["XPS_ifc_ICollection"]],
    /*
    Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_Collection,[_allowedTypes]]
        ---
    
    Parameters: 
        _allowedTypes (optional) - <Array> - in the same format as the Params command - i.e. ["",[],objNull,0]
    */
    ["#create", compileFinal {
        params [["_allowedTypes",[],[[]]]];
        _self set ["AllowedTypes",_allowedTypes];
        _self set ["Items",createhashmap];
    }],
    /*
    Method: RegisterType 
    
        --- Prototype --- 
        call ["RegisterType",_type]
        ---
    
    Parameters: 
        type - <Type> - used to add a type after object creation. In shorthand - i.e. [] or objNull or 0 or createhashmap, etc..
	*/
    ["RegisterType",compileFinal {
        if !(params [["_type",nil,[]]]) exitwith {false;};
        private _list = _self get "AllowedTypes";
        if (_type in _list) exitwith {false;};
        _list pushback _type;
        true;
    }],
    /*
    Method: AddItem
    
        --- Prototype --- 
        call ["AddItem",[_key,_item]]
        ---
    
    Parameters: 
        key - <HashmapKey> 
        item - <Anything> 
    */
	["AddItem", compileFinal {
        if !(params [["_key",nil,[""]],["_item",nil,[]]]) exitwith {false;};
        if !("Items" in (keys _self)) exitwith {false;};
        if ((_key == "") || (_key in (keys (_self get "Items")))) exitwith {false;};
        private _allowlist = _self get "AllowedTypes";
        if !(_item isEqualTypeAny _allowlist) exitwith {false;};
        (_self get "Items") set [_key,_item];
        true;
    }],
    /*
    Method: RemoveItem
    
        --- Prototype --- 
        call ["RemoveItem",[_key]]
        ---
    
    Parameters: 
        key - <HashmapKey> 
    */
	["RemoveItem",compileFinal {
        if !(params [["_key",nil,[""]]]) exitwith {false;};
        if !("Items" in (keys _self)) exitwith {false;};
        if !(_key in (keys (_self get "Items"))) exitwith {false;};
        _self deleteAt _key;
        true;
    }]
]
