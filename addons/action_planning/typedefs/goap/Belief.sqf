#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Belief
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Belief : XPS_AP_ifc_Belief, XPS_AP_typ_Belief
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
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_cond",{false},[{}]],["_loc",[0,0,0],[[]],[2,3]]]) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"#create","Arguments supplied were invalid.",_this]];};
		
		_self set ["_condition",_cond];
		_self set ["_location",_loc];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_ADDON_typ_Belief"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IBelief>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IBelief"]],

	["_condition", compileFinal {false}],
	["_location",[0,0,0]],
	/*----------------------------------------------------------------------------
	Method: GetLocation
    
    	--- Prototype --- 
    	call ["GetLocation"]
    	---
    
    Returns:
		<ARRAY> - a 2d or 3d position
	-----------------------------------------------------------------------------*/
    ["GetLocation",{_self get "_location"}],
	/*----------------------------------------------------------------------------
	Method: Evaluate
    
    	--- Prototype --- 
    	call ["Evaluate",_args*]
    	---
    
	Evaluates the condition

    Optionals: 
		_args* - <Anything> - (Optional - Default : []) - arguments to supply to condition (if needed) 
		
	Returns:
		<Boolean> - the result of the condition check
	-----------------------------------------------------------------------------*/
    ["Evaluate",{_self call ["_condition",_this];}]    
]