#include "script_component.hpp"
#define SELF xps_fnc_collection
/* ----------------------------------------------------------------------------
Function: xps_fnc_collection

Description:
    Creates and works with <Collection> which stores a complete item in a <HashMap> store
    (such as the [Items] key) with a subkey for quick lookup. This differs from a <Container> 
    in that all values are easily retrievable at once. The drawback is that if you only need
    a single value, you have to do an additional lookup within the returned value set.

    They are, however, structurally similar as simply a base <HashMap>. It is up to the implementation
    function to treat them as they are so labelled.

    * Note: a <Collection> might often store multiple <Containers> or vice-versa

Parameters: 
    data - <Array> - array of parameters. See below for per operation parameters
    operation - <String> - operation - Command operation. 
    collection - <Collection> - the <Collection> to perform the operation on

Returns:
    See below for operations

Examples:
    --- Code
        ["_create",["MyNewCollection", [0,"",[],objNull], ["",0,0]] = call xps_fnc_collection;
    ---

Author:
    CrashDome

---------------------------------------------------------------------------- */
if !(params [["_data",nil,[[]]],["_operation","",[""]],"_collection"]) exitwith {nil;};;
private _result = false;

private _fnc_create = {
    if !(_data params [["_name",nil,[""]],["_allowedTypes",[],[[]]],"_arrayTemplate"]) exitwith {nil;};
    if (_name == "") exitwith {false;};
    createhashmapfromarray [["Self",SELF],["Name",_name],["AllowedTypes",_allowedTypes],["ArrayTemplate",_arrayTemplate],["Items",createhashmap]];
};

private _fnc_registerAllowedType = {
    if !([_collection] params [["_collection",nil,[createhashmap]]] ||
        _data params [["_type",nil,[]]]) exitwith {false;};
    private _list = _container get "AllowedTypes";
    if (_type in _list) exitwith {false;};
    _list pushback _type;
};

// private _fnc_unregisterAllowedType = {

// };

private _fnc_addItem = {
    if !([_collection] params [["_collection",nil,[createhashmap]]] ||
        _data params [["_key",nil,[""]],["_item",nil,[]]]) exitwith {false;};
    if !("Items" in (keys _collection)) exitwith {false;};
    if ((_key == "") || (_key in (keys (_collection get "Items")))) exitwith {false;};
    private _allowlist = _collection get "AllowedTypes";
    private _template = _collection get "ArrayTemplate";
    if !(_item isEqualTypeAny _allowlist) exitwith {false;};
    if (_item isEqualType [] && !(_item isEqualTypeParams _template)) exitwith {false;};
    (_collection get "Items") set [_name,_item];
    true;
};

private _fnc_removeItem = {
    if !([_collection] params [["_collection",nil,[createhashmap]] ]||
        _data params [["_key",nil,[""]]]) exitwith {false;};
    if !("Items" in (keys _collection)) exitwith {false;};
    if !(_key in (keys (_collection get "Items"))) exitwith {false;};
    _collection deleteAt _key;
    true;
};

switch (_operation) do {    
    
    /*----------------------------------------------------------------------------------------------------
    Operator: ["create"]

    Parameters: 
    Data Array: [name, allowedTypes, arrayTemplate]

        name - <String> - a descriptive name for the collection - the shorter the better
        allowedTypes - <Array> - similar to the allowed types in a Params call. 
        arrayTemplate - <Array> - used to perform an isEqualTypeParams call on an item that 
        is an <Array>

    Returns:
    <Collection> - Multi-Dimensional <HashMap> or nothing(nil) if failed

    Examples:
        --- Code
        ---
    ----------------------------------------------------------------------------------------------------*/
    case "create" : {
        _result = call _fnc_create;
    };
    /*----------------------------------------------------------------------------------------------------
    Operator: ["registerAllowedType"]

	Parameters: 
    Data Array: [type]

            type - <Any> - similar to the allowed types in a Params call.  e.g use "" for <String> or [] for <Array>

	Returns:
	True/False if succeeded - will return false if type already in list

	Examples:
		--- Code
		---
    ----------------------------------------------------------------------------------------------------*/
    case "registerAllowedType" : {
        _result = call _fnc_registerAllowedType;
    };
    // case "unregisterAllowedType" : {
    // };
    /*----------------------------------------------------------------------------------------------------
    Operator: ["addItem"]

	Parameters: 
    Data Array: [key, item]

            key - <Any> - the key used to store the item
            item - <Any> - any data type - checks if allowed via AllowedTypes and ArrayTemplate

	Returns:
	True/False if succeeded

	Examples:
		--- Code
		---
    ----------------------------------------------------------------------------------------------------*/
    case "addItem" : {
        _result = call _fnc_addItem;
    };
    /*----------------------------------------------------------------------------------------------------
    Operator: ["removeItem"]

	Parameters: 
    Data Array: [key]
    
            key - <Any> - the key used to store the item

	Returns:
	True/False if succeeded

	Examples:
		--- Code
		---
    ----------------------------------------------------------------------------------------------------*/
    case "removeItem" : {
        _result = call _fnc_removeItem;
    };
};

_result;