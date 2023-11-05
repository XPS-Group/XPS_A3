#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_AssertInconclusiveException
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
	["#type","XPS_UT_typ_AssertInconclusiveException"],
	["#base",XPS_typ_Exception],
	
	
	/*----------------------------------------------------------------------------
	Property: Message
    
    	--- Prototype --- 
    	get "Message"
    	---
		
		<XPS_ifc_IException>
    
    Returns: 
		<String> - Assertion Inconclusive
	-----------------------------------------------------------------------------*/
	["Message","Assertion Inconclusive"]
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