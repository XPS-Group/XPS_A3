#include "\x\cba\addons\main\script_macros_common.hpp"
#define COMPONENT_DIR QUOTE(##@##ADDON)
#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
    #define PREP_F(fncName) TRIPLES(ADDON,fnc,var1) = compileScript [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)]
    #define PREPMAIN_F(fncName) TRIPLES(PREFIX,fnc,var1) = compileScript [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)]
#else
    #define PREP_F(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
    #define PREPMAIN_F(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNCMAIN(fncName)] call CBA_fnc_compileFunction
#endif

#ifdef DISABLE_COMPILE_CACHE
    #define SUBPREP_F(sub,fncName) TRIPLES(ADDON,fnc,var1) = compileScript [QPATHTOF(functions\sub\DOUBLES(fnc,fncName).sqf)]
    #define SUBPREPMAIN_F(sub,fncName) TRIPLES(PREFIX,fnc,var1) = compileScript [QPATHTOF(functions\sub\DOUBLES(fnc,fncName).sqf)]
#else
    #define SUBPREP_F(sub,fncName) [QPATHTOF(functions\sub\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
    #define SUBPREPMAIN_F(sub,fncName) [QPATHTOF(functions\sub\DOUBLES(fnc,fncName).sqf), QFUNCMAIN(fncName)] call CBA_fnc_compileFunction
#endif

#define PATHTO_FNC_F(fncName) class fncName {\
    file = QPATHTOF(functions\DOUBLES(fnc,fncName).sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}
#define SUBPATHTO_FNC_F(sub,fncName) class fncName {\
    file = QPATHTOF(functions\sub\DOUBLES(fnc,fncName).sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}