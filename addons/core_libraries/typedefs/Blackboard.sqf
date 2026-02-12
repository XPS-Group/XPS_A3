#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Blackboard
	<TypeDefinition>
    	--- Prototype --- 
		XPS_typ_Blackboard : XPS_ifc_IBlackboard
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_typ_Blackboard",[_object*,_varName*]]
    	---

Authors: 
	Crashdome

Description:
	Allows storage of values as keys as any other hashmap but, has a method to
	attach to an object through setvariable if needed. 

Optionals: 
	_object* - <Object> - (Optional - Default : objNull) See: <AttachToObject>
	_varName* - <String> - (Optional - Default : "XPS_Blackboard") See: <AttachToObject>

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Blackboard"],
	/*-----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create",[_object*,_varName*]]
    	---
    
    Optionals: 
		_object* - <Object> or <Group> - (Optional - Default : objNull) See: <AttachToObject>
    	_varName* - <String> - (Optional - Default : "XPS_Blackboard") See: <AttachToObject>

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_object",objNull,[objNull,grpnull]],["_varName","XPS_Blackboard",[""]]];
		if !(isNull _object) then {_self call ["AttachToObject",[_object,_varName]]};
	}],
	
	/*-----------------------------------------------------------------------------
	Constructor: #delete
    
    	--- Prototype --- 
    	call ["#delete"]
    	---
    
    Description:
		Removes this object from it's attachedTo namespace and any references to it if exists

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#delete", compileFinal {
		if !(isNull (_self get "attachedTo")) then {
			_self get "attachedTo" setVariable [_self get "attachedTo_VariableName",nil];
			_self set ["attachedTo",objNull];
		};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_typ_Blackboard"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_ifc_IBlackboard>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IBlackboard"]],
	["attachedTo",objNull],
	["attachedTo_VariableName",nil],
	/*-----------------------------------------------------------------------------
	Method: AttachToObject 
    
    	--- Prototype --- 
    	call ["AttachToObject ",[_object*,_varName*]]
    	---
		
		<XPS_ifc_IBlackboard>
    
    Optionals: 
		_object* - <Object> or <Group> - (Optional - Default : objNull) - Object to attach this blackboard to. 
	Subsequent calls to this method will remove it from an object if already attached.
	To remove it completely from an object without attaching to another, call without any argument
    	_varName* - <String> - (Optional - Default : "XPS_Blackboard") - Variable Name 
	to use when attaching to object with setVariable. Blackboard can then be retrieved from the object by using 
		---code
		_object getVariable _varName;
		--- 
	-----------------------------------------------------------------------------*/
	["AttachToObject",compileFinal {
		params [["_object",objNull,[objNull,grpnull]],["_varName","XPS_Blackboard",[""]]];
		private _prevObject = _self get "attachedTo";
		private _prevObjectVar = _self get "attachedTo_VariableName";
		if !(isNull _prevObject) then {_prevObject setVariable [_prevObjectVar,nil]; };
		if !(isnull _object) then {_object setVariable [_varName,_self];};
		_self set ["attachedTo",_object];
		_self set ["attachedTo_VariableName",_varName];
	}]
]
