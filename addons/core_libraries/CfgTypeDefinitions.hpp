
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		tag = "xps";
		class Collections {
			XPS_CFG_IFC_SUB(collections,ICollection);
			XPS_CFG_IFC_SUB(collections,IOrderedCollection);
			XPS_CFG_IFC_SUB(collections,IQueue);
			XPS_CFG_IFC_SUB(collections,IStack);
			XPS_CFG_TYP_SUB(collections,Collection);
			XPS_CFG_TYP_SUB(collections,HashmapObjectTypeCollection);
			XPS_CFG_TYP_SUB(collections,NativeTypeCollection);
			XPS_CFG_TYP_SUB(collections,Queue);
			XPS_CFG_TYP_SUB(collections,Stack);

		};
		class Searching {
			XPS_CFG_IFC_SUB(searching,IAstarSearch);
			XPS_CFG_TYP_SUB(searching,AstarSearch);
		};

			XPS_CFG_IFC(IAstarGraph);
			XPS_CFG_IFC(IAstarNode);
			XPS_CFG_IFC(IBlackboard);
			XPS_CFG_IFC(IDelegate);
			XPS_CFG_IFC(IException);
			XPS_CFG_IFC(IJobScheduler);
			XPS_CFG_IFC(IMultiCastDelegate);
		XPS_CFG_TYP(Blackboard);
		XPS_CFG_TYP(Delegate);
		XPS_CFG_TYP(Enumeration);
		XPS_CFG_TYP(Exception);
		XPS_CFG_TYP(JobScheduler);		
		XPS_CFG_TYP(MultiCastDelegate);

		class Exceptions {
			XPS_CFG_TYP_SUB(exceptions,ArgumentNilException);
			XPS_CFG_TYP_SUB(exceptions,ArgumentOutOfRangeException);
			XPS_CFG_TYP_SUB(exceptions,InvalidArgumentException);
			XPS_CFG_TYP_SUB(exceptions,InvalidOperationException);
		};
	};
};