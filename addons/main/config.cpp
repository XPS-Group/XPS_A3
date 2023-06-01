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
			url = "";
	
			// Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
			requiredVersion = REQUIRED_VERSION; 
			// Required addons, used for setting load order.
			// When any of the addons is missing, pop-up warning will appear when launching the game.
			requiredAddons[] = {};
			// List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups) unlocking.
			units[] = {};
			// List of weapons (CfgWeapons classes) contained in the addon.
			weapons[] = {};
	};
};

#include "CfgFunctions.hpp"
#include "CfgTypeDefinitions.hpp"