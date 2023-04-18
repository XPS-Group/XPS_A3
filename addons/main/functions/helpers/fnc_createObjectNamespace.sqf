#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: xps_fnc_createObjectNamespace

Description:
    Create and return a new Namespace based on CBA_NamespaceDummy. Same as CBA_fnc_createObjectNamespace but
    modified to only produce simpleObjects and not

Parameters: 
    global - <Boolean> - create a global object (optional, default: false) <Boolean>

Returns: 
    namespace - <Object> - a simpleObject

Examples:
    --- Code
    _myNamespace = call xps_fnc_createObjectNamespace; //local object (namespace local)
    ---
	
    --- Code
    MyNamespace = true call xps_fnc_createObjectNamespace; //global object (namespace local but can publish)
    publicVariable "MyNamespace"  // current variables published to all clients
    ---

Author:
    CrashDome

---------------------------------------------------------------------------- */

params [[_global],false,[false]];

if (_global) then {
	createSimpleObject ["CBA_NamespaceDummy", [-1000,-1000,0]];
} else {
	createSimpleObject ["CBA_NamespaceDummy", [-1000,-1000,0],true];
};