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

if !(params [["_errorString","",[""]],"_args"]) exitwith {
    diag_log format ["XPS: Error in logging params (_errorString not a string): params: %1,%2",[_errorString,_args]];
};
_args = [_args] param [0,[],[[]]];

if (count _args > 0) then {
    diag_log _errorString;
} else {
    args insert [0,_errorString];
    diag_log format [_args];
};