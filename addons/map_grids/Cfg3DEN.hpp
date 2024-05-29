class Cfg3DEN
{
	class EventHandlers 
	{
		class ADDON {
			onMissionNew = "call XPS_MG_fnc_preInit;";
			onMissionLoad = "call XPS_MG_fnc_preInit;";
			onMissionPreviewEnd = "call XPS_MG_fnc_preInit;";
		};
	};
};