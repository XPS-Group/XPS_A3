class CfgPatches {
	class ADDON {
			// Meta information for editor
			name = "XPS : Formation AI";
			author = "CrashDome";
			url = "";
	
			// Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
			requiredVersion = REQUIRED_VERSION; 
			// Required addons, used for setting load order.
			// When any of the addons is missing, pop-up warning will appear when launching the game.
			requiredAddons[] = { "cba_main", "xps_main", "xps_bt" };
			// List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups) unlocking.
			units[] = {};
			// List of weapons (CfgWeapons classes) contained in the addon.
			weapons[] = {};
	};
};