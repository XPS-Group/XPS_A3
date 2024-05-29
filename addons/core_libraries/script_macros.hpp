#include "\x\xps\addons\main\script_macros.hpp"

#define XPS_CFG_ENUM(typName) class typName {\
    file = FILEPATH_C_Q(typedefs\typName.sqf);\
    type = "enum";\
    preprocess = 1;\
    allowNils = 1;\
    noStack = 1;\
    preCache = 1;\
    recompile = 0;\
    isFinal = 1;\
}

#define XPS_CFG_ENUM_SUB(sub,typName) class typName {\
    file = FILEPATH_C_Q(typedefs\sub\typName.sqf);\
    type = "enum";\
    preprocess = 1;\
    allowNils = 1;\
    noStack = 1;\
    preCache = 1;\
    recompile = 0;\
    isFinal = 1;\
}