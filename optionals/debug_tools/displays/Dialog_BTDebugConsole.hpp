#define GUI_GRID_CENTER_X	((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 2))
#define GUI_GRID_CENTER_Y	((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 2))
#define GUI_GRID_CENTER_W	((((safeZoneW / safeZoneH) min 1.2) / 40))
#define GUI_GRID_CENTER_H	(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define GUI_GRID_CENTER_WAbs	(((safeZoneW / safeZoneH) min 1.2))
#define GUI_GRID_CENTER_HAbs	((((safeZoneW / safeZoneH) min 1.2) / 1.2))

#include "styles.hpp"

class RscText;
class RscTreeMulti;
class RscButton;

class XPS_DT_RscText : RscText
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_STATIC;
	idc = -1;
	colorBackground[] = {0.2,0.2,0.2,1};
	colorText[] = {1,1,1,1};
	text = "";
	fixedWidth = 0;
	style = ST_LEFT;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaLight";
	sizeEx = "0.024 / (getResolution select 5)";
	linespacing = 1;
};
class XPS_DT_RscTree : RscTreeMulti
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = CT_TREE;
	rowHeight=0;
	colorText[] = {0.33,0.33,0.33,1};
	colorScrollbar[] = {0.25,0.27,0.33,1};
	colorSelect[] = {0,0,0,1};
	colorSelectBackground[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.5};
	colorDisabled[] = {1,1,1,0.25};
	colorSelectText[] = {0,0,0,1};
	colorBorder[] = {0,0,0,0};
	colorSearch[] = {0,0,0,0};
	colorMarked[] = {0.77,0.83,0.42,0.1};
	colorMarkedText[] = {0,0,0,1};
	colorMarkedSelected[] = {0.66,0.69,0.14,0.3};
	multiselectEnabled = 1;
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {0,0,0,0};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	shadow = 0;
	style = ST_LEFT;
	expandedTexture = "A3\ui_f\data\gui\rsccommon\rsctree\expandedTexture_ca.paa";
	hiddenTexture = "A3\ui_f\data\gui\rsccommon\rsctree\hiddenTexture_ca.paa";
	colorArrow[] = {0.33,0.33,0.33,1};
	colorLines[] = {0.75,0.75,0.75,1};
	borderSize = 0;
	expandOnDoubleclick = 0;
	maxHistoryDelay = 1;
	sizeEx = "0.022 / (getResolution select 5)";
	font = "PuristaLight";
	class ScrollBar
	{
		arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
		arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
		border = "#(argb,8,8,3)color(1,1,1,1)";
		color[] = {1,1,1,0.6};
		colorActive[] = {1,1,1,0.85};
		colorDisabled[] = {1,1,1,0.3};
		thumb = "#(argb,8,8,3)color(1,1,1,1)";
	};
};
class XPS_DT_RscButton : RscButton {
	sizeEx = "0.022 / (getResolution select 5)";
	font = "PuristaLight";
};
/* -------------------------------------------------------------------------
Variable: debug_tools. XPS_DT_BTDebugConsole_display
	<Display>

Description:
	Returns the main display for the Behaviour Tree Debugging Console Dialog

Returns: 
	<Display> - The main display
---------------------------------------------------------------------------*/
class XPS_DT_BTDebugConsole_display {

	idd = 5100;
	movingenable = "true";
	onLoad = "private _view = createHashmapObject [XPS_DT_typ_BTDebugConsoleView,[_this#0]]; _this#0 setVariable [""xps_view"",_view]; _view call [""XPS_DT_BTDebugConsole_display_load"",_this]";
	onUnload = "_this#0 getVariable ""xps_view"" call [""XPS_DT_BTDebugConsole_display_unLoad""]; _this#0 setvariable [""xps_view"",nil];";
	class Controls 
	{
		class XPS_DT_BTDebugConsole_frame: XPS_DT_RscText
		{
			idc = 1200;
			x = XPS_STR(-0.2 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(-1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(40.4 * GUI_GRID_CENTER_W);
			h = XPS_STR(26.2 * GUI_GRID_CENTER_H);
			colorBackground[] = {0,0,0,1};
		};
		class XPS_DT_BTDebugConsole_bkgrd: XPS_DT_RscText
		{
			idc = 2200;
			x = XPS_STR(0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(40 * GUI_GRID_CENTER_W);
			h = XPS_STR(25 * GUI_GRID_CENTER_H);
		};
		class XPS_DT_BTDebugConsole_TVbkgrd: XPS_DT_RscText
		{
			idc = 2201;
			x = XPS_STR(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(35 * GUI_GRID_CENTER_W);
			h = XPS_STR(18 * GUI_GRID_CENTER_H);
			colorBackground[] = {0,0,0,1};
		};
		// class XPS_DT_BTDebugConsole_TVbkgrd2: XPS_DT_RscText
		// {
		// 	idc = 2201;
		// 	x = XPS_STR(2.45 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
		// 	y = XPS_STR(0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
		// 	w = XPS_STR(26.25 * GUI_GRID_CENTER_W);
		// 	h = XPS_STR(18 * GUI_GRID_CENTER_H);
		// 	colorBackground[] = {0,0,0,1};
		// };
		class XPS_DT_BTDebugConsole_LB2bkgrd: XPS_DT_RscText
		{
			idc = 2202;
			x = XPS_STR(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(35 * GUI_GRID_CENTER_W);
			h = XPS_STR(5 * GUI_GRID_CENTER_H);
			colorBackground[] = {0,0,0,1};
		};
		class XPS_DT_BTDebugConsole_LB2bkgrd2: XPS_DT_RscText
		{
			idc = 2202;
			x = XPS_STR(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(10.7 * GUI_GRID_CENTER_W);
			h = XPS_STR(5 * GUI_GRID_CENTER_H);
			colorBackground[] = {0.05,0.05,0.05,1};
		};
		// class XPS_DT_BTDebugConsole_unselect: RscButton
		// {
		// 	idc = 1400;
		// 	x = -1;
		// 	y = -1;
		// 	w = -1;
		// 	h = -1;
		// 	text = "-";
		// 	onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_unselect_buttonClick"",_this];";
		// };
		// class XPS_DT_BTDebugConsole_select: RscButton
		// {
		// 	idc = 1401;
		// 	x = -1;
		// 	y = -1;
		// 	w = -1;
		// 	h = -1;
		// 	text = "+";
		// 	onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_select_buttonClick"",_this];";
		// };
		class XPS_DT_BTDebugConsole_nodes: XPS_DT_RscTree
		{
			idc = 1500;
			x = XPS_STR(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(15 * GUI_GRID_CENTER_W);
			h = XPS_STR(18 * GUI_GRID_CENTER_H);
			onTreeSelChanged = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_TreeSelChanged"",_this];";
		};
		// class XPS_DT_BTDebugConsole_details: XPS_DT_RscListNBox
		// {
		// 	idc = 1501;
		// 	columns[] = {0.01,0.3};
		// 	x = XPS_STR(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
		// 	y = XPS_STR(19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
		// 	w = XPS_STR(35 * GUI_GRID_CENTER_W);
		// 	h = XPS_STR(5 * GUI_GRID_CENTER_H);
		// };
		// class XPS_DT_BTDebugConsole_runSelected: XPS_DT_RscButton
		// {
		// 	idc = 1600;
		// 	x = XPS_STR(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
		// 	y = XPS_STR(5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
		// 	w = XPS_STR(3.33333 * GUI_GRID_CENTER_W);
		// 	h = XPS_STR(2.5 * GUI_GRID_CENTER_H);
		// 	text = "Selected";
		// 	onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_runSelected_buttonClick"",_this];";
		// };
		// class XPS_DT_BTDebugConsole_runAll: XPS_DT_RscButton
		// {
		// 	idc = 1601;
		// 	x = XPS_STR(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
		// 	y = XPS_STR(2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
		// 	w = XPS_STR(3.33333 * GUI_GRID_CENTER_W);
		// 	h = XPS_STR(2.5 * GUI_GRID_CENTER_H);
		// 	text = "All";
		// 	onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_runAll_buttonClick"",_this];";
		// };
		// class XPS_DT_BTDebugConsole_reset: XPS_DT_RscButton
		// {
		// 	idc = 1602;
		// 	x = XPS_STR(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
		// 	y = XPS_STR(8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
		// 	w = XPS_STR(3.33333 * GUI_GRID_CENTER_W);
		// 	h = XPS_STR(2.5 * GUI_GRID_CENTER_H);
		// 	text = "Reset";
		// 	onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_reset_buttonClick"",_this];";
		// };
		class XPS_DT_BTDebugConsole_reload: XPS_DT_RscButton
		{
			idc = 1603;
			x = XPS_STR(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(14 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(3.33333 * GUI_GRID_CENTER_W);
			h = XPS_STR(2.5 * GUI_GRID_CENTER_H);
			text = "Reload";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_reload_buttonClick"",_this];";
		};
		class XPS_DT_BTDebugConsole_close: XPS_DT_RscButton
		{
			idc = 1604;
			x = XPS_STR(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = XPS_STR(21.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = XPS_STR(3.33333 * GUI_GRID_CENTER_W);
			h = XPS_STR(2.5 * GUI_GRID_CENTER_H);
			text = "Close";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_DT_BTDebugConsole_close_buttonClick"",_this];";
		};
	};
};
