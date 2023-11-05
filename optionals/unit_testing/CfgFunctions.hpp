class CfgFunctions {
	class PREFIX {
		tag = "xps";
		class TestHandlers {
			XPS_CFG_FNC_SUB(testHandlers,parseUnitTestClass);
		};
	};
	class ADDON {
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
		};
	};
};