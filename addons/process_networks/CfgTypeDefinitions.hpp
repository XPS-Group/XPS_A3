
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC(IChannel);
			XPS_CFG_IFC(IProcess);
			XPS_CFG_IFC(IProcessGraph);
		};

		class Base {
			XPS_CFG_TYP(Channel);
			XPS_CFG_TYP(KeyedChannel);
			XPS_CFG_TYP(Process);
			XPS_CFG_TYP(ProcessGraph);
		};
	};
};