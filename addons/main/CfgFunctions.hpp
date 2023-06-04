class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class Preprocessing {
			class preInit {
				file = "\x\xps\addons\main\functions\typeHandlers\preInit.sqf";
				preInit = 1;
			};
			class preStart {
				file = "\x\xps\addons\main\functions\typeHandlers\preStart.sqf";
				preStart = 1;
			};
		};
		class TypeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,buildTypeDefinition);
			XPS_CFG_FNC_SUB(typeHandlers,compileTypes);
			XPS_CFG_FNC_SUB(typeHandlers,findReplaceKeyinCode);
			XPS_CFG_FNC_SUB(typeHandlers,checkInterface);
			XPS_CFG_FNC_SUB(typeHandlers,preprocessTypeDefinition);
		};
		class General {
			//XPS_CFG_FNC(createObjectNamespace);
			XPS_CFG_FNC(createUniqueID);
			//XPS_CFG_FNC(deleteObjectNamespace);
			XPS_CFG_FNC(logError);
		};
	};
};