#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_BT_enum_NodeType
	<TypeDefinition>
		---prototype
		XPS_BT_enum_NodeType : XPS_ifc_IEnumeration, XPS_typ_Enumeration
		---

Authors: 
	Crashdome

Description:
	An Enumeration set for node types.

	--- code
	XPS_BT_NodeType_Leaf		Leaf		LEAF
	XPS_BT_NodeType_Decorator	Decorator	DECORATOR
	XPS_BT_NodeType_Composite	Composite	COMPOSITE
	---

	See <XPS_fnc_createEnumeration:core. typeHandlers. XPS_fnc_createEnumeration> for more info on usage of types inheriting this type

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_enum_NodeType"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<core.XPS_typ_Enumeration>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_Enumeration],
	/*----------------------------------------------------------------------------
	Property: Names
		<core.XPS_typ_Enumeration.Names>
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
	["Enumerations", [["Leaf","LEAF"], ["Decorator","DECORATOR"], ["Composite","COMPOSITE"]]]
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
