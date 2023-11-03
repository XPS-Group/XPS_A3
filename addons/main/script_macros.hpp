#define Q(var1) #var1

#define ADDON PREFIX##_##COMPONENT

/* ---------------------------------------*/
//Type Definitions and Interfaces
#define VARNAME(var1,var2,var3) var1##_##var2##_##var3

#define FILEPATH(var1,var2,var3) \ROOT\var1\addons\var2\var3
#define FILEPATH_C(var1) FILEPATH(PREFIX,COMPONENT,var1)
#define FILEPATH_C_Q(var1) Q(FILEPATH_C(var1))

#define COMPONENT_DIR Q(##@##ADDON)

#define XPS_CFG_I_BASECLASSNAME Enhanced_XPS_Interfaces
#define QXPS_CFG_I_BASECLASSNAME Q(XPS_CFG_I_BASECLASSNAME)

#define XPS_CFG_TD_BASECLASSNAME Enhanced_XPS_Type_Definitions
#define QXPS_CFG_TD_BASECLASSNAME Q(XPS_CFG_TD_BASECLASSNAME)

#define XPS_MAIN_FNC(fncName) VARNAME(PREFIX,fnc,fncName) = compileScript [FILEPATH_C_Q(functions\fncName.sqf)]
#define XPS_ADDON_FNC(fncName) VARNAME(ADDON,fnc,fncName) = compileScript [FILEPATH_C_Q(functions\fncName.sqf)]
#define XPS_MAIN_FNC_SUB(sub,fncName) VARNAME(PREFIX,fnc,fncName) = compileScript [FILEPATH_C_Q(functions\sub\fncName.sqf)]
#define XPS_ADDON_FNC_SUB(sub,fncName) VARNAME(ADDON,fnc,fncName) = compileScript [FILEPATH_C_Q(functions\sub\fncName.sqf)]

#define XPS_CFG_FNC(fncName) class fncName {\
    file = FILEPATH_C_Q(functions\fncName.sqf);\
    headerType = 0;\
    recompile = 0;\
}

#define XPS_CFG_FNC_SUB(sub,fncName) class fncName {\
    file = FILEPATH_C_Q(functions\sub\fncName.sqf);\
    headerType = 0;\
    recompile = 0;\
}

#define XPS_CFG_IFC(ifcName) class ifcName {\
    file = FILEPATH_C_Q(interfaces\ifcName.sqf);\
    type = "ifc";\
    recompile = 1;\
    isFinal = 0;\
}

#define XPS_CFG_IFC_SUB(sub,ifcName) class ifcName {\
    file = FILEPATH_C_Q(interfaces\sub\ifcName.sqf);\
    type = "ifc";\
    recompile = 1;\
    isFinal = 0;\
}

#define XPS_CFG_TYP(typName) class typName {\
    file = FILEPATH_C_Q(typedefs\typName.sqf);\
    type = "typ";\
    preprocess = 1;\
    allowNils = 0;\
    noStack = 1;\
    recompile = 1;\
    isFinal = 0;\
}

#define XPS_CFG_TYP_SUB(sub,typName) class typName {\
    file = FILEPATH_C_Q(typedefs\sub\typName.sqf);\
    type = "typ";\
    preprocess = 1;\
    allowNils = 0;\
    noStack = 1;\
    recompile = 1;\
    isFinal = 0;\
}

/* ---------------------------------------*/
//Interface Checcking
#define CHECK_IFC1(var1,ifc1) [var1,[Q(ifc1)]] call XPS_fnc_checkInterface
#define CHECK_IFC2(var1,ifc1,ifc2) [var1,[Q(ifc1),Q(ifc2)]] call XPS_fnc_checkInterface
#define CHECK_IFC3(var1,ifc1,ifc2,ifc3) [var1,[Q(ifc1),Q(ifc2),Q(ifc3)]] call XPS_fnc_checkInterface