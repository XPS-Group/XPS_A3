class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class Initialization {
			class preInit {
				file = "\x\xps\addons\main\functions\preInit.sqf";
				preInit = 1;
			};
			class preStart {
				file = "\x\xps\addons\main\functions\preStart.sqf";
				preStart = 1;
			};
		};
		class TypeHandlers {
			XPS_CFG_FNC(buildTypeDefinition);
			XPS_CFG_FNC(comileTypes);
			XPS_CFG_FNC(findReplaceKeyinCode);
			XPS_CFG_FNC(checkInterface);
			XPS_CFG_FNC(preprocessTypeDefinition);
		};
		class General {
			//XPS_CFG_FNC(createObjectNamespace);
			XPS_CFG_FNC(createUniqueID);
			//XPS_CFG_FNC(deleteObjectNamespace);
			XPS_CFG_FNC(logError);
		};
	};
};