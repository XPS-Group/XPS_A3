#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing.  XPS_UT_typ_AssertInconclusiveException
	<TypeDefinition>
		---prototype
		XPS_UT_typ_AssertInconclusiveException : core.XPS_ifc_IException, core.XPS_typ_Exception
		---
        --- prototype
        createHashmapObject [XPS_UT_typ_AssertInconclusiveException, _source*, _target*, _message*, _data*]
        ---

Authors: 
	Crashdome
   
Description:
	An exception for when an assertion from <XPS_UT_Assert> is inconclusive.
    
Optionals: 
	_source - (optional - Default: nil) - Anything
	_target - (optional - Default: nil) - Anything
	_message - (optional - Default: nil) - <String> - custom message to override the default
	_data - (optional - Default: nil) - <Hashmap> - hashmap of data that provides more detail to cause of exception

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_AssertInconclusiveException"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<core. XPS_typ_Exception>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_Exception],
	/*----------------------------------------------------------------------------
	Constructor: #create
    	<core. XPS_typ_Exception. #create>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		XPS_UT_typ_AssertFailedException:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	----------------------------------------------------------------------------*/
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
	Property: Source
    	<core. XPS_typ_Exception. Source>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Target
    	<core. XPS_typ_Exception. Target>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetText
    	<core. XPS_typ_Exception. GetText>
	-----------------------------------------------------------------------------*/
]