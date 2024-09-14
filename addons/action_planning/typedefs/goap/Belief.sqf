#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Belief
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Belief : XPS_AP_ifc_Belief
	---
	---prototype
	createhashmapobject [XPS_AP_typ_Belief, [_var1*, _var2*]]
	---

Authors: 
	CrashDome

Description:
	(Description)

    
Optionals: 
	_var1* - <Object> - (Optional - Default : objNull) 
	_var2* - <String> - (Optional - Default : "") 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_Belief"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",{
		params [["_name",nil,[""]]/*,["_condition",nil,[{}]],["_apply",nil,[{}]]*/];
		if !(isNil "_name") then {_self set ["Name",_name]};

		// if !(isNil "_condition") then {_self set ["condition",_condition]};
		// if !(isNil "_apply") then {_self set ["apply",_apply]};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_ADDON_typ_Belief"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{(_self get "#type" select 0) + " : " + (_self get "Name")}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IBelief>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IBelief"]],
	["#flags",["sealed","noCopy","unscheduled"]],

	["Name","(unnamed)"],

    ["Evaluate",{
		params ["_context","_key",["_defaultValue",false,[true]]];
		_context getOrDefault [_key, _defaultValue];
	}],
	["Apply",{
		params ["_context","_key","_value"];
		_context set [_key,_value];
	}],
	["Update",{
		//params ["_context","_key","_value"];
		_self call ["Apply",_this];
	}]
]