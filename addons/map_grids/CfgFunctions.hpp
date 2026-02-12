class CfgFunctions {
	class ADDON {
		class Formulas {
			XPS_CFG_FNC(hexGridSubCellMatrix);
			XPS_CFG_FNC(squareGridSubCellMatrix);
		};
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
		};
	};
};
