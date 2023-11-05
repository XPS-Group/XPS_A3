#include "script_component.hpp"

ADDON = false;

// 

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
	a <XPS_UT_ifc_IException> object upon failure.

	See <XPS_UT_typ_Assert> for more info on operations.

Returns: 
	<Static> - of <XPS_UT_typ_Assert>
---------------------------------------------------------------------------*/
["XPS_UT_Assert","typedefs\Assert.sqf"] call XPS_fnc_createStaticFromFile;

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
ADDON = true;