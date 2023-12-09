#define GUI_GRID_CENTER_X	((safeZoneX + (safeZoneW - ((safeZoneW / safeZoneH) min 1.2)) / 2))
#define GUI_GRID_CENTER_Y	((safeZoneY + (safeZoneH - (((safeZoneW / safeZoneH) min 1.2) / 1.2)) / 2))
#define GUI_GRID_CENTER_W	((((safeZoneW / safeZoneH) min 1.2) / 40))
#define GUI_GRID_CENTER_H	(((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25))
#define GUI_GRID_CENTER_WAbs	(((safeZoneW / safeZoneH) min 1.2))
#define GUI_GRID_CENTER_HAbs	((((safeZoneW / safeZoneH) min 1.2) / 1.2))
///////////////////////////////////////////////////////////////////////////
/// Styles
///////////////////////////////////////////////////////////////////////////

// Control types
#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

// Static styles
#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

// Slider styles
#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

// progress bar 
#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

// Listbox styles
#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

// Tree styles
#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

// MessageBox styles
#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

class RscText;
class RscListNBox;
class RscButton;

class XPS_RscText : RscText
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
class XPS_RscListNBox : RscListNBox
{
	deletable = 0;
	fade = 0;
	access = 0;
	type = 102;
	rowHeight = 0;
	colorText[] = {1,1,1,1};
	colorScrollbar[] = {0.95,0.95,0.95,1};
	colorSelect[] = {0,0,0,1};
	colorSelect2[] = {0,0,0,1};
	colorSelectBackground[] = {0.95,0.95,0.95,1};
	colorSelectBackground2[] = {1,1,1,0.5};
	colorBackground[] = {0,0,0,0};
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
class XPS_RscButton : RscButton {
	sizeEx = "0.022 / (getResolution select 5)";
	font = "PuristaLight";
};

class XPS_UT_TestConsole_display {

	idd = 5000;
	movingenable = "true";
	onLoad = "private _view = createhashmapobject [XPS_UT_typ_TestConsoleView,[_this#0]]; _this#0 setVariable [""xps_view"",_view]; _view call [""XPS_UT_TestConsole_display_load"",_this]";
	onUnload = "_this#0 getVariable ""xps_view"" call [""XPS_UT_TestConsole_display_unLoad""]; _this#0 setvariable [""xps_view"",nil];";
	class Controls 
	{
		class XPS_UT_TestConsole_frame: XPS_RscText
		{
			idc = 1200;
			x = Q(-0.2 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(-1 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(40.4 * GUI_GRID_CENTER_W);
			h = Q(26.2 * GUI_GRID_CENTER_H);
			colorBackground[] = {0,0,0,1};
		};
		class XPS_UT_TestConsole_bkgrd: XPS_RscText
		{
			idc = 2200;
			x = Q(0 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(0 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(40 * GUI_GRID_CENTER_W);
			h = Q(25 * GUI_GRID_CENTER_H);
		};
		class XPS_UT_TestConsole_LB1bkgrd: XPS_RscText
		{
			idc = 2201;
			x = Q(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(35 * GUI_GRID_CENTER_W);
			h = Q(18 * GUI_GRID_CENTER_H);
			colorBackground[] = {0.05,0.05,0.05,1};
		};
		class XPS_UT_TestConsole_LB1bkgrd2: XPS_RscText
		{
			idc = 2201;
			x = Q(2.45 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(26.25 * GUI_GRID_CENTER_W);
			h = Q(18 * GUI_GRID_CENTER_H);
			colorBackground[] = {0,0,0,1};
		};
		class XPS_UT_TestConsole_LB2bkgrd: XPS_RscText
		{
			idc = 2202;
			x = Q(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(35 * GUI_GRID_CENTER_W);
			h = Q(5 * GUI_GRID_CENTER_H);
			colorBackground[] = {0,0,0,1};
		};
		class XPS_UT_TestConsole_LB2bkgrd2: XPS_RscText
		{
			idc = 2202;
			x = Q(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(10.7 * GUI_GRID_CENTER_W);
			h = Q(5 * GUI_GRID_CENTER_H);
			colorBackground[] = {0.05,0.05,0.05,1};
		};
		class XPS_UT_TestConsole_unselect: RscButton
		{
			idc = 1400;
			x = -1;
			y = -1;
			w = -1;
			h = -1;
			text = "-";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_unselect_buttonClick"",_this];";
		};
		class XPS_UT_TestConsole_select: RscButton
		{
			idc = 1401;
			x = -1;
			y = -1;
			w = -1;
			h = -1;
			text = "+";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_select_buttonClick"",_this];";
		};
		class XPS_UT_TestConsole_tests: XPS_RscListNBox
		{
			idc = 1500;
			columns[] = {0.02,0.05,0.3,0.8,0.95};
			idcLeft = 1400;
			idcRight = 1401;
			x = Q(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(0.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(35 * GUI_GRID_CENTER_W);
			h = Q(18 * GUI_GRID_CENTER_H);
			onLBSelChanged = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_tests_LBSelChanged"",_this];";
		};
		class XPS_UT_TestConsole_details: XPS_RscListNBox
		{
			idc = 1501;
			columns[] = {-0.01,0.3};
			x = Q(0.5 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(19 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(35 * GUI_GRID_CENTER_W);
			h = Q(5 * GUI_GRID_CENTER_H);
		};
		class XPS_UT_TestConsole_runSelected: XPS_RscButton
		{
			idc = 1600;
			x = Q(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(3.33333 * GUI_GRID_CENTER_W);
			h = Q(2.5 * GUI_GRID_CENTER_H);
			text = "Selected";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_runSelected_buttonClick"",_this];";
		};
		class XPS_UT_TestConsole_runAll: XPS_RscButton
		{
			idc = 1601;
			x = Q(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(2 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(3.33333 * GUI_GRID_CENTER_W);
			h = Q(2.5 * GUI_GRID_CENTER_H);
			text = "All";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_runAll_buttonClick"",_this];";
		};
		class XPS_UT_TestConsole_reset: XPS_RscButton
		{
			idc = 1602;
			x = Q(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(8 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(3.33333 * GUI_GRID_CENTER_W);
			h = Q(2.5 * GUI_GRID_CENTER_H);
			text = "Reset";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_reset_buttonClick"",_this];";
		};
		class XPS_UT_TestConsole_reload: XPS_RscButton
		{
			idc = 1603;
			x = Q(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(14 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(3.33333 * GUI_GRID_CENTER_W);
			h = Q(2.5 * GUI_GRID_CENTER_H);
			text = "Reload";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_reload_buttonClick"",_this];";
		};
		class XPS_UT_TestConsole_close: XPS_RscButton
		{
			idc = 1604;
			x = Q(36 * GUI_GRID_CENTER_W + GUI_GRID_CENTER_X);
			y = Q(21.5 * GUI_GRID_CENTER_H + GUI_GRID_CENTER_Y);
			w = Q(3.33333 * GUI_GRID_CENTER_W);
			h = Q(2.5 * GUI_GRID_CENTER_H);
			text = "Close";
			onButtonClick = "(ctrlParent (_this#0) getVariable ""xps_view"") call [""XPS_UT_TestConsole_close_buttonClick"",_this];";
		};
	};
};
