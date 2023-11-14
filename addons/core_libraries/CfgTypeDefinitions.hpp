
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		tag = "xps";
		class Interfaces {
			XPS_CFG_IFC(IAstarGraph);
			XPS_CFG_IFC(IAstarNode);
			XPS_CFG_IFC(IAstarSearch);
			XPS_CFG_IFC(IBlackboard);
			XPS_CFG_IFC(ICollection);
			XPS_CFG_IFC(IDelegate);
			XPS_CFG_IFC(IException);
			XPS_CFG_IFC(IJobScheduler);
			XPS_CFG_IFC(IMultiCastDelegate);
			XPS_CFG_IFC(IOrderedCollection);
			XPS_CFG_IFC(IQueue);
			XPS_CFG_IFC(IStack);
		};

		XPS_CFG_TYP(AstarSearch);
		XPS_CFG_TYP(Blackboard);
		XPS_CFG_TYP(Collection);
		XPS_CFG_TYP(Delegate);
		XPS_CFG_TYP(Enumeration);
		XPS_CFG_TYP(Exception);
		XPS_CFG_TYP(HashmapCollection);
		XPS_CFG_TYP(JobScheduler);		
		XPS_CFG_TYP(MultiCastDelegate);
		XPS_CFG_TYP(Queue);
		XPS_CFG_TYP(Stack);

		class Exceptions {
			XPS_CFG_TYP_SUB(exceptions,ArgumentNilException);
			XPS_CFG_TYP_SUB(exceptions,ArgumentOutOfRangeException);
			XPS_CFG_TYP_SUB(exceptions,InvalidArgumentException);
			XPS_CFG_TYP_SUB(exceptions,InvalidOperationException);
		};
	};
};