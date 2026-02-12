#define COMPONENT main
#include "script_mod.hpp"
#include "script_macros.hpp"

// Functions - Debug Mode
//Uncomment for release
#define XPS_CFG_FNC(fncName)  XPS_CFG_FNC_NR(fncName)
#define XPS_CFG_FNC_SUB(sub,fncName)  XPS_CFG_FNC_SUB_NR(sub,fncName)
//Uncomment for debugging functions
// #define XPS_CFG_FNC(fncName)  XPS_CFG_FNC_DBG(fncName)
// #define XPS_CFG_FNC_SUB(sub,fncName)  XPS_CFG_FNC_SUB_DBG(sub,fncName)

