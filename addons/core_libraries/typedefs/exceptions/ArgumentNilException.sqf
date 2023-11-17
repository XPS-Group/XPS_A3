#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_ArgumentNilException
	<TypeDefinition>
    	--- Prototype --- 
		XPS_typ_ArgumentNilException :  XPS_ifc_IException, XPS_typ_Exception
    	---
        --- prototype
        createhashmapobject [XPS_typ_ArgumentNilException, [_source*, _target*, _message*, _data*]]
        ---


Authors: 
	Crashdome
   
Description:
	An exception for when an argument is nil and not expected to be.

Optionals: 
	_source - (optional - Default: nil) - Anything
	_target - (optional - Default: nil) - Anything
	_message - (optional - Default: nil) - <String> - custom message to override the default
	_data - (optional - Default: nil) - <Hashmap> - hashmap of data that provides more detail to cause of exception

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_ArgumentNilException"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_Exception>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_Exception],
	/*----------------------------------------------------------------------------
	Constructor: #create
    	<XPS_typ_Exception. #create>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		XPS_typ_ArgumentNilException:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Data
    	<XPS_typ_Exception. Data>
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
    	<XPS_typ_Exception. Source>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Target
    	<XPS_typ_Exception. Target>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: GetText
    	<XPS_typ_Exception. GetText>
	-----------------------------------------------------------------------------*/
]