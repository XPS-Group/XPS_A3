#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_createObjectNamespace

    --- prototype
    _object = call XPS_fnc_createObjectNamespace
    ---

    --- prototype
    _object = [true] call XPS_fnc_createObjectNamespace
    ---

Description:
    Create and return a new Namespace based on CBA_NamespaceDummy. Same as CBA_fnc_createObjectNamespace but
    modified to only produce simpleObjects and not locations

Optional: _global 
    <Boolean> - create a global object (optional, default: false) <Boolean>

Returns: object 
    <Object> - a simpleObject

Examples:
    --- Code
    _myNamespace = call XPS_fnc_createObjectNamespace; //local object (namespace local)
    ---
	
    --- Code
    MyNamespace = true call XPS_fnc_createObjectNamespace; //global object (namespace local but can publish)
    publicVariable "MyNamespace"  // current variables published to all clients
    ---

Authors:
     Crashdome

---------------------------------------------------------------------------- */

params [[_global],false,[false]];

if (_global) then {
	createSimpleObject ["CBA_NamespaceDummy", [-1000,-1000,0]];
} else {
	createSimpleObject ["CBA_NamespaceDummy", [-1000,-1000,0],true];
};