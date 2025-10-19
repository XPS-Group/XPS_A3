class CfgFunctions {
	class ADDON {
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
		};
		class General {
			XPS_CFG_FNC(openBTDebugConsoleDialog);
		};
	};
};
