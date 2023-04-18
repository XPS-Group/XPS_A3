#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: xps_fnc_blackboard

Description:
    Create or work with <Blackboard> 

Parameters: 
    type - <String> - a string defining the type of container. Used for type checking. Can be anything. Example: "TAG_MyCustomBlackboard"
    name - <String> - a descriptive name for the container - can be anything except empty string
    store - <Anything> - optional - default : nil - see <Blackboard> for use

Returns:
<Blackboard> - <HashMap> or nothing(nil) if failed

Examples:

Author:
    CrashDome
---------------------------------------------------------------------------- */

if !(params [["_type",nil,[""]],["_name",nil,[""]]/*,"_store"*/]) exitwith {nil;};
//_store = [_store] param [0,createhashmap,[createhashmap,objNull]];
if (_name == "" || _type == "") exitwith {nil};

private _blackboard = [_type, _name] call xps_fnc_container;
//_blackboard set ["Store",_store];

// TODO Move these to implementation
// //Assign it to an object/unit
// _object setVariable [_varName, _blackboard];

// if !(_persistent) then {
//     _object addEventHandler ["Deleted", compile format ["params [""_object""]; [(_object getVariable %1) get ""ProxyNamespace""] call xps_fnc_deleteObjectNamespace;",_varName]];
// };

_blackboard;