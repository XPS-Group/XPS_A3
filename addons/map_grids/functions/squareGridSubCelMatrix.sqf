#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_MG_fnc_squareGridSubCelMatrix

    --- prototype
    [_radius*] call XPS_MG_fnc_squareGridSubCelMatrix
    ---

Description:
    Calculates a cell map of relative indexes which can be used to calculate 
    sub cell indexes inside of a larger square. This typically only needs to be done 
    once and then stored somewhere for reference. Number of sub cells is determined 
	by supplied radius (of cells). Index of first element will be lower-left. Moving
	right, then up where last element will be upper-right.

	For example - a 3x3 grid 
	---text
	.---------------------.
	| -1,1  | 0,1  | 1,1  | 
	|---------------------|
	| -1,0  | 0,0  | 1,0  | 
	|---------------------|
	| -1,-1 | 0,-1 | 1,-1 | 
	'---------------------'
	---

Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameters: 
    _radius - <Number> - (Default: 1) Width or Height is calculated as ((_radius X 2) + 1). A value of one will form a 3 x 3 sub grid. A value of 2 will be 5 x 5, etc...

Returns: <Array>

---------------------------------------------------------------------------- */
params [["_radius",1,[2]]];

private _cells = [];
private _center = [0,0,0];

for "_y" from -_radius to _radius do {
	for "_x" from -_radius to _radius do {
		_cellKey = _center vectorAdd [_x,_y]; 
		_cells pushback _cellkey;
	};
};

_cells;