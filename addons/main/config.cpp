#include "script_component.hpp"

class CfgMods {
    class ADDON {
        name = "XPS - Extensible Project System";
        dir = COMPONENT_DIR;
        author = "Crashdome";
        description = "Extensible Project System - Core Functionality";
        overview = "Work In Progress";
    };
};

class CfgPatches {
	class ADDON {
			// Meta information for editor
        	name = "XPS - Extensible Project System";
			author = "Crashdome";
			url = "https://github.com/XPS-Group/XPS_A3";
	
			requiredVersion = REQUIRED_VERSION; 
			requiredAddons[] = {};
			units[] = {};
			weapons[] = {};
	};
};

#include "CfgFunctions.hpp"
#include "Cfg3DEN.hpp"