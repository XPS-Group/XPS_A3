/* ----------------------------------------------------------------------------
Function: pathfinding. XPS_PF_fnc_checkCoastTravel
	
	---prototype
	_result = [_startPos, _endPos, _distanceThreshold*] call XPS_PF_fnc_checkCoastTravel
	---

Description:
    Checks if there is any non-shallow water between two points based on a threshold. 

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _startPos
		<Array> - can be 2D or 3D point (ASL) 

	Parameter: _endPos
		<Array> - can be 2D or 3D point (ASL) 

	Optional: _distanceThreshold* 
		<Number> - [Optional - Default : 100] - distance of water in meters  

	Return: _result
		<Boolean> - <True> if water exists, otherwise <False>

---------------------------------------------------------------------------- */
params [["_startPos",[0,0],[[]],[2,3]],["_endPos",[0,0],[[]],[2,3]],["_distanceThreshold",100,[0]]];

private _waterTravel = false;
private _dist = _startPos distance _endPos;
private _inc = ceil(_dist / (_distanceThreshold/4));
private _waterDistance = 0;

_a = ((_endPos select 0) - (_startPos select 0))/_inc;
_b = ((_endPos select 1) - (_startPos select 1))/_inc;

for "_i" from 0 to _inc do {
    _heightASL = getTerrainHeightASL [(_startPos select 0) + (_a*_i),(_startPos select 1) + (_b*_i)];
    if (_heightASL < -0.3) then {
        _waterTravel = true;
        _waterDistance = _waterDistance + _inc;
    };
	if (_waterTravel && (_waterDistance > _distanceThreshold)) exitwith {true;};
};

false;