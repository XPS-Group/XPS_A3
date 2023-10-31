class CfgFunctions {
	class ADDON {
		class TestHandlers {
			XPS_CFG_FNC_SUB(testHandlers,parseUnitTestClass);
		};
		
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
		};
	};
};