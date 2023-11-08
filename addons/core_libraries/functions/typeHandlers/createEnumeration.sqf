#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: core. typeHandlers. XPS_fnc_createEnumeration
	
	---prototype
	_result = [_varname, _typeDef] call XPS_fnc_createEnumeration
	---

Description:
    Takes a Type Definition and creates a <HashmapObject> with methods to hold and 
	retrieve <Enumeration> objects. Can be used to perform additional operations
	on them as well. This function only accepts definitions of the 'enum' type.

	The 'enum' type should only contain three things:

	- The "ValueType" property with a value of either "SCALAR", "STRING", or "TEXT" 
	- The "Enums" proeprty 
		- an <Array> of
			- a <String> - only if "ValueType" is "SCALAR" - value will be an incremental number
			- an <Array> Key/Value pair in format : [ <String> , Value ] where Value is one of the above three acceptable types


------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which a <Static> of this type will be stored

	Parameter: _typeDef
		<string> - the global variable holding the type definition
		<array> or <hashmap> - a full Type Definition

	Return: _result
		<Boolean> - True if successful, otherwise false

------------------------------------------------------------------------------*/
if !(params [ ["_varName",nil,[""]], ["_typeDef",nil,[[]]] ]) exitwith {false};

private _fnc_createEnumConstant = {
	params ["_var","_name","_val","_def"];

	private _hashObject = createhashmapobject [[
		["#str", compilefinal format["%1",str _name]],
		["#type", format["%1_%2",_var,_name]],
		["Value",_val]
	]];
	_def set [_name , _hashObject ];
	_def set [_val , _hashObject ];
	private _statement =  format["%1_%2 = compileFinal _hashObject;",_var,_name]; 
	call compile _statement;
};

private _baseDef = createhashmapfromarray _typeDef;

private _newDef = createhashmap;
	_newDef set ["#str",compilefinal format ["%1",str _varName]];
	_newDef set ["#type",_baseDef getOrDefault ["#type","unknown type"]];
	_newDef set ["#base",XPS_typ_Enumeration];
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
			_newDef get "Values" pushback _i;
			
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

private _finalObj = createhashmapobject [_newDef];
call compile format["%1 = compileFinal _finalObj",_varName];

true;
/*------------------------------------------------------------------------------

Example: Using a definiton defined locally with no provided values

	--- Code
		private _enumDef = [
			["#type","TAG_enum_Pets"],
			["ValueType","SCALAR"],
			["Enumerations", [ "None", "Cat", "Dog", "Bird"]]
		];

		private _result = ["TAG_Pets", _typeDef ] call XPS_fnc_createEnumeration; 
	---

	Thi will result in the following variables in being defined with the following <HashmapObject>:
	
	*TAG_Pets* - A Static class 

		#str - "TAG_enum_Pets"
		#type - ["TAG_enum_Pets", "XPS_typ_Enumeration"]
		Names - [ "Cat", "Dog", "Bird"]
		Values - [ 0, 1 ,2 ]
		Cat - TAG_Pets_Cat <HashmapObject>
		Dog - TAG_Pets_Dog <HashmapObject>
		Bird - TAG_Pets_Bird <HashmapObject>
		0 - TAG_Pets_Cat <HashmapObject>
		1 - TAG_Pets_Dog <HashmapObject>
		2 - TAG_Pets_Bird <HashmapObject>


	*TAG_Pets_Cat*

		#str - "Cat"
		#type - "TAG_enum_Pets_Cat"
		Value - 0
		
	*TAG_Pets_Dog*

		#str - "Dog"
		#type - "TAG_enum_Pets_Dog"
		Value - 1

	*TAG_Pets_Bird*

		#str - "Bird"
		#type - "TAG_enum_Pets_Bird"
		Value - 2

	With which you can do the following (and more)
	--- code 		
		private _myPet = TAG_Pets get 1; // Dog - 1
		private _myOtherPet = TAG_Pets get "Cat";  // Cat - 0

		private _areSame = _myPet isEqualTo _myOtherPet; // False
		
		private _isDog = TAG_Pets get "Dog" isEqualRef _mypet;  // True

		private _areAnyBird = "Bird" in [str _mypet, str _myOtherPet]; // False

		_myPet = Tag_Pets get selectrandom [0,1,2]
		switch (_myPet) do {
			case (TAG_Pets get "Dog") : {
				hint "I am a good boy!!"
			};
			case (TAG_Pets get "Cat") : {
				hint "I am a jerk."
			};
			case (TAG_Pets get "Bird") : {
				hint "Chirp!!"
			};
		};
    ---
Authors: 
	Crashdome
------------------------------------------------------------------------------*/
