class CfgFunctions {
	class ADDON {
		class Formulas {
			XPS_CFG_FNC(hexGridSubCellMatrix);
			XPS_CFG_FNC(squareGridSubCellMatrix);
		};
		class Init {
			class preInit {
				file = FILEPATH_C_Q(preInit.sqf);
				preInit = 1;
			};
		};
	};
};