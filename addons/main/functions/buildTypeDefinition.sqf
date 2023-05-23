#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_buildTypeDefinition
	
	---prototype
	_typeDefintion = [_type] call XPS_fnc_buildTypeDefinition
	---

	---prototype
	_typeDefintion = [_type, true] call XPS_fnc_buildTypeDefinition
	---

Description:
    Used to define a global declaration for a <Hashmap> or <HashmapObject> 

	Has extra enhancements for inheritance and interfacing by looking for the following keys:

	#parent - <Array> - the type definition of the parent object in the format [[key1,value],[key2,value]...] 

	#interfaces - <Array> - an <array> of <arrays> in the format [[key1,type],[key2,type]...] where type is the <string> of the native type

	Note: Multiple interface arrays can be appended together to allow for multiple interface contracts

Parameter: _type 

<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Optional: _allowNils* 

<Boolean> - (optional) default: true - used to allow keys with nil values when checking interface validity

Return: _typeDefinition
	<TypeDefinition> - or False if error

Example: No Inheritance
    --- Code
		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'
    ---

Example: Implements Interface
    --- Code
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];
		
		//This FAILS because PropertyA and Method do not exist
		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["#interfaces","MyInterface"],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		//Does not fail because PropertyA and Method exist
		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["#interfaces","MyInterface"],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'
    ---

Example: Implements Interface with Inheritance
    --- Code
		MyInterface = [["PropertyA","STRING"],["Method","CODE"]];

		MyTypeDefA = [["#str",compileFinal {"TAG_TypeA"}],["#interfaces","MyInterface"],["PropertyA","Hello"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
        TAG_TypeA = ["MyTypeDefA"] call XPS_fnc_buildTypeDefinition; 

		MyTypeDefB = [["#str",compileFinal {"TAG_TypeB"}],["#parent","MyTypeDefA"],["PropertyA","Goodbye"],["Method",compileFinal {hint "Bye"}]];
        TAG_TypeB = ["MyTypeDefB"] call XPS_fnc_buildTypeDefinition; 

		// Both TypeA and TypeB will implement interface from inheritance but PropertyA and Method are overridden in TypeB 
		private _myObjA = createhashmapobject [TypeA];
		_myObj call ["Method"] //hints 'Hi'

		private _myObjB = createhashmapobject [TypeB];
		_myObj call ["Method"] //hints 'Bye'
    ---

Authors: 
	Crashdome

---------------------------------------------------------------------------- */

if !(params [["_type",nil,[[]]],"_allowNils"]) exitwith {false;};
_allowNils = [_allowNils] param [0,true,[true]];

private _hashmap = createhashmapfromarray _type;

//Check for parent type
if ("#parent" in keys _hashmap) then {
	private _pTypeName = _hashmap get "#parent";
	private _pType = call compile _pTypeName;
	private _parent = createhashmapfromarray _pType;
	private _pIfcs = if ("#interfaces" in keys _parent) then {_parent get "#interfaces"} else {[]};
	private _Ifcs = if ("#interfaces" in keys _hashmap) then {_hashmap get "#interfaces"} else {[]};
	_pIfcs insert [-1,_Ifcs,true];
	//Create base methods as "ParentType.MethodString"
	private _keys = keys _hashmap;
	{
		if (_x in _keys && typename _x == "STRING" && typename _y == "CODE") then {_hashmap set [format["%1.%2",_pTypeName,_x],_y];}
	} foreach _parent;
	_parent merge [_hashmap,true];
	//if (count keys _pIfcs > 0) then {_parent set ["#interfaces",call compile (str _pIfcs)]};
	_hashmap = +_parent;
};

private _interfaces = if ("#interfaces" in keys _hashmap) then {_hashmap get "#interfaces"} else {[]};

if ([_hashmap,_interfaces,_allowNils] call XPS_fnc_checkInterface) then {
	call compile (str _hashmap);
} else {
	false;
};



