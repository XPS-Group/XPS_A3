
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC(ITestClass);
			XPS_CFG_IFC(ITestResult);
		}; 

		class Exceptions {
			XPS_CFG_TYP_SUB(exceptions,AssertFailedException);
			XPS_CFG_TYP_SUB(exceptions,AssertInconclusiveException);
		};
		class Base {
			XPS_CFG_TYP(TestClass);
			XPS_CFG_TYP(TestResult);
			XPS_CFG_TYP(TestConsoleController);
			XPS_CFG_TYP(TestConsoleViewModel);
		};
		class Statics {
			XPS_CFG_TYP(Assert);
			XPS_CFG_TYP(Engine);
		};
	};
};