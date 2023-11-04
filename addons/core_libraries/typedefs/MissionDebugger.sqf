#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_MissionDebugger
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which aides in handling a Stack Trace. Also adds a 
	Mission Event Handler for "ScriptError" to automatically flush and log
	the current stack. 

Parent:
    none

Implements:
    Nothing

Flags:
	Sealed
	NoCopy

---------------------------------------------------------------------------- */
[
	["#str",{_self get "#type"}],
	["#type", "XPS_typ_MissionDebugger"],
	["#flags",["sealed","noCopy"]],
	/*----------------------------------------------------------------------------
	Protected: getStackTrace
    
    	--- Prototype --- 
    	call ["getStackTrace"]
    	---

		Because this object is a <Static> (read-only) <HashmapObject>, it can't hold
		references to other objects without making them read-only also. This method
		therefore is generated at instantiation to return the stack from it's stored 
		location. See also : <initStackLocation>

    Returns: 
		<HashmapObject> - of type <XPS_typ_Stack> 
	-----------------------------------------------------------------------------*/
	["getStackTrace",{}],
	/*----------------------------------------------------------------------------
	Protected: initStackLocation
    
    	--- Prototype --- 
    	call ["initStackLocation"]
    	---

		Generates a random unique ID to store the <XPS_typ_Stack> <HashmapObject>
		at runtime and also generates the code block for <getStackTrace> to retrieve 
		the <XPS_typ_Stack> <HashmapObject>.

    Returns: 
		Nothing 
	-----------------------------------------------------------------------------*/
	["initStackLocation",{
		private _uid = [6] call XPS_fnc_createUniqueID;
		private _stackVar = "xps_" + _uid + "_stack";
		_self set ["getStackTrace",compilefinal format["%1",_stackVar]];
		private _def = [
			["#str", {_self get "#type"}],
			["#type", "XPS_typ_CustomStack"],
			["@interfaces", ["XPS_ifc_IStack","XPS_ifc_IOrderedCollection"]],
			["_stackArray",[]],
			["#create",{
				_self set ["_stackArray",[]];
			}],
			["Clear",{
				_self get "_stackArray" resize 0;
			}],
			["Count",{
				count (_self get "_stackArray");
			}],
			["IsEmpty",{
				count (_self get "_stackArray") == 0;
			}],
			["Peek",{
				_self get "_stackArray" select -1;
			}],
			["Pop",{
				_self get "_stackArray" deleteat -1;
			}],
			["Push",{
				// params ["_value"];
				private _stack = _self get "_stackArray";
				
				while {count _stack > 100} do {
					_stack deleteat 0; 
				};
				_stack pushback _this;
				diag_log _this;
			}]
		];

		call compile format["%1 = createhashmapobject [%2];",_stackVar,_def];
	}],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	createhashmapobject [XPS_typ_MissionDebugger]
    	---

	Parameters: 
		none

    Returns: 
		Nothing 
	-----------------------------------------------------------------------------*/
	["#create",{
		_self call ["initStackLocation"];
		// addMissionEventHandler ["ScriptError",{
		// 	_this#0 call ["Flush"]; 
		// },[_self]];

		nil;
	}],
	/*----------------------------------------------------------------------------
	Method: AddToStackTrace
    
    	--- Prototype --- 
    	call ["AddToStackTrace",_value]
    	---

	Parameters: 
		_value - <Anything> - that can be converted to a <String> by the <str: https://community.bistudio.com/wiki/str> command

    Returns: 
		Nothing 
	-----------------------------------------------------------------------------*/
	["AddToStackTrace",{
		// params ["_value"];

		private _stack = _self call ["getStackTrace"];
		_stack call ["Push",_this];
	}],
	/*----------------------------------------------------------------------------
	Method: Flush
    
    	--- Prototype --- 
    	call ["Flush"]
    	---

		Flushes the stack and logs the values to RPT file if logging is enabled

	Parameters: 
		none

    Returns: 
		Nothing 
	-----------------------------------------------------------------------------*/
	["Flush",{
		private _stack = _self call ["getStackTrace"];
		_level = 1;
		while {count _stack > 0} do {
			private _value = _stack call ["Pop"];
			private _string = [str _value,_value] select (_value isEqualType "");
			for "_n" from 1 to _level do {
				_string = "  " + _string;
			};
			if (_level == 1) then {diag_log text "XPS_MissionDebugger: "};
			diag_log text _string;
			_level = _level + 1;
		};
	}]
]