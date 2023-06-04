#define Q(var1) #var1

#define ADDON PREFIX##_##COMPONENT

#define VARNAME(var1,var2,var3) var1##_##var2##_##var3

#define FILEPATH(var1,var2,var3) \ROOT\var1\addons\var2\var3
#define FILEPATH_C(var1) FILEPATH(PREFIX,COMPONENT,var1)
#define FILEPATH_C_Q(var1) Q(FILEPATH_C(var1))

#define COMPONENT_DIR Q(##@##ADDON)

#define XPS_CFG_BASECLASSNAME Enhanced_XPS_Type_Definitions
#define QXPS_CFG_BASECLASSNAME Q(XPS_CFG_BASECLASSNAME)

#define XPS_CFG_FNC(fncName) class fncName {\
    file = FILEPATH_C_Q(functions\fncName.sqf);\
    headerType = 0;\
    recompile = 1;\
}

#define XPS_CFG_FNC_SUB(sub,fncName) class fncName {\
    file = FILEPATH_C_Q(functions\sub\fncName.sqf);\
    headerType = 0;\
    recompile = 1;\
}

#define XPS_CFG_IFC(pref,ifcName) class ifcName {\
    file = FILEPATH_C_Q(interfaces\ifcName.sqf);\
    var = Q(VARNAME(pref,ifc,ifcName));\
    type = "ifc";\
}

#define XPS_CFG_IFC_SUB(pref,sub,ifcName) class ifcName {\
    file = FILEPATH_C_Q(interfaces\sub\ifcName.sqf);\
    var = Q(VARNAME(pref,ifc,ifcName));\
    type = "ifc";\
}

#define XPS_CFG_TYP(pref,typName) class typName {\
    file = FILEPATH_C_Q(typedefs\typName.sqf);\
    var = Q(VARNAME(pref,typ,typName));\
    type = "typ";\
    preprocess = 1;\
    allowNils = 1;\
}

#define XPS_CFG_TYP_SUB(pref,sub,typName) class typName {\
    file = FILEPATH_C_Q(typedefs\sub\typName.sqf);\
    var = Q(VARNAME(pref,typ,typName));\
    type = "typ";\
    preprocess = 1;\
    allowNils = 1;\
}