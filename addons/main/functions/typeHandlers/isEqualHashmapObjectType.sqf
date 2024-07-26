#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_isEqualHashmapObjectType
	
	---prototype
	_result = [_type1, _type2, _strict*] call XPS_fnc_isEqualHashmapObjectType
	---

Description:
    Used to determine if a <HashmapObject> and another <HashmapObject> share an uderlying 'type' in "#type" <array>.


Authors: 
	Crashdome
----------------------------------------------------------------------------

Parameter: _type1
	<HashMap> or <HashmapObject> - the first hashmap/object to check

Parameter: _type1
	<HashMap> or <HashmapObject> - the second hashmap/object to check

Parameter: _strict*
	<Boolean> - (Optional - Default : true) - a flag to determine whether #type <arrays> should be exactly equal (true) or if
	simply a common parent is valid (false) 

Returns: _result
	<Boolean> - <True> if both <HashmapObjects> have a common parent type or in case of strict checking, are exactly the same type

Example: Check two of same type
    --- Code
    private _def = [["#type","Tag_typ_MyType"],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
		
		_type1 = createhashmapobject [_def];
		_type2 = createhashmapobject [_def];

        private _result = [_type1, _type2, false] call XPS_fnc_isEqualHashmapObjectType; 
		// _result is 'true'

        private _result = [_type1, _type2, true] call XPS_fnc_isEqualHashmapObjectType; 
		// _result is 'true'
    ---

Example: Check two child types
    --- Code
	private _baseDef = [["#type","Tag_typ_MyBase"]];
    private _def1 = [["#type","Tag_typ_MyType1"],["#base",_baseDef],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
    private _def1 = [["#type","Tag_typ_MyType2"],["#base",_baseDef],["Method",compileFinal {hint "Hi"}],["PropertyB",10]];
		
		_type1 = createhashmapobject [_def1];
		_type2 = createhashmapobject [_def2];
        
		private _result = [_type1, _type2, false] call XPS_fnc_isEqualHashmapObjectType; 
		// _result is 'true'
        
		private _result = [_type1, _type2, true] call XPS_fnc_isEqualHashmapObjectType; 
		// _result is 'false'
    ---
---------------------------------------------------------------------------- */

params [["_type1",createhashmap,[createhashmap]],["_type2",createhashmap,[createhashmap]],["_strict",true,[true]]];

private _types1 = (_type1 getOrDefault ["#type",[call XPS_fnc_createUniqueID]]) apply {toLower _x;};
private _types2 = (_type2 getOrDefault ["#type",[call XPS_fnc_createUniqueID]]) apply {toLower _x;};

if (_strict) then {
	_types1 isEqualTo _types2;
} else {
	count (_types1 arrayIntersect _types2) > 0;
};