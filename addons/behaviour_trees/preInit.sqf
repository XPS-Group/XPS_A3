#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log (text "[XPS BT preInit]");

/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT_Status

Description:
	A Helper class for an <Enumeration> set

	- <XPS_BT_Status_Success> 
	- <XPS_BT_Status_Failure> 
	- <XPS_BT_Status_Running> 

Returns: 
	<HashmapObject> - of type <XPS_BT_enum_Status>
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT_Status_Success 
	<Enumeration> 

Keys: 
	Name - "Success"
	Value - "SUCCESS"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT_Status_Failure
	<Enumeration> 

Keys: 
	Name - "Failure"
	Value - "FAILURE"
---------------------------------------------------------------------------*/
/* -------------------------------------------------------------------------
Variable: behaviour_trees. XPS_BT_Status_Running 
	<Enumeration> 

Keys: 
	Name - "Running"
	Value - "RUNNING"
---------------------------------------------------------------------------*/
["XPS_BT_Status",XPS_BT_enum_Status] call XPS_fnc_createEnumeration;

diag_log (text "[XPS BT preInit End]");

ADDON = true;