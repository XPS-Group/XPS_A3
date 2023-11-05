#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_AssertFailedException
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	An exception for when an assertion from <XPS_UT_Assert> has failed.

Parent:
    <XPS_typ_Exception>

Implements:
    <XPS_ifc_IException>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_AssertFailedException"],
	["#base",XPS_typ_Exception],
	
	/*----------------------------------------------------------------------------
	Property: Message
    
    	--- Prototype --- 
    	get "Message"
    	---
		
		<XPS_ifc_IException>
    
    Returns: 
		<String> - Assertion Failed
	-----------------------------------------------------------------------------*/
	["Message","Assertion Failed"]
	/*----------------------------------------------------------------------------
	Property: Source
    	<XPS_typ_Exception. Source>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Target
    	<XPS_typ_Exception. Target>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_UT_typ_AssertFailedException, _source", _target*, _message*]
        ---

    Optionals: 
        _source (optional) - <Anything>
        _target (optional) - <Anything>
        _message (optional) - <String> - custom message to override the default

	-----------------------------------------------------------------------------*/
]