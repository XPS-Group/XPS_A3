#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing.  XPS_UT_typ_AssertInconclusiveException
	<TypeDefinition>


Authors: 
	Crashdome
   
Description:
	An exception for when an assertion from <XPS_UT_Assert> is inconclusive.

Parent:
    <core. XPS_typ_Exception>

Implements:
    <core. XPS_ifc_IException>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_AssertInconclusiveException"],
	["#base",XPS_typ_Exception],
	/*----------------------------------------------------------------------------
	Property: Data
    	<core. XPS_typ_Exception. Source>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Message
    
    	--- Prototype --- 
    	get "Message"
    	---
		
		<core. XPS_ifc_IException>
    
    Returns: 
		<String> - Assertion Inconclusive
	-----------------------------------------------------------------------------*/
	["Message","Assertion Inconclusive"]
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
        createhashmapobject [XPS_UT_typ_AssertInconclusiveException, _source*, _target*, _message*, _data*]
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
		XPS_UT_typ_AssertInconclusiveException:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	-----------------------------------------------------------------------------*/
]