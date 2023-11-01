class XPS_CFG_BASECLASSNAME {
	class ADDON {
		tag = "xps";
		XPS_CFG_IFC(IAstarNode);
		XPS_CFG_IFC(IAstarSearch);
		XPS_CFG_IFC(IBlackboard);
		XPS_CFG_IFC(ICollection);
		XPS_CFG_IFC(IDelegate);
		XPS_CFG_IFC(IException);
		XPS_CFG_IFC(IJobScheduler);
		XPS_CFG_IFC(IMultiCastDelegate);

		XPS_CFG_TYP(AstarSearch);
		XPS_CFG_TYP(Blackboard);
		XPS_CFG_TYP(Collection);
		XPS_CFG_TYP(Delegate);
		XPS_CFG_TYP(Exception);
		XPS_CFG_TYP(ExceptionHandler);
		XPS_CFG_TYP(HashmapCollection);
		XPS_CFG_TYP(JobScheduler);
		XPS_CFG_TYP(MultiCastDelegate);
	};
};