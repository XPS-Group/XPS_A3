#include "\x\xps\addons\core\script_macros.hpp"

#define XPS_UT_CFG_BASECLASSNAME XPS_Unit_Testing
#define QXPS_UT_CFG_BASECLASSNAME XPS_STR(XPS_UT_CFG_BASECLASSNAME)

#define XPS_UT_CFG_TEST(typName) class typName {\
    file = XPS_FILEPATH_C_STR(unittests\typName.sqf);\
}

#define XPS_UT_CFG_TEST_SUB(sub,typName) class typName {\
    file = XPS_FILEPATH_C_STR(unittests\sub\typName.sqf);\
}
