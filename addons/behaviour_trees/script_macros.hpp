
#include "\x\xps\addons\main\script_macros.hpp"

// STATUS MACROS
#define NODE_FAILURE QUOTE(FAILURE)
#define NODE_SUCCESS QUOTE(SUCCESS)
#define NODE_RUNNING QUOTE(RUNNING)

// DEBUG MACROS - any OnInit,OnTick,OnExecute

// ONINIT MACROS
#define XPS_BT_N_ONINIT_PARAMSCHECK(vtree,vnode,vpos) params [[QUOTE(vtree),nil,[createhashmap]],[QUOTE(vnode),nil,[createhashmap]],[QUOTE(vpos),nil,[""]]]

// ONTICK MACROS
#define XPS_BT_N_ONTICK_PARAMSCHECK(vtree,vnode,vpos,vblackboard) params [[QUOTE(vtree),nil,[createhashmap]],[QUOTE(vnode),nil,[createhashmap]],[QUOTE(vpos),nil,[""]],[QUOTE(vblackboard),nil,[createhashmap]]]

#define XPS_BT_N_ONTICK_GETALLCHILDREN(vtree,vpos,vchildren) private vchildren = vtree get "ChildrenOfPos" get vpos;

#define XPS_BT_N_ONTICK_GETCHILDATINDEX(vtree,vpos,vchildren,vchildpos,vchild,vindex) XPS_BT_N_ONTICK_GETALLCHILDREN(vtree,vpos,vchildren)\
    if (count vchildren == 0 || vindex >= count vchildren) exitwith {NODE_FAILURE};\
    private vchildpos = vchildren select vindex;\
    private vchild = vtree get "NodeAtPos" get vchildpos;

#define XPS_BT_N_ONTICK_GETSINGLECHILD(vtree,vpos,vchildren,vchildpos,vchild) XPS_BT_N_ONTICK_GETCHILDATINDEX(vtree,vpos,vchildren,vchildpos,vchild,0)

#define XPS_BT_N_ONTICK_TICKCHILD(vtree,vnode,vpos,vblackboard) [vtree, vnode, vpos, vblackboard] call (vnode get "OnTick");

#define XPS_BT_N_ONTICK_SET_STATUS(vtree,vnode,vpos,vstatus) vnode set ["Status",vstatus];\
    vtree get "StatusOfPos" set [vpos,vstatus];

// ONEXECUTE MACROS
#define XPS_BT_N_ONEXECUTE_PARAMSCHECK(vnode,vblackboard) params [[QUOTE(vnode),nil,[createhashmap]],[QUOTE(vblackboard),nil,[createhashmap]]]
#define XPS_BT_N_ONEXECUTE_ASYNC_PARAMSCHECK(vnode,vblackboard,vstatus,vtimeout,vcallback) params [[QUOTE(vnode),nil,[createhashmap]],[QUOTE(vblackboard),nil,[createhashmap]]]

