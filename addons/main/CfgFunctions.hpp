class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class General {
			XPS_CFG_FNC_NR(createUniqueID);
			//XPS_CFG_FNC(logError);
		};
		
		class TypeHandlers {
			XPS_CFG_FNC_SUB_NR(typeHandlers,buildTypeDefinition);
			XPS_CFG_FNC_SUB_NR(typeHandlers,checkInterface);
			XPS_CFG_FNC_SUB_NR(typeHandlers,createSingleton);
			XPS_CFG_FNC_SUB_NR(typeHandlers,createStaticTypeFromFile);
			XPS_CFG_FNC_SUB_NR(typeHandlers,findReplaceKeyinCode);
			XPS_CFG_FNC_SUB_NR(typeHandlers,isEqualHashmapObjectType);
			XPS_CFG_FNC_SUB_NR(typeHandlers,parseTypeDefClass);
			XPS_CFG_FNC_SUB_NR(typeHandlers,preprocessInterface);
			XPS_CFG_FNC_SUB_NR(typeHandlers,preprocessTypeDefinition);
		};
		
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
			class preStart {
				file = XPS_FILEPATH_C_STR(preStart.sqf);
				preStart = 1;
			};
		};
	};
};