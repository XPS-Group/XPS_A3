#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: xps_fnc_deleteObjectNamespace

Description:
    Deletes a Namespace based on CBA_NamespaceDummy

Parameters: 
    _namespace - <Object> - object to delete

Returns: 
    Nothing

Examples:
    --- Code
    _myNamespace call xps_fnc_deleteObjectNamespace; 
    ---

Author:
    CrashDome

---------------------------------------------------------------------------- */

params [["_namespace",objNull,[objNull]]];

if (_namespace isKindOf "CBA_NamespaceDummy") then {deleteVehicle _namespace;};