
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		tag = "xps";
		class Interfaces {
			XPS_CFG_IFC_SUB(exceptions,IException);
			XPS_CFG_IFC_SUB(enumerations,IEnumeration);
			XPS_CFG_IFC_SUB(ioc,IServiceContainer);
			XPS_CFG_IFC_SUB(ioc,IServiceProvider);
			XPS_CFG_IFC_SUB(delegates,IDelegate);
			XPS_CFG_IFC_SUB(delegates,IEventHandler);
			XPS_CFG_IFC_SUB(delegates,IEventRouter);
			XPS_CFG_IFC_SUB(collections,IList);
			XPS_CFG_IFC_SUB(collections,ICollection);
			XPS_CFG_IFC_SUB(collections,ICollectionNotifier);
			XPS_CFG_IFC_SUB(collections,IQueue);
			XPS_CFG_IFC_SUB(collections,IStack);
			XPS_CFG_IFC_SUB(searching,IAstarNode);
			XPS_CFG_IFC_SUB(searching,IAstarGraph);
			XPS_CFG_IFC_SUB(searching,IAstarSearch);
			XPS_CFG_IFC_SUB(typecheck,ITypeRestrictor);
			XPS_CFG_IFC_SUB(timers,IDelay);
			XPS_CFG_IFC(IBlackboard);
			XPS_CFG_IFC(IJobScheduler);
		};
		class Exceptions {
			XPS_CFG_TYP_SUB(exceptions,Exception);
			XPS_CFG_TYP_SUB(exceptions,ArgumentNilException);
			XPS_CFG_TYP_SUB(exceptions,ArgumentOutOfRangeException);
			XPS_CFG_TYP_SUB(exceptions,InvalidArgumentException);
			XPS_CFG_TYP_SUB(exceptions,InvalidOperationException);
		};
		class DependancyInjection {
			XPS_CFG_ENUM_SUB(ioc,LifeTime);
			XPS_CFG_TYP_SUB(ioc,ServiceContainer);
			XPS_CFG_TYP_SUB(ioc,ServiceProvider);
		};
		class Delegates {
			XPS_CFG_TYP_SUB(delegates,Delegate);
			XPS_CFG_TYP_SUB(delegates,MultiCastDelegate);
			XPS_CFG_TYP_SUB(delegates,Event);
			XPS_CFG_TYP_SUB(delegates,EventHandler);
			XPS_CFG_TYP_SUB(delegates,EventRouter);

		};
		class Enumerations {
			XPS_CFG_TYP_SUB(enumerations,Enumeration);
		};
		class Collections {
			XPS_CFG_TYP_SUB(collections,OrderedCollection);
			XPS_CFG_TYP_SUB(collections,OrderedCollectionN);
			XPS_CFG_TYP_SUB(collections,TypeCollection);
			XPS_CFG_TYP_SUB(collections,TypeCollectionN);
			XPS_CFG_TYP_SUB(collections,Queue);
			XPS_CFG_TYP_SUB(collections,Stack);
		};
		class Searching {
			XPS_CFG_TYP_SUB(searching,AstarSearch);
		};
		class Timers {
			XPS_CFG_TYP_SUB(timers,FrameDelay);
			XPS_CFG_TYP_SUB(timers,TimeDelay);
		};
		class TypeChecking {
			XPS_CFG_TYP_SUB(typecheck,NoTypeRestrictor);
			XPS_CFG_TYP_SUB(typecheck,NativeTypeRestrictor);
			XPS_CFG_TYP_SUB(typecheck,HashmapObjectTypeRestrictor);
		};
		class Utility {
			XPS_CFG_TYP(Blackboard);
			XPS_CFG_TYP(JobScheduler);		
		};
		class Statics {
			XPS_CFG_TYP_SUB(enumerations,Enum);
		};
	};
};