
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC(ITestClass);
			XPS_CFG_IFC(IUnitTest);
		}; 

		class Exceptions {
			XPS_CFG_TYP_SUB(exceptions,AssertFailedException);
			XPS_CFG_TYP_SUB(exceptions,AssertInconclusiveException);
		};
		class Base {
			XPS_CFG_TYP(TestClass);
			XPS_CFG_TYP(TestService);
			XPS_CFG_TYP(TestConsoleViewModel);
			XPS_CFG_TYP(TestConsoleView);
			XPS_CFG_TYP(UnitTest);
		};
		class Statics {
			XPS_CFG_TYP(Assert);
			XPS_CFG_TYP(TestClasses);
		};
	};
};