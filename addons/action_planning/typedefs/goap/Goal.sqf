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
	["#create",{        
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_index",call XPS_fnc_createUniqueID,[""]],["_pri",0,[0]]]) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"#create","Arguments supplied were invalid.",_this]];};
        
        _self set ["_priority",_pri];
		_self set ["Index",_index];

        _self set ["DesiredEffects", createhashmap];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Goal"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IGoal>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IGoal"]],
    ["_priority",0],
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
	["Index",nil],
	["DesiredEffects",createhashmap],
	["GetPriority", compileFinal {_self get "__priority"}]
    
]

