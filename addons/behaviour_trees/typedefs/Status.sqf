#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: behaviour_trees. XPS_BT_enum_Status
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	An Enumeration set for node statuses.

Parent:
    <core. XPS_typ_Enumeration>

Implements:
	None 

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_BT_enum_Status"],
	["#base",XPS_typ_Enumeration],
	["ValueType","STRING"],
	["Enumerations", [["Success","SUCCESS"], ["Failure","FAILURE"], ["Running","RUNNING"]]]
]