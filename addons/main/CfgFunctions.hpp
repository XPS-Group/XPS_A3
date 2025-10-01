class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class General {
			XPS_CFG_FNC(createUniqueID);
		};
		
		class TypeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,buildTypeDefinition);
			XPS_CFG_FNC_SUB(typeHandlers,checkInterface);
			XPS_CFG_FNC_SUB(typeHandlers,createSingleton);
			XPS_CFG_FNC_SUB(typeHandlers,createStaticTypeFromFile);
			XPS_CFG_FNC_SUB(typeHandlers,findReplaceKeyinCode);
			XPS_CFG_FNC_SUB(typeHandlers,isEqualHashmapObjectType);
			XPS_CFG_FNC_SUB(typeHandlers,parseTypeDefClass);
			XPS_CFG_FNC_SUB(typeHandlers,preprocessInterface);
			XPS_CFG_FNC_SUB(typeHandlers,preprocessTypeDefinition);
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