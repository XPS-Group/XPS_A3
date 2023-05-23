params ["_p1","_p2","_p3","_p4"]

private _a1=(_p2#1)-(_p1#1);
private _b1=(_p1#0)-(_p2#0);
private _c1=_a1*(_p1#0)+_b1*(_p1#1);
private _a2=(_p4#1)-(_p3#1);
private _b2=(_p3#0)-(_p4#0);
private _c2=_a2*(_p3#0)+_b2*(_p3#1);
private _d=(A1*_b2)-(_a2*_b1)
if (_d == 0) exitwith {false};
private _x1 = (_b2*_c1-_b1*_c2)/_d;
private _y1 = (_a1*_c2-_a2*_c1)/_d;
[_x1,_y1,0];