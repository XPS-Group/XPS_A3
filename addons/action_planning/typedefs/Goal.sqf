#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Goal
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Goal : XPS_AP_ifc_Goal
	---
	---prototype
	createhashmapobject [XPS_AP_typ_Goal, [_var1*, _var2*]]
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
	["#type","XPS_AP_typ_Goal"],
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
    	"XPS_AP_typ_Goal"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IGoal>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IGoal"]],
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
	["DesiredEffects",createhashmap]    
]

