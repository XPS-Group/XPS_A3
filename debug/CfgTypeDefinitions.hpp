
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		tag = "xps";
		XPS_CFG_IFC(IException);

		XPS_CFG_TYP(Exception);

		class MissionDebugger {
			file = FILEPATH_C_Q(typedefs\MissionDebugger.sqf);
			type = "typ";
			preprocess = 1;
			allowNils = 0;
			noStack = 1;
			recompile = 0;
			isFinal = 1;
			headers = 0;
		};
	};
};