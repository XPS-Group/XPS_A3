#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_preprocessTypeDefinition
	
	---prototype
	_typeDefinition = [_type, _headers] call XPS_fnc_preprocessTypeDefinition
	---

Description:
    
	Preprocesses a Type Definition array and alters the code based on the following:

	Obfuscates the private Methods/Properties. 

	Takes base Array Properties with an "@" symbol and appends them together.
	
	It also has support for "Attributes" of the Methods/Properties. You can classify an Attribute
	by making it the third element of the Key/Value Pair. These Attributes do not exist once the 
	definition has been converted to a <HashmapObject>. The createHashmapObject command only cares
	about the first two elements and attributes will be discarded when instantiation occurs.

	---code
	["Key", "Value", [<Array> of Attribute Arrays] ]
	---

	Supported Attributes in the preprocessor are:

		- ["OBSOLETE"] - used on methods no longer used but kept for backwards compatibility
		- ["CTOR",value]
		- ["DTOR",value]
		- ["CTOR_LAZ",value]
		- ["DTOR_LAZY",value]
		- ["CONDITIONAL",{code}] - must return a boolean
		- ["VAILDATE_ALL", value] - see BIS command isEqualTypeAll
		- ["VAILDATE_ANY", value] - see BIS command isEqualTypeAny
		- ["VAILDATE_PARAMS", value] - see BIS command isEqualTypeParams
		- ["VAILDATE_TYPE", value] - see BIS command isEqualTypeType

	However, you can define any Attribute as long as it is in an array. The preprocessor will
	ignore custom attributes but, the first element MUST be a string. This is good if you want to 
	run your own custom preprocesser (or extend this one) before instantiating a type with 
	createHashmapPObject command.

Authors: 
	Crashdome
------------------------------------------------------------------------------

Parameter: _type 
	<Array> - an <array> of <arrays> in the format [[key1,value],[key2,value]...]  

Optional: _headers 
	<Boolean> - determines if debug headers should be injected into code blocks  

Returns: Nothing

---------------------------------------------------------------------------- */
if !(params [["_interface",nil,[[]]]]) exitwith {false};

try 
{
	//Process Keys
	private _i = 0;
	while { _i < (count _interface)} do {

		if !((_interface#_i) isEqualType []) then {throw format ["Not a valid key/value array %1 in %2",_typeDef#_i,_typeDef]};
		
		private _keyPair = _interface#_i;
		private _key = _keyPair#0;
		private _value = _keyPair#1;

		if (_key == "@" && {_value isEqualType createhashmap}) then {
			_interface deleteat _i;
			_interface insert [-1,_value toArray false,true];
		} else {
			_i = _i + 1;
		};
	};
	_interface;

} catch {
	diag_log text "XPS_fnc_preprocessInterface: Encountered the following exception:";
	diag_log text _exception;
	diag_log _this;
	false;
};
