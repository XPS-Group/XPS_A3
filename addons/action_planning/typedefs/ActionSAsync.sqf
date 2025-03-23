#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_ActionSAsync
	<TypeDefinition>
	---prototype
	XPS_AP_typ_ActionSAsync : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_ActionSAsync, [_var1*, _var2*]]
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
	["#type","XPS_AP_typ_ActionSAsync"],
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
    	"XPS_AP_typ_ActionSAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction"]],
	["_complete",false],
	["_handle",nil],
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
	["callback",compileFinal {
		_self set ["_complete",_this];
		_self set ["_handle",nil];
	}],
	["Action", {}],
    ["CanPerform", compileFinal {false}],
    ["IsComplete", compileFinal {_self get "_complete"}],
	["Execute", {	
		if (isNil {_self get "_handle"} && {!(_self get "_complete")}) then {
			_handle = _self spawn {
				_this call ["callback",_this call ["Action"]]
			};
			_self set ["_handle",_handle];
		};
	}]
    
]