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
		params [["inputQueues",createhashmap,[createhashmap]],["_outputQueues",createhashmap,[createhashmap]]];
		_self set ["inputQueues",_in];
		_self set ["outputQueues",_out];
	}],
	["#flags",["unscheduled"]],
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
	["CanProcess", compileFinal {}],
	["Process",{}]
]