#include "script_component.hpp"
#define SELF xps_fnc_containers
/* ----------------------------------------------------------------------------
Function: xps_fnc_containers

Description:
    Creates and returns a new <Containers> object which is a <Collection> of type <Container>.
    It has additional requirements from a normal <Collection> in that the [Items] MUST be 
    a type of <Container> and can be further restricted by the [AllowedContainers] list.

Parameters: 
    data - <Array> - array of parameters. See below for per operation parameters
    operation - <String> - operation - Command operation. 
    containers - <Containers> - the <Containers> to perform the operation on
    
Returns:
    See below for operations

Examples:
    --- Code
        ["_create",["MyContainers", ["MyContainer"]] = call xps_fnc_containers;
    ---

Author:
    CrashDome

---------------------------------------------------------------------------- */
if !(params [["_data",nil,[[]]],["_operation","",[""]],"_containers"]) exitwith {nil;};
private _result = false;

private _fnc_create = {
    if !(_data params [["_name",nil,[""]],["_allowedContainers",[],[[]]]]) exitwith {nil;};
    private _containers = [[_name, [createhashmap]],"create"] call xps_fnc_collection;
    _containers set ["AllowedContainers",_allowedContainers];
    _containers set ["Self",SELF];
    _containers;
};

private _fnc_registerAllowedContainer = {
    if !([_containers] params [["_containers",nil,[createhashmap]]] ||
        _data params [["_containerType",nil,[""]]]) exitwith {false;};
    if (_containerType == "")  exitwith {false;};
    private _list = _containers get "AllowedContainers";
    _list pushback _containerType;
};

// private _fnc_unregisterAllowedContainer = {
// };

private _fnc_addContainer = {
    if !([_containers] params [["_containers",nil,[createhashmap]]] ||
        _data params [["_item",nil,[createhashmap]]]) exitwith {false;};
    private _type = _item get "Type";
    private _name = _item get "Name";
    private _list = _containers get "AllowedContainers";
    if (isNil {_type} || !(_type isEqualType "") || !(_type in _list)) exitwith {false;};
    [[_name,_item],"addItem",_containers] call xps_fnc_collection;
};

private _fnc_removeContainer = {
    if !([_containers] params [["_containers",nil,[createhashmap]]] ||
        _data params [["_name",nil,[""]]]) exitwith {false;};
    if (_name == "")  exitwith {false;};
    [[_name],"addItem",_containers] call xps_fnc_collection;
};

switch (_operation) do {

    /*----------------------------------------------------------------------------------------------------
        Operator: ["create"]

        Parameters: 
        Data Array: [name, allowedContainers]

            name - <String> - a descriptive name for the collection - the shorter the better
            allowedContainers - <Array> - of <Strings> composed of a list of valid container types
            
        Returns:
        <Containers> - Multi-Dimensional <HashMap> or nothing(nil) if failed

        Examples:
            --- Code
            ---
    ----------------------------------------------------------------------------------------------------*/
    case "create" : {
        _result = call _fnc_create;
    };
    /*----------------------------------------------------------------------------------------------------
        Operator: ["registerAllowedContainer"]

        Parameters: 
        Data Array: [containerType]

            containerType - <Array> - of <Strings> to restrict adding <Container> items of only these types

        Returns:
        True/False if succeeded

        Examples:
            --- Code
            ---
    ----------------------------------------------------------------------------------------------------*/
    case "registerAllowedContainer" : {
        _result = call _fnc_registerAllowedType;
    };
    // case "unregisterAllowedContainer" : {
    // };
    /*----------------------------------------------------------------------------------------------------
        Operator: ["addContainer"]

        Parameters: 
        Data Array: [container]

            type - <String> - type of container to allow

        Returns:
        True/False if succeeded

        Examples:
            --- Code
            ---
    ----------------------------------------------------------------------------------------------------*/
    case "addContainer" : {
        _result = call _fnc_addContainer;
    };
    /*----------------------------------------------------------------------------------------------------
        Operator: ["removeContainer"]

        Parameters: 
        Data Array: [name]

            name - <String> - the Name of the Container (e.g. container get "Name")

        Returns:
        True/False if succeeded

        Examples:
            --- Code
            ---
    ----------------------------------------------------------------------------------------------------*/
    case "removeContainer" : {
        _result = call _fnc_removeContainer;
    };
};

_result;