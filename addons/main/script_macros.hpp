#define XPS_STR(var1) #var1

#define ADDON PREFIX##_##COMPONENT
#define XPS_PRESTART xps_prestart
#define XPS_PRESTART_VAR XPS_STR(XPS_PRESTART)

/* ---------------------------------------*/
//Type Definitions and Interfaces
#define VARNAME(var1,var2,var3) var1##_##var2##_##var3

#define XPS_FILEPATH(var1,var2,var3) \ROOT\var1\addons\var2\var3
#define XPS_FILEPATH_C(var1) XPS_FILEPATH(PREFIX,COMPONENT,var1)
#define XPS_FILEPATH_C_STR(var1) XPS_STR(XPS_FILEPATH_C(var1))

#define COMPONENT_DIR XPS_STR(##@##ADDON)

#define XPS_CFG_TD_BASECLASSNAME XPS_Type_Definitions
#define QXPS_CFG_TD_BASECLASSNAME XPS_STR(XPS_CFG_TD_BASECLASSNAME)

#define XPS_MAIN_FNC(fncName) VARNAME(PREFIX,fnc,fncName) = compileScript [XPS_FILEPATH_C_STR(functions\fncName.sqf)]
#define XPS_ADDON_FNC(fncName) VARNAME(ADDON,fnc,fncName) = compileScript [XPS_FILEPATH_C_STR(functions\fncName.sqf)]
#define XPS_MAIN_FNC_SUB(sub,fncName) VARNAME(PREFIX,fnc,fncName) = compileScript [XPS_FILEPATH_C_STR(functions\sub\fncName.sqf)]
#define XPS_ADDON_FNC_SUB(sub,fncName) VARNAME(ADDON,fnc,fncName) = compileScript [XPS_FILEPATH_C_STR(functions\sub\fncName.sqf)]

#ifdef __A3_DEBUG__
    #define XPS_DEBUG 1
#endif

#define XPS_CFG_FNC(fncName) class fncName {\
    file = XPS_FILEPATH_C_STR(functions\fncName.sqf);\
    headerType = 0;\
    recompile = 0;\
}

#define XPS_CFG_FNC_SUB(sub,fncName) class fncName {\
    file = XPS_FILEPATH_C_STR(functions\sub\fncName.sqf);\
    headerType = 0;\
    recompile = 0;\
}

#define XPS_CFG_FNC_NR(fncName) class fncName {\
    file = XPS_FILEPATH_C_STR(functions\fncName.sqf);\
    headerType = 0;\
    recompile = 0;\
}

#define XPS_CFG_FNC_SUB_NR(sub,fncName) class fncName {\
    file = XPS_FILEPATH_C_STR(functions\sub\fncName.sqf);\
    headerType = 0;\
    recompile = 0;\
}

#define XPS_CFG_IFC(ifcName) class ifcName {\
    file = XPS_FILEPATH_C_STR(typedefs\ifcName.sqf);\
    type = "ifc";\
    preCache = 1;\
    recompile = 0;\
    isFinal = 1;\
}

#define XPS_CFG_IFC_SUB(sub,ifcName) class ifcName {\
    file = XPS_FILEPATH_C_STR(typedefs\sub\ifcName.sqf);\
    type = "ifc";\
    preCache = 1;\
    recompile = 0;\
    isFinal = 1;\
}

#define XPS_CFG_TYP(typName) class typName {\
    file = XPS_FILEPATH_C_STR(typedefs\typName.sqf);\
    type = "typ";\
    preprocess = 1;\
    allowNils = 1;\
    noStack = 1;\
    preCache = 1;\
    recompile = 0;\
    isFinal = 1;\
}

#define XPS_CFG_TYP_SUB(sub,typName) class typName {\
    file = XPS_FILEPATH_C_STR(typedefs\sub\typName.sqf);\
    type = "typ";\
    preprocess = 1;\
    allowNils = 1;\
    noStack = 1;\
    preCache = 1;\
    recompile = 0;\
    isFinal = 1;\
}

/* ---------------------------------------*/
//Interface Checcking
#define XPS_CHECK_IFC1(var1,ifc1) [var1,[XPS_STR(ifc1)]] call XPS_fnc_checkInterface
#define XPS_CHECK_IFC2(var1,ifc1,ifc2) [var1,[XPS_STR(ifc1),XPS_STR(ifc2)]] call XPS_fnc_checkInterface
#define XPS_CHECK_IFC3(var1,ifc1,ifc2,ifc3) [var1,[XPS_STR(ifc1),XPS_STR(ifc2),XPS_STR(ifc3)]] call XPS_fnc_checkInterface

/* ---------------------------------------*/
//cfg3DEN preInit
#define XPS_CFG3DEN_FNC(tag) call tag##_fnc_preInit;
#define XPS_CFG3DEN_PREINIT(tag)	onTerrainNew = XPS_STR(XPS_CFG3DEN_FNC(tag));\
            onMissionNew = XPS_STR(XPS_CFG3DEN_FNC(tag));\
			onMissionLoad = XPS_STR(XPS_CFG3DEN_FNC(tag));\
			onMissionPreviewEnd = XPS_STR(XPS_CFG3DEN_FNC(tag));