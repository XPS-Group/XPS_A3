class CfgFunctions {
	class ADDON {
		class Terrain {
			XPS_CFG_FNC(checkCoastTravel);
		};
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
		};
	};
};