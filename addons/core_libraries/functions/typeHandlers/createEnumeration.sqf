#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: core. typeHandlers. XPS_fnc_createEnumeration
	
	---prototype
	_result = [_varname, _typeDef] call XPS_fnc_createEnumeration
	---

Description:
    Takes a Type Definition and creates a static helper <HashmapObject> with methods to hold and 
	retrieve <Enumeration> objects. Can be used to perform additional operations
	on them as well. This function only accepts definitions of the 'enum' type.

	The 'enum' type should only contain three things:

	- The "ValueType" property with a value of either "SCALAR", "STRING", or "TEXT" 
	- The "Enums" proeprty 
		- an <Array> of either:
			- <Strings> - only if "ValueType" is "SCALAR" - value will be an incremental number
			- an <Array> Key/Value pair in format : [ <String> , Value ] where Value is one of the above three acceptable types


------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which a <Static> of this type will be stored

	Parameter: _typeDef
		<string> - the global variable holding the type definition
		<array> or <hashmap> - a full Type Definition

	Return: _result
		<Boolean> - <True> if successful, otherwise false

------------------------------------------------------------------------------*/
if !(params [ ["_varName",nil,[""]], ["_typeDef",nil,[[]]] ]) exitwith {false};

private _fnc_createEnumConstant = {
	params ["_var","_name","_val","_def"];

	private _hashObject = compilefinal createhashmapobject [[
		["#str", compilefinal format["%1",str _name]],
		["#type", format["%1_%2",_var,_name]],
		["#flags",["sealed","nocopy"]],
		["Value",_val]
	]];
	private _gVar = format["%1_%2",_var,_name];
	private _objInstance = call compile _gVar;
	if (isNil "_objInstance" || {_objInstance isNotEqualTo _hashObject}) then {call compile format["%1 = _hashObject",_gvar];_objInstance = _hashObject};
	_def set [_name , compileFinal _gVar ];
	_def set [_val , compilefinal _gVar ];
};

private _baseDef = createhashmapfromarray _typeDef;

private _newDef = createhashmap;
	_newDef set ["#str",compilefinal format ["%1",str _varName]];
	_newDef set ["#type",_baseDef getOrDefault ["#type","unknown type"]];
	_newDef set ["#base",_baseDef getOrDefault ["#base",XPS_typ_Enumeration]];
	_newDef set ["#flags",["sealed","nocopy"]],
	_newDef set ["Names",[]];
	_newDef set ["Values",[]];

private _enumType = if (toUpper (_baseDef get "ValueType") in ["STRING","SCALAR","TEXT"]) then {toUpper (_baseDef get "ValueType")} else {"SCALAR"};
_newDef set ["ValueType",_enumType];


private _keyArray = _baseDef getOrDefault ["Enumerations",[]];

switch (true) do {
	case (_keyArray isEqualTypeAll "" && {_enumType isEqualTo "SCALAR"}) : {
		private _value = 0;
		{	
			private _key = _x;
			private _nameOk = _newDef get "Names" pushBackUnique _key;
			if (_nameOK == -1) then {continue};
			_newDef get "Values" pushback _value;
			
			[_varName,_key,_value,_newDef] call _fnc_createEnumConstant;
			
			_value = _value + 1;
		} foreach _keyArray;
	};
	case (_keyArray isEqualTypeAll []) : {
		{	
			if !(_x params [ ["_key","",[""]], ["_value","",[0,""]]]) exitwith {false};
			
			if ((_enumType isEqualTo "SCALAR" && {_value isEqualType 0}) ||
			(_enumType in ["STRING","TEXT"] && {_value isEqualType ""}) ) then {
				private _nameOk = _newDef get "Names" pushBackUnique _key;
				if (_nameOK == -1) then {continue};
				
				if (_enumType isEqualTo "TEXT") then { _value = text _value}; 
				private _valOk = _newDef get "Values" pushbackUnique _value;
				if (_valOk == -1) then {_newDef get "Names" deleteat _nameOK; continue};
				
				[_varName,_key,_value,_newDef] call _fnc_createEnumConstant;
			};
		} foreach _keyArray;
	};
};

call compile format["%1 = compilefinal createhashmapobject [_newDef,[]]",_varName];

true;
/*------------------------------------------------------------------------------

Example: Using a definiton defined locally with no provided values

	--- Code
		private _enumDef = [
			["#type","TAG_typ_Pets"],
			["ValueType","SCALAR"],
			["Enumerations", [ "None", "Cat", "Dog", "Bird"]]
		];

		private _result = ["TAG_Pets", _typeDef ] call XPS_fnc_createEnumeration; 
	---

	This will result in the following variables in being defined with the following <HashmapObjects>:
	
	*TAG_Pets* - A Static class 

	---text
		#str		"TAG_typ_Pets"
		#type		["TAG_typ_Pets", "XPS_typ_Enumeration"]
		Names		[ "None", "Cat", "Dog", "Bird"]
		Values		[ 0 , 1 , 2 , 3 ]
		None		{TAG_Pets_None}		:(code) - to get ref use : TAG_Pets call ["None"]
		Cat			{TAG_Pets_Cat}		:(code) - to get ref use : TAG_Pets call ["Cat"]
		Dog			{TAG_Pets_Dog}		:(code) - to get ref use : TAG_Pets call ["Dog"]
		Bird		{TAG_Pets_Bird}		:(code) - to get ref use : TAG_Pets call ["Bird"]
		0			{TAG_Pets_None}		:(code) - to get ref use : TAG_Pets call [0]
		1			{TAG_Pets_Cat}		:(code) - to get ref use : TAG_Pets call [1]
		2			{TAG_Pets_Dog}		:(code) - to get ref use : TAG_Pets call [2]
		3			{TAG_Pets_Bird}		:(code) - to get ref use : TAG_Pets call [3]
		GetEnum		Method to retrieve the global variable 'constant'
		IsDefined	Method to determine if Name or Value exists
	---

	*TAG_Pets_None* - Static Class

	---text
		#str	"None"
		#type	"TAG_Pets_None"
		Value	0
	---
		

	*TAG_Pets_Cat* - Static Class

	---text
		#str	"Cat"
		#type	"TAG_Pets_Cat"
		Value	1
	---
		
	*TAG_Pets_Dog* - Static Class

	---text
		#str	"Dog"
		#type	"TAG_Pets_Dog"
		Value	2
	---

	*TAG_Pets_Bird* - Static Class

	---text
		#str	"Bird"
		#type	"TAG_Pets_Bird"
		Value	3
	---


	With which you can do the following (and more)

	--- code 		
		// Getting an Enumeration by name or value
		private _myPet = TAG_Pets call [1]; // Dog - 2
		
		// Getting an Enumeration by name or value alternative
		private _myOtherPet = TAG_Pets call ["GetEnum","Cat"];  // Cat -1

		// Getting an Enumeration by variable
		private _myNeighborsPet = TAG_Pets_Bird;  // Bird - 3

		// Getting an Enumeration's name or value
		private _myPetValue = _myPet get "Value"; // 2
		private _myPetName = str _myPet;  // "Dog"

		// Comparing Enumerations
		private _areSame = _myPet isEqualTo _myOtherPet; // False
		private _isDog = TAG_Pets_Dog isEqualRef _mypet;  // True
		private _areAnyBird = TAG_Pets_Bird in [_mypet, _myOtherPet]; // False

		_myPet = Tag_Pets call [selectrandom [1,2,3]];
		switch (_myPet) do {
			case TAG_Pets_Dog : {
				hint "I am a good boy!!"
			};
			case TAG_Pets_Cat : {
				hint "I am a jerk."
			};
			case TAG_Pets_Bird : {
				hint "Chirp!!"
			};
		};
    ---

Authors: 
	Crashdome
------------------------------------------------------------------------------*/
