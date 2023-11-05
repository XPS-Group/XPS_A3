#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_createMissionDebugger
	
	---prototype
	_result = [_varName, _typeDefinition] call XPS_fnc_createMissionDebugger;
	---

Description:
   Creates a <singleton> which provides debugging 

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _varName
		
	Parameter: _typeDefinition
		

	Return: _result
		<Boolean> - True if created successfully

	Example: 

---------------------------------------------------------------------------- */
if !(params [["_varName",nil,[""]],["_typeDef",nil,[createhashmap,[]]]]) exitwith {false};

_result = true;
if (_typeDef isEqualType []) then {
	_typeDef = createhashmapfromarray _typeDef;
};

if (_typeDef get "@interfaces" in ["XPS_typ_Debugger"])

if (_result) then {_result = [_varName,_typeDef] call XPS_fnc_createSingleton;};

_result;