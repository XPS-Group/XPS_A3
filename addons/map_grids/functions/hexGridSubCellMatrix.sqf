#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: map_grids. XPS_MG_fnc_hexGridSubCellMatrix

    --- prototype
    call XPS_MG_fnc_hexGridSubCellMatrix
    ---

Description:
    Calculates a 55 cell map of relative indexes which can be used to calculate 
    sub cell indexes inside of a larger hex. This typically only needs to be done 
    once and then stored somewhere for reference. The radius is predetermined at
    a value of 3 (three hexes in each of the 6 major directions to center of each 
	flat edge of larger hex). 
	
	(see hex_layout.png)

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: 
    <None>

Returns: <Array>

---------------------------------------------------------------------------- */
private _cells = [];
private _radius = 3;
private _center = [0,0,0];

for "_x" from -_radius-1 to _radius+1 do {
	for "_y" from -_radius-1 to _radius+1 do {
		_cellKey = _center vectorAdd [_x,_y,0]; //get all X/Y cells
		_cellKey set [2,0-(_cellKey#0)-(_cellKey#1)]; // calc Z
		private _max = 0;
		private _second = 0;
		for "_i" from 0 to 2 do {
			if (abs(_cellKey # _i) >= _max) then {
				_second = _max;
				_max = abs(_cellkey # _i);
			} else {
				if ((_cellKey # _i) > _second) then {
					_second = abs(_cellkey # _i);
				}; 
			};
		};
		if (_max <= _radius || {_max isEqualTo _radius+1 && _second <= _radius}) then 
		{
			_cells pushBack _cellkey;
		};
	};
};

_cells;
