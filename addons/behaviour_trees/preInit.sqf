#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS BT preInit]";

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_NodeType

Description:
	A Helper class for an <Enumeration> set

	- <XPS_NodeType_Leaf> 
	- <XPS_NodeType_Decorator> 
	- <XPS_NodeType_Composite> 

Returns: 
	<HashmapObject> - of type <XPS_enum_NodeType>
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_NodeType_Leaf 
	<Enumeration> 

Keys: 
	#str - "Leaf"
	Value - "LEAF"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_NodeType_Decorator
	<Enumeration> 

Keys: 
	#str - "Decorator"
	Value - "DECORATOR"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_NodeType_Composite 
	<Enumeration> 

Keys: 
	#str - "Composite"
	Value - "COMPOSITE"
---------------------------------------------------------------------------*/
["XPS_BT_NodeType",XPS_BT_enum_NodeType] call XPS_fnc_createEnumeration;

diag_log text "[XPS BT preInit End]";

ADDON = true;
