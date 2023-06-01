class CfgFunctions {
	class PREFIX {
		TAG = "xps";
		class TypeHandlers {
			PATHTO_FNC_F(buildTypeDefinition);
			PATHTO_FNC_F(checkInterface);
			PATHTO_FNC_F(preprocessTypeDefinition);
		};
		class General {
			PATHTO_FNC_F(createObjectNamespace);
			PATHTO_FNC_F(createUniqueID);
			PATHTO_FNC_F(deleteObjectNamespace);
			PATHTO_FNC_F(logError);
		};
	};
};