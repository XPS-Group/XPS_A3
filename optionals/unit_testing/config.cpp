#include "script_component.hpp"

class CfgMods {
    class ADDON {
        name = "XPS Unit Testing";
        dir = COMPONENT_DIR;
        author = "XPS Group";
        description = "Extensible Project System - Unit Testing";
        overview = "Work In Progress";
    };
};

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Unit Testing";
			author = "XPS Group";
			url = "";
	
			requiredVersion = REQUIRED_VERSION; 
			requiredAddons[] = { "xps_main" ,"xps_core" };
			is3DENMod = 1;
			units[] = {};
			weapons[] = {};
			skipWhenMissingDependencies = 1;
	};
};

#include "CfgTypeDefinitions.hpp"
#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"
#include "CfgUnitTests.hpp"
#include "displays\Dialog_TestConsole.hpp"
