
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		// class Interfaces {
		// 	XPS_CFG_IFC(IBTDebugClass);
		// 	XPS_CFG_IFC(IUnitBTDebug);
		// }; 

		// class Exceptions {
		// 	XPS_CFG_TYP_SUB(exceptions,AssertFailedException);
		// 	XPS_CFG_TYP_SUB(exceptions,AssertInconclusiveException);
		// };
		class Base {
			XPS_CFG_TYP(BTDebugService);
			XPS_CFG_TYP(BTDebugConsoleViewModel);
			XPS_CFG_TYP(BTDebugConsoleView);
		};
		// class Statics {
		// 	XPS_CFG_TYP(Assert);
		// 	XPS_CFG_TYP(BTDebugClasses);
		// };
	};
};
