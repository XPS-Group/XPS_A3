class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class Hashmaps {
			PATHTO_FNC_F(container);
			PATHTO_FNC_F(containers);
			PATHTO_FNC_F(collection);
		};
		class Blackboard {
			SUBPATHTO_FNC_F(blackboard,blackboard);
		};
		class Helpers {
			SUBPATHTO_FNC_F(helpers,addBlackboardToUnit);
			SUBPATHTO_FNC_F(helpers,createUniqueID);
			SUBPATHTO_FNC_F(helpers,createObjectNamespace);
			SUBPATHTO_FNC_F(helpers,deleteObjectNamespace);
		};
		class Logging {
			PATHTO_FNC_F(logError);
		};
	};
};