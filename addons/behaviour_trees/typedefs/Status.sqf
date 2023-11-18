#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_enum_Status
	<TypeDefinition>
		---prototype
		XPS_BT_enum_Status : XPS_ifc_IEnumeration, XPS_typ_Enumeration
		---

Authors: 
	Crashdome

Description:
	An Enumeration set for node statuses.

	See <XPS_fnc_createEnumeration> for more info on usage of types inheriting this type

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_enum_Status"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_Enumeration>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_Enumeration],
	/*----------------------------------------------------------------------------
	Property: Names
		<XPS_typ_Enumeration.Names>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: ValueType
    
    	--- Prototype --- 
    	get "ValueType"
    	---
    
    Returns: 
		<String> - "<STRING>"
	-----------------------------------------------------------------------------*/
	["ValueType","STRING"],
	["Enumerations", [["Success","SUCCESS"], ["Failure","FAILURE"], ["Running","RUNNING"]]]
	/*----------------------------------------------------------------------------
	Property: Values
		<XPS_typ_Enumeration.Values>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetEnum
		<XPS_typ_Enumeration.GetEnum>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: IsDefined
		<XPS_typ_Enumeration.IsDefined>
	-----------------------------------------------------------------------------*/
]