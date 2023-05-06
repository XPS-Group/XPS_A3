#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_logError

    --- prototype
    [_message] call XPS_fnc_logError
    ---

Description:
    Puts string into rpt file

Parameters: _message
    <String> - message to put in rpt

Returns: Nothing

Example: Typical
    --- Code
    ["Hello"] call XPS_fnc_logError; 
    ---

Authors:
     Crashdome

---------------------------------------------------------------------------- */

if !(params [["_errorString","",[""]]]) exitwith {nil;};

diag_log text _errorString;