#include "\x\xps\addons\main\script_macros.hpp"

#define XPS_UT_CFG_BASECLASSNAME Enhanced_XPS_Unit_Testing
#define QXPS_UT_CFG_BASECLASSNAME Q(XPS_UT_CFG_BASECLASSNAME)

#define XPS_UT_CFG_TEST(typName) class typName {\
    file = FILEPATH_C_Q(unittests\typName.sqf);\
}

#define XPS_UT_CFG_TEST_SUB(sub,typName) class typName {\
    file = FILEPATH_C_Q(unittests\sub\typName.sqf);\
}