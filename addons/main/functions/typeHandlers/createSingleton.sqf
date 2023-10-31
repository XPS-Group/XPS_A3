#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_createSingleton
	
	---prototype
	_result = [_varname, _typeDef, _args*] call XPS_fnc_createSingleton
	---

Description:
    Takes a Type Definition and creates a <HashmapObject>. Best if Type Definition is private or local in scope.
	If Type Def is a string name of a Global Variable, especially a compileFinal'd hashmap, another instance CAN be created.

	A NoCopy flag is added if not provided. The resulting <HashmapObject> is then stored in a hashed global variable
	based on "#type" so, at least one must be provided. This ensures hashed variable is same everytime it is created.

	It then sets the missionNamespace variable name from parameter "_varName" to a cStatic> <HashmapObject> which
	contains a method "GetInstance" which will return the Singleton Instance of the <HashmapObject>.

	- XPS_fnc_buildTypeDefintion should be called manually on Type Definition if local/private array.
	- The type definition should also include the NoCopy and/or Sealed flag as needed but unnecessary if allowing extendability.

Example: File and calling code example

	To create the Singleton from above file:
	--- Code
		["MySingleton" , "Tag_typ_MySingletnClass"] call XPS_fnc_createSingletonFromFile;
		_instance = MySingleton call ["GetInstance"];
    ---

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which the <HashmapObject> will be stored

	Parameter: _typeDef
		<string> - the global variable holding the type definition
		<array>/<hashmap> - a full Type Definition

	Optional: _args
		<string> - the global variable holding the type definition
		<array> - an argument array sent to #create method of Type Defintion

	Return: _result
		<Boolean> - True if successful, otherwise false

---------------------------------------------------------------------------- */

if !(params [ ["_varname",nil,[""]], ["_typedef",nil,["",[],createhashmap]], "_args"]) exitwith {false;};
_args = [_args] param [0,[],[[]]];

if (_typeDef isEqualType "") then {
	_typeDef = call compile _typeDef;
};

if (_typeDEf isEqualType []) then {
	_typeDef = createhashmapfromarray _typeDef;
};

if ("#flags" in keys _typeDef ) then {
	_typeDef get "#flags" pushbackUnique "noCopy";
} else {
	_typeDef set ["#flags",["noCopy"]];
};

private _hash = (hashValue (_typeDef get "#type")) regexReplace ["[\+\\]","_"]; // repalace + and \ with _

call compile format["%1 = createhashmapobject [%2,%3];",_hash,_typeDef,_args];

private _staticDef = [
	["#type","XPS_typ_Static_Singleton"],
	["GetInstance",compile format["%1",_hash]]
];

call compile format["%1 = compileFinal createhashmapobject [%2]",_varName,_staticDef];

true;
