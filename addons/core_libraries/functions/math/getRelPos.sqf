#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: core. math. XPS_fnc_getRelPos
	
	---prototype
	_pos = [_startPos, _dir, _dist, *_heightAdjust] call XPS_fnc_getRelPos
	---

Description:
    Returns a position (in 3D coordinates) that is relative in direction and distance
    from given start position. Optional relative height (Z) change can be included.

Authors: 
	CrashDome
------------------------------------------------------------------------------

	Parameter: _startPos
		<Array> - Coordinates in 2D or 3D format. If 2D is given, Z is assumed 0  

	Parameter: _dir
		<Number> - The direction (in degrees 'world')   

	Parameter: _dist
		<Number> - The distance (in meters 'world')   

	Optional: _hieghtAdjust
		<Number> - [Optional - Default : 0] - The difference in height (in meters 'world')  

	Return: _pos
		<Array> - The relative position in 3D world coordinates

	Example: 2D
		--- Code
		_sPos = [100,100];
        _ePos = [_sPos, 180, 100] call XPS_fnc_getRelPos;
        // result is : [100, 0, 0]
		---
        
	Example: 3D with height change
		--- Code
		_sPos = [100,100,0];
        _ePos = [_sPos, 90, 100, 100] call XPS_fnc_getRelPos;
        // result is : [200, 100, 100]
		---

---------------------------------------------------------------------------- */
params [["_startPos",[0,0,0],[[]],[2,3]],["_dir",0,[0]],["_dist",0,[0]],["_heightAdjust",0,[0]]];
_startPos params [["_x1",0,[0]],["_y1",0,[0]],["_z1",0,[0]]];

[_x1,_y1,_z1] vectorAdd ([sin _dir, cos _dir, 0] vectorMultiply _dist) vectorAdd [0,0,_heightAdjust];
