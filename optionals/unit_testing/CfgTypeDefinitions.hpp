
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC(ITestClass);
		}; 

		class Exceptions {
			XPS_CFG_TYP_SUB(exceptions,AssertFailedException);
			XPS_CFG_TYP_SUB(exceptions,AssertInconclusiveException);
		};

		XPS_CFG_TYP(Assert);
		XPS_CFG_TYP(Engine);
		XPS_CFG_TYP(TestClass);
	};
};