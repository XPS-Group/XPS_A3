class CfgFunctions {
	class PREFIX {
		tag = "xps";
		class TypeHandlers {
			XPS_CFG_FNC_SUB_NR(typeHandlers,buildServiceProvider);
			XPS_CFG_FNC_SUB_NR(typeHandlers,createEnumeration);
		};
		class Math {
			XPS_CFG_FNC_SUB_NR(math,getRelPos);
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