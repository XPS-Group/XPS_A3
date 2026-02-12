class Cfg3DEN
{
	class EventHandlers 
	{
		class ADDON {
			XPS_CFG3DEN_PREINIT(ADDON)
		};
	};
};
class CfgUserActions
{
	class XPS_DT_BTDebugConsoleOpen
	{
		displayName = "Open XPS Behaviour Tree Debugger";
		tooltip = "Open XPS Behaviour Tree Debugger";
		onActivate = "[] call XPS_DT_fnc_openBTDebugConsoleDialog;";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 1; 
	};
};
class UserActionGroups
{
	class XPS_DT_UserActionGroup
	{
		name = "XPS Debug Tools";
		isAddon = 1;
		group[] = {"XPS_DT_BTDebugConsoleOpen"};
	};
};
