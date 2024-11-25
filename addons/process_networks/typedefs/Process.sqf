#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_Process
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_Process : XPS_PN_ifc_IProcess
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_Process"]
    	---

Authors: 
	Crashdome

Description:

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_Process"],
	["#create", compileFinal {
		params [["_inputs",createhashmap,[createhashmap]],["_outputs",createhashmap,[createhashmap]]];

		
		_self set ["inputQueues",_inputs];
		_self set ["outputQueues",_outputs];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		unscheduled
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_Process"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IProcess>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_PN_ifc_IProcess"]],
	["_inputQueues",nil],
	["_outputQueue",nil],
	/*----------------------------------------------------------------------------
	Property: Id
    
    	--- Prototype --- 
    	get "Id"
    	---  

	Returns:
		<String> - identifier of this process object 
	-----------------------------------------------------------------------------*/
    ["Id", nil],
	["CanProcess", compileFinal {}],
	["Process",{}]
]