class CfgFunctions {
	class PREFIX {
		tag = "xps";
		class typeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,parseUnitTestClass);
		};
	};
	class ADDON {
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
		};
		class General {
			XPS_CFG_FNC(openTestConsoleDialog);
		};
	};
};