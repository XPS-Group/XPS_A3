class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class TypeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,buildTypeDefinition);
			XPS_CFG_FNC_SUB(typeHandlers,parseTypeDefClass);
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
		
		class Init {
			class preInit {
				file = "\x\xps\addons\main\functions\init\preInit.sqf";
				preInit = 1;
			};
			class preStart {
				file = "\x\xps\addons\main\functions\init\preStart.sqf";
				preStart = 1;
			};
		};
	};
};