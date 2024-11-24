#include "script_component.hpp"

/* -------------------------------------------------------------------------
Variable: unit_testing. XPS_UT

Description:
	This returns true once preInit has been completed

Returns: 
	<Boolean> - Nil prior to preInit function, <False> once preInit starts, <True> if preInit has completed
---------------------------------------------------------------------------*/
ADDON = false;

diag_log text "[XPS UT preInit]";

// Singleton Class Instantiations ------------------------------------------
/* -------------------------------------------------------------------------
Variable: unit_testing. XPS_UT_TestClasses
	<Singleton>

Description:
	A <HashmapObject> which is used to perform and record Unit Tests

	See <XPS_UT_typ_TestClasses> for more info on operations.

Returns: 
	<Singleton> - of <XPS_UT_typ_TestClasses>
---------------------------------------------------------------------------*/
if (isNil "XPS_UT_TestClasses") then {["XPS_UT_TestClasses",XPS_UT_typ_TestClasses,["XPS_UT_typ_TestClass"]] call XPS_fnc_createSingleton;};

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
if (isNil "XPS_UT_Assert") then {XPS_UT_Assert = compileFinal createHashmapObject [XPS_UT_typ_Assert];};

XPS_UT_TestClasses call ["GetInstance"] call ["LoadClasses"];

diag_log text "[XPS UT preInit End]";

ADDON = true;