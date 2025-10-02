class CfgFunctions {
	class PREFIX {
		tag = "xps";
		class TypeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,createEnumeration);
		};
		class Math {
			XPS_CFG_FNC_SUB(math,getRelPos);
			XPS_CFG_FNC_SUB(math,lineIntersect2D);
		};
	};
	class ADDON {
		class Init {
			class preInit {
				file = XPS_FILEPATH_C_STR(preInit.sqf);
				preInit = 1;
			};
		};
	};
};
