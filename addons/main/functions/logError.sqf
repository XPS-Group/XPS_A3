#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_logError

    --- prototype
    [_message,_args*] call XPS_fnc_logError
    ---

Description:
    Puts string into rpt file

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _message 
    <String> - message to put in rpt

Optional: _args* 
    <Array> - (Optional - Default: []) - if supplied, message string will
    be expected to be same as Format command (with %1, %2, etc..)

Returns: Nothing

Example: Typical
    --- Code
    ["Hello"] call XPS_fnc_logError; 
    ---

---------------------------------------------------------------------------- */

if !(params [["_errorString","",[""]],"_args"]) exitWith {
    diag_log text format ["XPS: Error in logging params (_errorString not a string): params: %1,%2",_errorString,_args];
};
_args = [_args] param [0,[],[[]]];

if (_args isNotEqualTo []) then {
    diag_log _errorString;
} else {
    args insert [0,_errorString];
    diag_log text format _args;
};
