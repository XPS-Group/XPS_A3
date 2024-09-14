
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC_SUB(goap,IAction);
			XPS_CFG_IFC_SUB(goap,IActionStrategy);
			XPS_CFG_IFC_SUB(goap,IBelief);
			XPS_CFG_IFC_SUB(goap,IGoal);
			XPS_CFG_IFC_SUB(goap,ISensor);

			XPS_CFG_IFC_SUB(htn,ICompoundTask);
			XPS_CFG_IFC_SUB(htn,IMethod);
			XPS_CFG_IFC_SUB(htn,IPrimitiveTask);
		};
		class GOAP {
			XPS_CFG_TYP_SUB(goap,Action);
			XPS_CFG_TYP_SUB(goap,ActionStrategy);
			XPS_CFG_TYP_SUB(goap,ActionStrategyAsync);
			XPS_CFG_TYP_SUB(goap,Belief);
			XPS_CFG_TYP_SUB(goap,Goal);
			XPS_CFG_TYP_SUB(goap,Sensor);

		};
		class HTN {
			XPS_CFG_TYP_SUB(htn,CompoundTask);
			XPS_CFG_TYP_SUB(htn,Method);
			XPS_CFG_TYP_SUB(htn,PrimitiveTask);
		};
	};
};