#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: main. XPS_typ_Blackboard
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Allows storage of values as keys as any other hashmap but, has a method to
	attach to an object through setvariable if needed. 

Parent:
	none

Implements: 
	<XPS_ifc_IBlackboard>

Flags: 
	none

---------------------------------------------------------------------------- */
[
	["#str",compileFinal {"XPS_typ_Blackboard"}],
	["#type","XPS_typ_Blackboard"],
	["@interfaces",["XPS_ifc_IBlackboard"]],
	["attachedTo",nil],
	["attachedTo_VariableName",nil],
	/*-----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_typ_Blackboard",[_object*,_varName*]]
    	---
    
    Optionals: 
		_object* - <Object> - (Optional - Default : objNull) See: <AttachToObject>
    	_varName* - <String> - (Optional - Default : "XPS_Blackboard") See: <AttachToObject>

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_object",objNull,[objNull]],["_varName","XPS_Blackboard",[""]]];
		_self call ["AttachToObject",[_object,_varName]];
	}],
	/*-----------------------------------------------------------------------------
	Method: AttachToObject 
    
    	--- Prototype --- 
    	call ["AttachToObject ",[_object*,_varName*]]
    	---
		
		<XPS_ifc_IBlackboard>
    
    Optionals: 
		_object* - <Object> - (Optional - Default : objNull) - Object to attach this blackboard to. 
	Subsequent calls to this method will remove it from an object if already attached.
	To remove it completely from an object without attaching to another, call without any argument
    	_varName* - <String> - (Optional - Default : "XPS_Blackboard") - Variable Name 
	to use when attaching to object with setVariable. Blackboard can then be retrieved from the object by using 
		---code
		_object getVariable _varName;
		--- 
	-----------------------------------------------------------------------------*/
	["AttachToObject",compileFinal {
		params [["_object",objNull,[objNull]],["_varName","XPS_Blackboard",[""]]];
		private _prevObject = _self get "attachedTo";
		private _prevObjectVar = _self get "attachedTo_VariableName";
		if !(isNull _prevObject) then {_prevObject setVariable [_prevObjectVar,nil]; };
		if !(isnull _object) then {_object setVariable [_varName,_self];};
		_self set ["attachedTo",_object];
		_self set ["attachedTo_VariableName",_varName];
	}]
]