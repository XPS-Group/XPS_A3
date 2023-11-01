#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_ExceptionHandler
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which aides in handling thrown <HashmapObjects> of type <XPS_typ_Exception> and
	derivatives.

Parent:
    none

Implements:
    <XPS_typ_ExceptionHandler>

Flags:
	Sealed
	NoCopy

---------------------------------------------------------------------------- */
[
	["#str",{_self get "#type"}],
	["#type", "XPS_typ_ExceptionHandler"],
	["_stackVariable",""],
	["initStackLocation",{
		private _stackVar = "xps_stack_" + ([4] call XPS_fnc_createUniqueID);
		_self set ["_stackVariable",_stackVar];
		_self call ["Reset"];;
	}],
	["#create",{
		_self call ["initStackLocation"];
		addMissionEventHandler ["ScriptError",{
			(_this#0) call ["Dump"]; 
		},[_self]];
	}],
	["AddToStackTrace",{
		params [["_exceptionString","",[""]],["_handled",false,[true]]];

		private _stack = _self call ["GetStackTrace"];
		_stack pushback _exceptionString;

		if (_handled) then {
			_self call ["Dump"];
		};
	}],
	["GetStackTrace",{call compile (_self get "_stackVariable");}],
	["Dump",{
		private _stack = _self call ["GetStackTrace"];
		_level = 1;
		while {count _stack > 0} do {
			if (_level == 1) then {_self call ["Log","XPS_ExceptionHandler Stack Dump:"]};
			private _string = _stack deleteat -1;
			for "_n" from 1 to _level do {
				_string = "   " + _string;
			};
			_self call ["Log",[_string]];
		};
	}],
	["Log",{
		params [["_string","",[""]]];
		diag_log text _string;
	}],
	["Reset",{
		private _stack = _self call ["GetStackTrace"];
		call compile format["%1 = []",_stackVar];
	}]
]