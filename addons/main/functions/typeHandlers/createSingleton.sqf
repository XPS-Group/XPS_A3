#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_createSingleton
	
	---prototype
	_result = [_varname, _typeDef, _args*] call XPS_fnc_createSingleton
	---

Description:
    Takes a Type Definition and creates a <Static> <HashmapObject> with a "GetInstance" method. This method can be used
	to retrieve a singleton <HashmapObject> which is stored in a randomized global variable. It's not perfectly safe nor 
	perfectly guaranteed to NOT be overwritten maliciously. But, it's the closest we can get that I know of.

	Notes:
	- If you would like to make the <HashmapObject> read-only and truly secure, consider using <XPS_fnc_createStaticTypeFromFile> 
	to make it a <Static> class instead. 
	- Best if Type Definition is private or local in scope and calls this function directly - To prevent developers from creating non-singleton copies.
	- <XPS_fnc_buildTypeDefinition> should be called manually on Type Definition if local/private array (if needed).
	- The type definition *should* also include the NoCopy and/or Sealed flag but, Sealed is unnecessary if allowing run-time extendability.
	- A NoCopy flag is added if not provided. This ensures an accidental copy is not made and subsequently any code that possibly references a clone'd instance 
	- The resulting <HashmapObject> is then stored in a randomizeed global variable. This function will *only* check the static method's global variable
	 and if that variable has a value, fail if already assigned.
	- Because the instance location can be inspected at run-time and maliciously altered, it is recommended that Singleton / Multiton objects
	are only ever created in a secured environment - e.g. on the game server
	- *Why have the instance in a randomized variable and not say, a hash of the typename?* I originally used a hash so I could determine if the actual instance was already
	created but, it was determined that if someone wanted to, they could figure out the hash variable name and send a publicvariable client-side to 
	replace that instance. Randomized is more secure.

	Results In Summary:
		- A <Static> object in a global variable (_varName parameter) with a single Method to return the singleton object 
			--- code
			VarName call ["GetInstance"]
			---
		- An instance of the singleton stored in a randomized global variable 

	Multiton Alternative:
		Calling this function with the same definition multiple times with a different _varName parameter each time, effectively turns this into
		a Multiton creator.

------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which the <HashmapObject> will be stored

	Parameter: _typeDef
		<string> - the global variable holding the type definition - Not Recommended
		<array> or <hashmap> - a full Type Definition

	Optional: _args
		<array> - an argument array sent to #create method of Type Defintion

	Return: _result
		<Boolean> - <True> if successful, otherwise false

------------------------------------------------------------------------------

Example: Using a definiton defined locally and built using XPS Preprocessor and Type Builder

	--- Code
		private _typeDef = [
			["#type","Tag_typ_mySingleton],
			["PropA","Hello World!"],
			["Method", compileFinal {hint (_self get "PropA");}]
		];

		private _processedTypeDef = [ _typeDef, false, true, true ] call XPS_fnc_buildTypeDefinition 
		["MySingleton" , _processedTypeDef] call XPS_fnc_createSingleton;
    ---
		
	--- Code
		private _singleton = MySingleton call ["GetInstance"];
    ---

Example: Using an external File and using XPS Preprocessor and Type Builder

	--- Code
	file.sqf:
		[
			["#type","Tag_typ_mySingleton],
			["PropA","Hello World!"],
			["Method", compileFinal {hint (_self get "PropA");}]
		]
    ---

	--- Code
		private _typeDef = [ call compileScript ["file.sqf"], false, true, true ] call XPS_fnc_buildTypeDefinition 
		["MySingleton" , _typeDef] call XPS_fnc_createSingleton;
    ---
		
	--- Code
		private _singleton = MySingleton call ["GetInstance"];
    ---

Example: Using a predefined global type

	--- Code
		["MySingleton" , Tag_typ_mySingleton] call XPS_fnc_createSingleton;
    ---
		
	--- Code
		private _singleton = MySingleton call ["GetInstance"];
    ---

Example: Subsequent calling
	
	if you were to do the following:
	
	--- Code
		_result = ["MySingleton" , Tag_typ_mySingleton] call XPS_fnc_createSingleton; // _result will be true (succeeded first instance)
		_result = ["MySingleton" , Tag_typ_mySingleton] call XPS_fnc_createSingleton; // This will fail since MySingleton already exists
		private _singleton = MySingleton call ["GetInstance"];
	---
	A report would be logged and subsequent instance would be discarded 

	However, consider the following:

	--- Code
		_result = ["MySingleton" , Tag_typ_mySingleton] call XPS_fnc_createSingleton; // _result will be true (succeeded first instance)
		_result = ["MySingleton2" , Tag_typ_mySingleton] call XPS_fnc_createSingleton; // _result will also be true (now it is a Multiton)
		private _singleton = MySingleton call ["GetInstance"]; // first instance
		private _singleton2 = MySingleton2 call ["GetInstance"]; // second and completely different instance
	---


Authors: 
	Crashdome
------------------------------------------------------------------------------*/

if !(params [ ["_varname",nil,[""]], ["_typedef",nil,["",[],createhashmap]], "_args"]) exitwith {false;};
_args = [_args] param [0,[],[[]]];


if (isNil _varName) then {
				

	private _instanceVar = "xps_sgltn_" + _varName; // static name for debugging

	if !(XPS_DebugMode) then {
		//Obfuscate instance variable name	
		private _attempts = 0;
		private _instanceVar = "_attempts"; // ensure _instanceVar is NOT nil on first attempt	
		while {!(isNil _instanceVar) && _attempts < 100} do {
			_instanceVar = "xps_sgltn_" + call XPS_fnc_getUniqueID; 
			_attempts = _attempts + 1;
		};
	};

	// First: Check if String Code
	if (_typeDef isEqualType "") then {
		_typeDef = call compile _typeDef;
	};

	// Second: Create hashmap if array
	if (_typeDef isEqualType []) then {
		_typeDef = createhashmapfromarray _typeDef;
	};

	//Throw error if not hashmap by now
	if !(_typeDef isEqualType createhashmap) exitwith {diag_log text format["XPS_fnc_createSingleton: TypeDef for %1 was not valid.",_varName]; false};

	_typeDef = +_typeDef;
	//add noCopy
	if ("#flags" in _typeDef ) then {
		_typeDef get "#flags" pushbackUnique "noCopy";
	} else {
		_typeDef set ["#flags",["noCopy"]];
	};

	call compile format["%1 = createhashmapobject [%2,%3];",_instanceVar,_typeDef,_args];

	private _staticDefPath = "x\xps\addons\main\staticSingletonDef.sqf";

	[_varName,_staticDefPath] call XPS_fnc_createStaticTypeFromFile;

	true;

} else {
	diag_log text format["XPS_fnc_createSingleton: Attempt to create another instance of %1",_varName];
	false;
};
