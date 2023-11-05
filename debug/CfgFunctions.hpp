class CfgFunctions {
	class PREFIX {
		tag = "xps";
		class Debug
		{
			XPS_CFG_FNC(createMissionDebugger);
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