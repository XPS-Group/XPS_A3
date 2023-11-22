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
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_ifc_IEnumeration>
	-----------------------------------------------------------------------------*/
	["@interfaces",[XPS_typ_IEnumeration]]
	/*----------------------------------------------------------------------------
	Method: GetEnum
    
    	--- Prototype --- 
    	call ["GetEnum",[_enumHelper, _lookup]]
    	---
	
	Prameters:
		_enumHelper - <HashmapObject> - the helper class object which is derived from <XPS_typ_Enumerations>
		_lookup - <Anything> - value to look up to get reference
    
    Returns: 
		<HashmapObject> - The reference to the Enumeration constant or nil
	-----------------------------------------------------------------------------*/
	["GetEnum", {
		params [["_lookup","",[0,"",text ""]]];
		if (_self call ["IsDefined",_lookup]) then {
			call compile (_self get _lookup);
		} else {nil};
	}],
	/*----------------------------------------------------------------------------
	Method: GetNames
    
    	--- Prototype --- 
    	call ["GetNames",[_enumHelper]]
    	---
	
	Prameters:
		_enumHelper - <HashmapObject> - the helper class object which is derived from <XPS_typ_Enumerations>
    
    Returns: 
		<Array> - of all Names of the Enumeration Type
	-----------------------------------------------------------------------------*/
	["GetNames",{
		params [["_enumHelper",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumHelper && {"XPS_typ_Enumeration" in _enumHelper get "#type"}) exitwith {false};
		
		_enumHelper get "Names"; 
	}],
	/*----------------------------------------------------------------------------
	Method: GetValueType
    
    	--- Prototype --- 
    	call ["GetValueType",[_enumHelper]]
    	---
	
	Prameters:
		_enumHelper - <HashmapObject> - the helper class object which is derived from <XPS_typ_Enumerations>
    
    Returns: 
		<String> - can be "SCALAR", "STRING" or "TEXT"
	-----------------------------------------------------------------------------*/
	["GetValueType",{
		params [["_enumHelper",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumHelper && {"XPS_typ_Enumeration" in _enumHelper get "#type"}) exitwith {false};
		
		_enumHelper get "ValueType"; 
	}],
	/*----------------------------------------------------------------------------
	Method: GetValues
    
    	--- Prototype --- 
    	call ["GetValues",[_enumHelper]]
    	---
	
	Prameters:
		_enumHelper - <HashmapObject> - the helper class object which is derived from <XPS_typ_Enumerations>
    
    Returns: 
		<Array> - of all Values of the Enumeration Type
	-----------------------------------------------------------------------------*/
	["GetValues",{
		params [["_enumHelper",createhashmap,[createhashmap]]];
		if !("#type" in keys _enumHelper && {"XPS_typ_Enumeration" in _enumHelper get "#type"}) exitwith {false};
		
		_enumHelper get "Values"; 
	}],
	/*----------------------------------------------------------------------------
	Method: IsDefined
    
    	--- Prototype --- 
    	call ["IsDefined",[_enumHelper, _lookup]]
    	---
	
	Prameters:
		_enumHelper - <HashmapObject> - the helper class object which is derived from <XPS_typ_Enumerations>
		_lookup - <Anything> - value to look up to see if Name or Value exists
    
    Returns: 
		<Boolean> - <True> if _lookup value exists otherwisse <False>
	-----------------------------------------------------------------------------*/
	["IsDefined",{
		params [["_enumHelper",createhashmap,[createhashmap]],["_lookup","",[0,"",text ""]]];
		if !("#type" in keys _enumHelper && {"XPS_typ_Enumeration" in _enumHelper get "#type"}) exitwith {false};
		
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
		private _helper = selectRandom [TAG_Pets, TAG_Horses, TAG_Cars]; 
		_myResult = XPS_Enum call ["GetEnum",[_helper,1]];  //randomly could be "Dog", "Campolina", or "Sedan"
    	---
	
	-----------------------------------------------------------------------------*/