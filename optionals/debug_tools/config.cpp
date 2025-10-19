#include "script_component.hpp"

class CfgMods {
    class ADDON {
        name = "XPS Debug Tools";
        dir = COMPONENT_DIR;
        author = "XPS Group";
        description = "Extensible Project System - Debug Tools";
        overview = "Work In Progress";
    };
};

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Debug Tools";
			author = "XPS Group";
			url = "";
	
			requiredVersion = REQUIRED_VERSION; 
			requiredAddons[] = { "xps_main" ,"xps_core", "xps_bt" };
			is3DENMod = 1;
			units[] = {};
			weapons[] = {};
			skipWhenMissingDependencies = 1;
	};
};

#include "CfgTypeDefinitions.hpp"
#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
#include "displays\Dialog_BTDebugConsole.hpp"
