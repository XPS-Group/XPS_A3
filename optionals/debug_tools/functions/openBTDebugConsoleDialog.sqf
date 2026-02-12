#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: unit_testing. XPS_DT_fnc_openBTDebugConsoleDialog
	
	---prototype
	call XPS_DT_fnc_openBTDebugConsoleDialog
	---

Description:
    Opens a new Behaviour Tree Debugging Console Dialog

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Return: valueA
		<Boolean> - returns true if dialog is able to be displayed

---------------------------------------------------------------------------- */
if (time <= 0) exitWith {};
createDialog "XPS_DT_BTDebugConsole_display";
