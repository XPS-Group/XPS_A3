/* ----------------------------------------------------------------------------
Function: pathfinding. XPS_PF_fnc_lineIntersect2D
	
	---prototype
	_result = [_posA1, _posA2, _posB1, _posB2] call XPS_PF_fnc_lineIntersect2D
	---

Description:
    Finds the point where two lines (A1->A2 and B1->B2) intersect on a 2D plane. If
	points given are 3D space, Z is averaged for posterity. Intersection only accounts
	for points in the 2D: [X,Y] plane.

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _posA1
		<Array> - can be 2D or 3D point 

	Parameter: _posA2
		<Array> - can be 2D or 3D point 

	Parameter: _posB1
		<Array> - can be 2D or 3D point 

	Parameter: _posB2
		<Array> - can be 2D or 3D point 

	Return: _result
		<Array> - [x,y,z] format - (Z is averaged)

---------------------------------------------------------------------------- */
params ["_p1","_p2","_p3","_p4"];

private _a1=(_p2#1)-(_p1#1);
private _b1=(_p1#0)-(_p2#0);
private _c1=_a1*(_p1#0)+_b1*(_p1#1);
private _a2=(_p4#1)-(_p3#1);
private _b2=(_p3#0)-(_p4#0);
private _c2=_a2*(_p3#0)+_b2*(_p3#1);
private _d=(_a1*_b2)-(_a2*_b1);
if (abs _d == 0) exitwith {[]};
private _x1 = (_b2*_c1-_b1*_c2)/_d;
private _y1 = (_a1*_c2-_a2*_c1)/_d;
[_x1,_y1,((_p1#2) + (_p1#2) + (_p1#2) + (_p1#2))/4];