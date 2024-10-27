#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_ActionUAsync
	<TypeDefinition>
	---prototype
	XPS_AP_typ_ActionUAsync : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_ActionUAsync, [_var1*, _var2*]]
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
	["#type","XPS_AP_typ_ActionUAsync"],
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
	["#create", {}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_ActionUAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction"]],
	["_complete",false],
	["_startTime",-1],
	["condition", compileFinal {true}],
	["timeout",0],
	/*----------------------------------------------------------------------------
	Protected: myProp
    
    	--- Prototype --- 
    	get "myProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: MyProp
    
    	--- Prototype --- 
    	get "MyProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: MyMethod
    
    	--- Prototype --- 
    	call ["MyMethod",[_object*,_var1*]]
    	---
    
    Optionals: 
		_object* - <Object> - (Optional - Default : objNull) 
		_var1* - <String> - (Optional - Default : "") 
	-----------------------------------------------------------------------------*/

	["Action", {}],
    ["CanPerform", compileFinal {false}],
    ["IsComplete", compileFinal {
		if (diag_tickTime > ((_self get "timeout") + (_self get "_startTime")) || {_self call ["condition",_this]}): {
			true;
		} else {
			false;
		};
	}],
	["Execute", {	
		if (_self call ["CanPerform"] && {_self get "_startTime" isEqualTo -1}) then {
			_self set ["_startTime",diag_tickTime];
			_self call ["Action",_this];
		};
	}]    
]