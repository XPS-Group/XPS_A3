#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Enum
	<Static>
    	--- Prototype --- 
    	XPS_typ_Enum
    	---
    	
    	<XPS_Enum>

Authors: 
	Crashdome
   
Description:
	Static Class to handle all derived classes of <XPS_typ_Enumeration>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Enum"],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_typ_Enum"
		---
	-----------------------------------------------------------------------------*/
	["#str",compilefinal {_self get "#type" select  0}],
	["_isEnumerationType", compileFinal {"#type" in keys _this && {"XPS_typ_Enumeration" in (_this get "#type")}}],
	/*----------------------------------------------------------------------------
	Method: GetEnum
    
    	--- Prototype --- 
    	call ["GetEnum",[_enumHelper, _lookup]]
    	---
	
	Prameters:
		_enumHelper - <XPS_typ_Enumeration> - the helper class object which is derived from <XPS_typ_Enumerations>
		_lookup - <Number>, <String>, or <Text> - value to look up to get reference
    
    Returns: 
		<HashmapObject> - The reference to the Enumeration constant

	Throws: 
		<XPS_typ_ArgumentNilException> - when argument supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameters supplied do not conform to the above
	-----------------------------------------------------------------------------*/
	["GetEnum",  compileFinal {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_enumHelper",createhashmap,[createhashmap]],["_lookup","",[0,"",text ""]]] && {(_self call ["_isEnumerationType",_enumHelper])}) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a valid Enumeration object or lookup was not a number, string, or structured text.",_this]];};
		
		_enumHelper call ["GetEnum",_lookup];
	}],
	/*----------------------------------------------------------------------------
	Method: GetNames
    
    	--- Prototype --- 
    	call ["GetNames",_enumHelper]
    	---
	
	Prameters:
		_enumHelper - <XPS_typ_Enumerations> - the helper class object which is derived from <XPS_typ_Enumerations>
    
    Returns: 
		<Array> - of all Names of the Enumeration Type

	Throws: 
		<XPS_typ_ArgumentNilException> - when argument supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameters supplied do not conform to the above
	-----------------------------------------------------------------------------*/
	["GetNames", compileFinal {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_enumHelper",createhashmap,[createhashmap]]] && {(_self call ["_isEnumerationType",_enumHelper])}) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a valid Enumeration object.",_this]];};
		
		_enumHelper get "Names"; 
	}],
	/*----------------------------------------------------------------------------
	Method: GetValueType
    
    	--- Prototype --- 
    	call ["GetValueType",_enumHelper]
    	---
	
	Prameters:
		_enumHelper - <XPS_typ_Enumerations> - the helper class object which is derived from <XPS_typ_Enumerations>
    
    Returns: 
		<String> - can be "SCALAR", "STRING" or "TEXT"

	Throws: 
		<XPS_typ_ArgumentNilException> - when argument supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameters supplied do not conform to the above
	-----------------------------------------------------------------------------*/
	["GetValueType", compileFinal {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_enumHelper",createhashmap,[createhashmap]]] && {(_self call ["_isEnumerationType",_enumHelper])}) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a valid Enumeration object.",_this]];};
		
		_enumHelper get "ValueType"; 
	}],
	/*----------------------------------------------------------------------------
	Method: GetValues
    
    	--- Prototype --- 
    	call ["GetValues",_enumHelper]
    	---
	
	Prameters:
		_enumHelper - <XPS_typ_Enumerations> - the helper class object which is derived from <XPS_typ_Enumerations>
    
    Returns: 
		<Array> - of all Values of the Enumeration Type

	Throws: 
		<XPS_typ_ArgumentNilException> - when argument supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameters supplied do not conform to the above
	-----------------------------------------------------------------------------*/
	["GetValues", compileFinal {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_enumHelper",createhashmap,[createhashmap]]] && {(_self call ["_isEnumerationType",_enumHelper])}) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a valid Enumeration object.",_this]];};
		
		_enumHelper get "Values"; 
	}],
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",[_enumHelper, _lookup]]
    	---
	
	Prameters:
		_enumHelper - <XPS_typ_Enumeration> - the helper class object which is derived from <XPS_typ_Enumerations>
		_lookup - <Number>, <String>, or <Text> - value to look up to get reference
    
    Returns: 
		<Boolean> - <True> if _lookup value exists otherwisse <False>

	Throws: 
		<XPS_typ_ArgumentNilException> - when argument supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameters supplied do not conform to the above
    
	-----------------------------------------------------------------------------*/
	["IsDefined", compileFinal {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetEnum","Parameter supplied was Nil"]]};
		if !(params [["_enumHelper",createhashmap,[createhashmap]],["_lookup","",[0,"",text ""]]] && {(_self call ["_isEnumerationType",_enumHelper])}) then {throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"GetEnum","Argument supplied was not a valid Enumeration object or lookup was not a number, string, or structured text.",_this]];};
		
		_lookup in keys _enumHelper; 
	}]
]
	/*----------------------------------------------------------------------------
	Example: Get an Enumeration by Value with unknown Helper reference
    
		Assume the below are all class objects which inherit from <XPS_typ_Enumeration>
		and their underlying enumerations.
		---text
				TAG_Pets		TAG_Horses		TAG_Cars
		0		Cat				Arabian			Coupe
		1		Dog 			Campolina 		Sedan
		2		Bird 			Selale 			Sports Utility
		---

    	--- code 
		private _helper = selectRandom [TAG_Pets, TAG_Horses, TAG_Cars, TAG_DoesNotExist]; 
		_myResult = XPS_Enum call ["GetEnum",[_helper,1]];  
		// randomly could be "Dog", "Campolina", "Sedan" or
		// will throw an exception if TAG_DoesNotExist (nil) is randomly selected
		--- 

		NOTE: The above is functionally equivalent and a shorter version to the following
		because all type safety checks are done prior to returning a result: 
		
		--- code
		private _helper = selectRandom [TAG_Pets, TAG_Horses, TAG_Cars]; 

		if (_helper isEqualType createhashmap &&  				// make sure valid hashmap
			{"#type" in keys _helper && 						// is a hashmap "object"
			{"XPS_typ_Enumeration" in (_helper get "#type") && 	// inherits from XPS Enumeration Class
			{1 in keys _helper}}}) then {						// the value 1 is a valid key
			
			_helper call [1];						// finally, return the enumeration if successful
		} else {
			//throw some error
		}
		---
	
	-----------------------------------------------------------------------------*/