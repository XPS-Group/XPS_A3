#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing.  XPS_UT_typ_AssertFailedException
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	An exception for when an assertion from <XPS_UT_Assert> has failed.

Parent:
    <core. XPS_typ_Exception>

Implements:
    <core. XPS_ifc_IException>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_AssertFailedException"],
	["#base",XPS_typ_Exception],
	
	/*----------------------------------------------------------------------------
	Property: Data
    
    	--- Prototype --- 
    	get "Data"
    	---

		<XPS_ifc_IException>

    	<XPS_typ_Exception. Data>
    
    Returns: 
		<Hashmap> - provides more detail about the exception
	-----------------------------------------------------------------------------*/
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
    
    	--- Prototype --- 
    	get "Source"
    	---
		
		<XPS_ifc_IException>

    	<XPS_typ_Exception. Source>
    
    Returns: 
		Anything - typcally the source <HashmapObject> that caused this error
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Target
    
    	--- Prototype --- 
    	get "Target"
    	---
		
		<XPS_ifc_IException>

    	<XPS_typ_Exception. Target>
    
    Returns: 
		Anything - typcally the Method or Script Name that caused this error
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_UT_typ_AssertFailedException, _source*, _target*, _message*, _data*]
        ---
    
    Optionals: 
        _source - (optional - Default: nil) - Anything
        _target - (optional - Default: nil) - Anything
        _message - (optional - Default: nil) - <String> - custom message to override the default
        _data - (optional - Default: nil) - <Hashmap> - hashmap of data that provides more detail to cause of exception

	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetText
    
        --- prototype
        call ["GetText"]
        ---

	Returns:
		<Text> - A Structured Text formatted as follows:

		---text
		XPS_UT_typ_AssertFailedException:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	-----------------------------------------------------------------------------*/
]