#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_OperatorSAsync
	<TypeDefinition>
	---prototype
	XPS_AP_typ_OperatorSAsync : XPS_AP_ifc_Operator
	---
	---prototype
	createhashmapobject [XPS_AP_typ_OperatorSAsync, []]
	---

Authors: 
	CrashDome

Description:
	An asynchronous version of <XPS_AP_typ_Action> where the result 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_OperatorSAsync"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_OperatorSAsync"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_IAction>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_IAction"]],
	["handle",nil],
	["callback",compileFinal {
		_self set ["handle",nil];
	}],
	["Execute", {	
		if (isNil {_self get "handle"} && isNil {_self get "Status"}) then {	
			_self call ["preTick",_this];	
				_handle = [_self,_this] spawn {
					params ["_Operator","_context"];
					private _status = _Operator call ["processTick",_context]; 
					_Operator call ["callback",_status]
				};
				_self set ["handle",_handle];
			_self call ["postExecute",_self get "Status"];
		};
		if (scriptDone (_self get "handle")) then {
			_self set ["handle",nil];
			_self call ["postExecute",XPS_Status_Failure];
		};
		_self get "Status";
	}]
    
]