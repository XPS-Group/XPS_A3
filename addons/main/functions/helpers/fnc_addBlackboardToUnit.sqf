params [["_varName",nil,[""]],["_unit",nil,[objNull]],["_blackboard",nil,[createhashmap]]];

_unit setVariable [_varName,_blackboard];
_blackboard set ["Self",_unit];
true;