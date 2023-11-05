#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_AssertFailedException
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores a message
the exception.

Parent:
    none

Implements:
    <XPS_UT_ifc_IException>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#str", {[_self get "#type" select 0, _self get "Message"]}],
	["#type","XPS_UT_typ_AssertFailedException"],
	["@interfaces",["XPS_UT_ifc_IException"]],
	
	/*----------------------------------------------------------------------------
	Property: Message
    
    	--- Prototype --- 
    	get "Message"
    	---
		
		<XPS_UT_ifc_IException>
    
    Returns: 
		<String> - A message about the exception thrown
	-----------------------------------------------------------------------------*/
	["Message",""],
	
	/*-----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_UT_typ_AssertFailedException",_message]
    	---
    
    Optionals: 
		message* - <String> - (Optional - Default : "") the message about the exception thrown
		to be set on Message Property

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",{
		params [["_message",nil,[""]]];
		if !(isNil {_message}) then {
			_self set ["Message",_message];
		};
	}]
]