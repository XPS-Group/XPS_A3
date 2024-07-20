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
	class XPS_UT_TestConsoleOpen
	{
		displayName = "Open XPS Unit Test Console";
		tooltip = "Open XPS Unit Test Console";
		onActivate = "[] call XPS_UT_fnc_openTestConsoleDialog;";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 1; 
	};
};
class UserActionGroups
{
	class XPS_UT_UserActionGroup
	{
		name = "XPS Unit Testing";
		isAddon = 1;
		group[] = {"XPS_UT_TestConsoleOpen"};
	};
};