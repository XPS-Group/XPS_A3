class CfgFunctions {
	class ADDON {
		class Geometry {
			XPS_CFG_FNC(lineIntersect2D);
		};
		class Terrain {
			XPS_CFG_FNC(checkCoastTravel);
		};
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
		};
	};
};