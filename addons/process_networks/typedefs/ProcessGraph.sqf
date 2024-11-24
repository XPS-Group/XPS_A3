#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_ProcessGraph
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_ProcessGraph : XPS_PN_ifc_IProcessGraph
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_ProcessGraph"]
    	---

Authors: 
	Crashdome

Description:

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_ProcessGraph"],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_ProcessGraph"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IProcessGraph>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_PN_ifc_IProcessGraph"]],
	/*----------------------------------------------------------------------------
	Flags: #flags
		unscheduled
	----------------------------------------------------------------------------*/
	["#flags",["unscheduled"]]
]