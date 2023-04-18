#include "script_component.hpp"

if !(params [["_errorString","",[""]]]) exitwith {nil;};

diag_log text _errorString;