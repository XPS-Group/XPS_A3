#include "script_component.hpp"

class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Action Planning";
			author = "Crashdome";
			url = "";
	
			requiredVersion = REQUIRED_VERSION; 
			requiredAddons[] = { "xps_main" ,"xps_core" };
			units[] = {};
			weapons[] = {};
			skipWhenMissingDependencies = 1;
	};
};

#include "CfgFunctions.hpp"
#include "CfgTypeDefinitions.hpp"