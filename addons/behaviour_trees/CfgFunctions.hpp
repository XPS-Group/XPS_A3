class CfgFunctions {
	class ADDON {
		class TreeHandlers {
			XPS_CFG_FNC(buildTree);
		};
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
		};
	};
};