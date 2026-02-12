#include "script_component.hpp"

class CfgMods {
    class ADDON {
        name = "XPS Core Libraries";
        dir = COMPONENT_DIR;
        author = "XPS Group";
        description = "Extensible Project System - Core Libraries";
        overview = "Work In Progress";
    };
};

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Core Libraries";
			author = "XPS Group";
			url = "";
	
			requiredVersion = REQUIRED_VERSION; 
			requiredAddons[] = { "xps_main" };
			units[] = {};
			weapons[] = {};
			skipWhenMissingDependencies = 1;
	};
};

#include "CfgTypeDefinitions.hpp"
#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
