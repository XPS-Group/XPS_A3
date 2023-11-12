#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. exceptions. XPS_typ_ArgummentNilException
	<TypeDefinition>


Authors: 
	Crashdome
   
Description:
	An exception for when an argument is nil and not expected to be.

Parent:
    <XPS_typ_Exception>

Implements:
    <XPS_ifc_IException>

Flags:
    none

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_ArgummentNilException"],
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
		<String> - Argument was Nil when Nil is not Accepted
	-----------------------------------------------------------------------------*/
	["Message","One or more arguments were Nil when Nil is not Accepted"]
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
        createhashmapobject [XPS_typ_ArgummentNilException, _source*, _target*, _message*, _data*]
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
		XPS_typ_ArgummentNilException:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	-----------------------------------------------------------------------------*/
]