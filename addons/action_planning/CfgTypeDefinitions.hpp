
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC_SUB(goap,IAction);

			XPS_CFG_IFC_SUB(htn,ICompoundTask);
			XPS_CFG_IFC_SUB(htn,IMethod);
			XPS_CFG_IFC_SUB(htn,IPrimitiveTask);
		};
		class HTN {
			XPS_CFG_TYP_SUB(htn,CompoundTask);
			XPS_CFG_TYP_SUB(htn,Method);
			XPS_CFG_TYP_SUB(htn,PrimitiveTask);
		};
	};
};