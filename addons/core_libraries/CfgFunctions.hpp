class CfgFunctions {
	class PREFIX {
		tag = "xps";
		class TypeHandlers {
			XPS_CFG_FNC_SUB(typeHandlers,createEnumeration);
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