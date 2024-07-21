#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef:  core. XPS_enum_LifeTime
	<TypeDefinition>
		---prototype
		XPS_LifeTime : XPS_ifc_IEnumeration, XPS_typ_Enumeration
		---

Authors: 
	Crashdome

Description:
	An Enumeration set for <IServiceProviders>.

	--- code
	XPS_LifeTime_Transient	Transient	0
	XPS_LifeTime_Scoped		Scoped		1
	XPS_LifeTime_Singleton	Singleton	2
	---

	See <XPS_fnc_createEnumeration> for more info on usage of types inheriting this type

---------------------------------------------------------------------------- */
[
	["#type","XPS_enum_LifeTime"],
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
		<XPS_typ_Enumeration.ValueType>
	-----------------------------------------------------------------------------*/
	["Enumerations", ["Transient","Scoped","Singleton"]]
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