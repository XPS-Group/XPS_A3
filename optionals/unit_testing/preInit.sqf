#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: unit_testing. XPS_UT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, False once preInit starts, True if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS UT preInit]";

// Singleton Class Instantiations ------------------------------------------
/* -------------------------------------------------------------------------
Variable: unit_testing. XPS_UT_Engine
	<Singleton>

Description:
	A <HashmapObject> which is used to perform and record Unit Tests

	See <XPS_UT_typ_Engine> for more info on operations.

Returns: 
	<Singleton> - of <XPS_UT_typ_Engine>
---------------------------------------------------------------------------*/
["XPS_UT_Engine",XPS_UT_typ_Engine,["XPS_UT_typ_TestClass"]] call XPS_fnc_createSingleton;

// Static Class Instantiations --------------------------------------------
/* -------------------------------------------------------------------------
Variable: unit_testing. XPS_UT_Assert
	<Static>

Description:
	Used in Unit Testing Test Methods to test various conditions and return 
	a <core. XPS_ifc_IException> object upon failure.

	See <XPS_UT_typ_Assert> for more info on operations.

Returns: 
	<Static> - of <XPS_UT_typ_Assert>
---------------------------------------------------------------------------*/
XPS_UT_Assert = compilefinal createhashmapobject [XPS_UT_typ_Assert];

// Load Unit Test Classes --------------------------------------------------

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [configFile >> QXPS_UT_CFG_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [missionConfigFile >> QXPS_UT_CFG_BASECLASSNAME];

{
	if (isClass _x) then {_result = [_x] call XPS_fnc_parseUnitTestClass;};
} foreach configProperties [campaignConfigFile >> QXPS_UT_CFG_BASECLASSNAME];

diag_log text "[XPS UT preInit End]";

ADDON = true;