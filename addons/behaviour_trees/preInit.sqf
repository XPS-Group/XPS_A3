#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT

Description:
	This returns true once preInit has been completed

Returns: <Boolean>
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS BT preInit]";

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT_Result

Description:
	A Helper class for an <Enumeration> set (see Below)

	- <XPS_BT_Result_Success> 
	- <XPS_BT_Result_Failed> 
	- <XPS_BT_Result_Running> 

Returns: 
	<HashmapObject> of type <behaviour_trees. XPS_BT_typ_Result>

Variable: behaviour_trees. XPS_BT_Result_Success 
	<Enumeration> 

Keys:
	Name - "Success"
	Value - "SUCCESS"

Variable: behaviour_trees. XPS_BT_Result_Failed 
	<Enumeration> 

Keys:
	Name - "Failure"
	Value - "FAILURE"

Variable: behaviour_trees. XPS_BT_Result_Running 
	<Enumeration> 

Keys:
	Name - "Running"
	Value - "RUNNING"
---------------------------------------------------------------------------*/
["XPS_BT_Result",XPS_BT_typ_Result] call XPS_fnc_createEnumeration;

diag_log text "[XPS BT preInit End]";

ADDON = true;