class CfgFunctions {
	class ADDON {
		class TreeHandlers {
			XPS_CFG_FNC(buildTree);
		};
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
		};
	};
};