class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class General {
			XPS_CFG_FNC(createUniqueID);
			XPS_CFG_FNC(logError);
		};
		class TypeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,buildTypeDefinition);
			XPS_CFG_FNC_SUB(typeHandlers,checkInterface);
			XPS_CFG_FNC_SUB(typeHandlers,findReplaceKeyinCode);
			XPS_CFG_FNC_SUB(typeHandlers,parseTypeDefClass);
			XPS_CFG_FNC_SUB(typeHandlers,preprocessTypeDefinition);
		};
		
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
			class preStart {
				file = FILEPATH_C_Q(preStart.sqf);
				preStart = 1;
			};
		};
	};
};