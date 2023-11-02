#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_MissionCodeStackr
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
	["#type", "XPS_typ_MissionCodeStack"],
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
		<Nothing> 
	-----------------------------------------------------------------------------*/
	["initStackLocation",{
		private _stackVar = "xps_stack_" + ([4] call XPS_fnc_createUniqueID);
		_self set ["getStackTrace",compilefinal format["%1",_stackVar]];
		call compile format["%1 = createhashmapobject [XPS_typ_Stack]",_stackVar];
	}],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	createhashmapobject [XPS_typ_MissionCodeStack]
    	---

	Parameters: 
		none

    Returns: 
		<Nothing> 
	-----------------------------------------------------------------------------*/
	["#create",{
		_self call ["initStackLocation"];
		addMissionEventHandler ["ScriptError",{
			_this call ["Flush"]; 
		},_self];
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
		<Nothing> 
	-----------------------------------------------------------------------------*/
	["AddToStackTrace",{
		params ["_value"];

		private _stack = _self call ["getStackTrace"];
		_stack call ["Push",_value];
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
		<Nothing> 
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
			if (_level == 1) then {diag_log text "XPS_MissionCodeStack: "};
			diag_log text _string;
			_level = _level + 1;
		};
	}]
]