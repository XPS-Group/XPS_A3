#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_deleteObjectNamespace

    --- prototype
    [_namespace] call XPS_fnc_deleteObjectNamespace
    ---

Description:
    Deletes a Namespace based on CBA_NamespaceDummy

Parameters: _namespace 
    <Object> - object to delete

Returns: Nothing

Example: Typical
    --- Code
    _myNamespace call XPS_fnc_deleteObjectNamespace; 
    ---

Authors:
     Crashdome

---------------------------------------------------------------------------- */

params [["_namespace",objNull,[objNull]]];

if (_namespace isKindOf "CBA_NamespaceDummy") then {deleteVehicle _namespace;};