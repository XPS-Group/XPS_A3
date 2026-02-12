#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_ActionUAsync
	<TypeDefinition>
	---prototype
	XPS_AP_typ_ActionUAsync : XPS_AP_ifc_Action
	---
	---prototype
	createhashmapobject [XPS_AP_typ_ActionUAsync, []]
	---

Authors: 
	CrashDome

Description:
	(Description)

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_ActionUAsync"],
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
	["_startTime",-1],
	["condition", compileFinal {true}],
	["timeout",0],
	/*----------------------------------------------------------------------------
	Method: Halt
    
    	--- Prototype --- 
    	call ["Halt"]
    	---

	Description:
		Halts any asynchronous call by invoking a failure and setting <starttime> to 0

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["Halt",compileFinal {		
		_self call ["postExecute", XPS_Status_Failure];
	}],
	["Execute", {	
		switch (true) do {

			case (isNil {_self get "Status"}): {
				_self call ["preExecute",_this];
				_self call ["action",_this];
			};
			case (diag_tickTime > ((_self get "timeout") + (_self get "_startTime")));
			case (_self call ["condition",_this]): {
				_self call ["postExecute",_self call ["result",_this]];
			};
		};
	}]    
]
