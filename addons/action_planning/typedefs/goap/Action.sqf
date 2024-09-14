#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Action
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Action : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_Action, [_var1*, _var2*]]
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
	["#type","XPS_AP_typ_Action"],
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
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_index",call XPS_fnc_createUniqueID,[""]],["_cost",0,[0]],["_strategy",createhashmap,[createhashmap]]]) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"#create","Arguments supplied were invalid.",_this]];};
        if !(CHECK_IFC1(_strategy,XPS_AP_ifc_IActionStrategy)) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"#create","Strategy supplied does not implement XPS_AP_ifc_IActionStrategy.",_this]];};
		
        _self set ["_actionCost",_cost];
        _self set ["_actionStrategy",_strategy];
		_self set ["Index",_index];
        _self set ["Effects", createhashmap];
        _self set ["Preconditions", createhashmap];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Action"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction","XPS_ifc_IAstarNode"]],
    ["_actionCost",0],
    ["_actionStrategy",nil],
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
	["Index",""],
	["Effects",createhashmap],
	["Preconditions",createhashmap],
	["GetCost", compileFinal {_self get "_actionCost"}],
	["IsComplete", compileFinal {self get "_actionStrategy" call ["IsComplete"]}],
	["Execute", compileFinal {self get "_actionStrategy" call ["Execute"]}]
    
]

