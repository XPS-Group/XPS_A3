#include "\x\cba\addons\main\script_macros_common.hpp"
#define COMPONENT_DIR QUOTE(##@##ADDON)

#define FNC_ISFINAL false
#define PREP_FNC(fncName) TRIPLES(ADDON,fnc,fncName) = compileScript [QPATHTOF(functions\fncName.sqf),FNC_ISFINAL]
#define PREPMAIN_FNC(fncName) TRIPLES(PREFIX,fnc,fncName) = compileScript [QPATHTOF(functions\fncName.sqf),FNC_ISFINAL]
#define SUBPREP_FNC(sub,fncName) TRIPLES(ADDON,fnc,fncName) = compileScript [QPATHTOF(functions\sub\fncName.sqf),FNC_ISFINAL]
#define SUBPREPMAIN_FNC(sub,fncName) TRIPLES(PREFIX,fnc,fncName) = compileScript [QPATHTOF(functions\sub\fncName.sqf),FNC_ISFINAL]

#define IFC_ISFINAL false
#define PREP_IFC(ifcName) TRIPLES(ADDON,ifc,ifcName) = call compileScript [QPATHTOF(interfaces\ifcName.sqf),IFC_ISFINAL]
#define PREPMAIN_IFC(ifcName) TRIPLES(PREFIX,ifc,ifcName) = call compileScript [QPATHTOF(interfaces\ifcName.sqf),IFC_ISFINAL]
#define SUBPREP_IFC(sub,ifcName) TRIPLES(ADDON,ifc,ifcName) = call compileScript [QPATHTOF(interfaces\sub\ifcName.sqf),IFC_ISFINAL]
#define SUBPREPMAIN_IFC(sub,ifcName) TRIPLES(PREFIX,ifc,ifcName) = call compileScript [QPATHTOF(interfaces\sub\ifcName.sqf),IFC_ISFINAL]

#define PREP_TYP(typName) TRIPLES(ADDON,typ,typName) = [call compileScript [QPATHTOF(typedefs\typName.sqf)]] call XPS_fnc_buildTypeDefinition
#define PREPMAIN_TYP(typName) TRIPLES(PREFIX,typ,typName) = [call compileScript [QPATHTOF(typedefs\typName.sqf)]] call XPS_fnc_buildTypeDefinition
#define SUBPREP_TYP(sub,typName) TRIPLES(ADDON,typ,typName) = [call compileScript [QPATHTOF(typedefs\sub\typName.sqf)]] call XPS_fnc_buildTypeDefinition
#define SUBPREPMAIN_TYP(sub,typName) TRIPLES(PREFIX,typ,typName) = [call compileScript [QPATHTOF(typedefs\sub\typName)sqf)]] call XPS_fnc_buildTypeDefinition
#define PREP_TYP_FINAL(typName) TRIPLES(ADDON,typ,typName) = compileFinal (PREP_TYP(typName))
#define PREPMAIN_TYP_FINAL(typName) TRIPLES(PREFIX,typ,typName) = compileFinal (PREPMAIN_TYP(typName))
#define SUBPREP_TYP_FINAL(sub,typName) TRIPLES(ADDON,typ,typName) = compileFinal (SUBPREP_TYP(sub,typName))
#define SUBPREPMAIN_TYP_FINAL(sub,typName) TRIPLES(PREFIX,typ,typName) = compileFinal (SUBPREPMAIN_TYP(sub,typName))

#define PATHTO_FNC_F(fncName) class fncName {\
    file = QPATHTOF(functions\fncName.sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}
#define SUBPATHTO_FNC_F(sub,fncName) class fncName {\
    file = QPATHTOF(functions\sub\fncName.sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}