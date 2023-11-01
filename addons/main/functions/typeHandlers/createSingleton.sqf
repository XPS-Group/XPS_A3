#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_createSingleton
	
	---prototype
	_result = [_varname, _typeDef, _args*] call XPS_fnc_createSingleton
	---

Description:
    Takes a Type Definition and creates a <Static> <HashmapObject> with a "GetInstance" method. This method can be used
	to retrieve a singleton <HashmapObject> which is stoed in a hashed global variable. It's not perfectly type-safe nor 
	perfectly guaranteed to NOT be overwritten maliciously. But, it's the closest we can get that I know of.

	- Note: If you are going to make the <HashmapObject> read-only, consider using <XPS_fnc_createStaticTypeFromFile> 
	to make it a <Static> class instead. 
	- Best if Type Definition is private or local in scope.
	- <XPS_fnc_buildTypeDefinition> should be called manually on Type Definition if local/private array.
	- The type definition should also include the NoCopy and/or Sealed flag as needed but unnecessary if allowing extendability.
	- A NoCopy flag is added if not provided. 
	- The resulting <HashmapObject> is then stored in a hashed global variable based on "#type" so, at least one must be 
	provided. This ensures hashed variable is same everytime it is created.
	- If Type Def is a string name of a Global Variable, especially a compileFinal'd hashmap, another instance CAN be created.

------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which the <HashmapObject> will be stored

	Parameter: _typeDef
		<string> - the global variable holding the type definition - Not Recommended
		<array> or <hashmap> - a full Type Definition

	Optional: _args
		<array> - an argument array sent to #create method of Type Defintion

	Return: _result
		<Boolean> - True if successful, otherwise false

------------------------------------------------------------------------------

Example: Using a definiton defined locally and built using XPS Preprocessor and Type Builder

	Recommended and preferred. Will never create a subsequent instance.
	--- Code
		private _typeDef = [
			["#type","Tag_typ_mySingleton],
			["PropA","Hello World!"],
			["Method",{hint (_self get "PropA");}]
		];

		private _processedTypeDef = [ _typeDef, false, true, true ] call XPS_fnc_buildTypeDefinition 
		["MySingleton" , _processedTypeDef] call XPS_fnc_createSingleton;
		private _singleton = MySingleton call ["GetInstance"];
    ---

Example: Using an external File and using XPS Preprocessor and Type Builder

	Recommended over using next example but, not preferred over first example.
	Potential to collide if someone calls same file with different _varName.
	--- Code
	file.sqf:
		[
			["#type","Tag_typ_mySingleton],
			["PropA","Hello World!"],
			["Method",{hint (_self get "PropA");}]
		]
    ---

	--- Code
		private _typeDef = [ call compileScript ["file.sqf"], false, true, true ] call XPS_fnc_buildTypeDefinition 
		["MySingleton" , _typeDef] call XPS_fnc_createSingleton;
		private _singleton = MySingleton call ["GetInstance"];
    ---

Example: Using a predefined global type

	WARNING: Not Recommended!
	It's more dangerous than previous example because a globally cached type is easier to retrieve than a file.
	--- Code
		["MySingleton" , Tag_typ_mySingleton] call XPS_fnc_createSingleton;
		private _singleton = MySingleton call ["GetInstance"];
    ---

	The reason this is DANGEROUS is because, if you were to do the following:
	--- Code
		["MySingleton2" , Tag_typ_mySingleton] call XPS_fnc_createSingleton;
		private _singleton = MySingleton2 call ["GetInstance"];
	---
	It would overwrite the hidden singleton instance and both MySingleton and MySingleton2 would refer to the same (2nd) instance.

Authors: 
	Crashdome
------------------------------------------------------------------------------*/

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
