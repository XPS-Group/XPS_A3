class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class TypeHandlers {
			class xps_fnc_compileTypes {
				file = "\x\xps\addons\main\functions\compileTypes.sqf";
				preInit = 1;
				//preStart = 1;
			};
			XPS_CFG_FNC(buildTypeDefinition);
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