#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Exception
	<TypeDefinition>
    	--- Prototype --- 
		XPS_typ_Exception :  XPS_ifc_IException
    	---
        --- prototype
        createHashmapObject [XPS_typ_Exception, [_source*, _target*, _message*, _data*]]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores data about an error condition. 
	Typically is thrown using the <throw: https://community.bistudio.com/wiki/throw> command and
	possibly handled using <try: https://community.bistudio.com/wiki/try> / <catch: https://community.bistudio.com/wiki/catch>

Optionals: 
	_source - (optional - Default: nil) - Anything
	_target - (optional - Default: nil) - Anything
	_message - (optional - Default: nil) - <String> - custom message to override the default
	_data - (optional - Default: nil) - <Hashmap> - hashmap of data that provides more detail to cause of exception

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Exception"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
        --- prototype
        call ["#create", [_source*, _target*, _message*, _data*]]
        ---
    
    Optionals: 
        _source - (optional - Default: nil) - Anything
        _target - (optional - Default: nil) - Anything
        _message - (optional - Default: nil) - <String> - custom message to override the default
        _data - (optional - Default: nil) - <Hashmap> - hashmap of data that provides more detail to cause of exception

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_source","",[]],["_target","",[]],["_message",nil,[""]],["_data",createhashmap,[]]];
		_source = [str _source,_source] select (_source isEqualType "");
		_target = [str _target,_target] select (_target isEqualType "");

		_self set ["Source",_source];
		_self set ["Target",_target];
		if !(isNil "_message") then {_self set ["Message",_message]};
		if !(_data isEqualTypeAny [createhashmap,[]]) then {_data = createHashMapFromArray [["params (_this)",_data]]};
		_self set ["Data",_data];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		XPS_typ_Exception:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	----------------------------------------------------------------------------*/
	["#str", compileFinal {_self call ["GetText"]}],
	/*----------------------------------------------------------------------------
	Property: Data
    
    	--- Prototype --- 
    	get "Data"
    	---
		
		<XPS_ifc_IException>
    
    Returns: 
		<Hashmap> - provides more detail about the exception
	-----------------------------------------------------------------------------*/
	["Data",nil],
	/*----------------------------------------------------------------------------
	Property: Message
    
    	--- Prototype --- 
    	get "Message"
    	---
		
		<XPS_ifc_IException>
    
    Returns: 
		<String> - A message about the exception thrown
	-----------------------------------------------------------------------------*/
	["Message",""],
	/*----------------------------------------------------------------------------
	Property: Source
    
    	--- Prototype --- 
    	get "Source"
    	---
		
		<XPS_ifc_IException>
    
    Returns: 
		<Anything> - typcally the source <HashmapObject> that caused this error
	-----------------------------------------------------------------------------*/
	["Source",nil],
	/*----------------------------------------------------------------------------
	Property: Target
    
    	--- Prototype --- 
    	get "Target"
    	---
		
		<XPS_ifc_IException>
    
    Returns: 
		<Anything> - typcally the Method or Script Name that caused this error
	-----------------------------------------------------------------------------*/
	["Target",nil],
	/*-----------------------------------------------------------------------------
	Method: GetText
    
        --- prototype
        call ["GetText"]
        ---

	Returns:
		<Text> - A Structured Text formatted as follows:

		---text
		XPS_typ_Exception:
		         Source: (source)
				 Target: (target)
		         Message: (message)
		         Data: (data)
		---
	-----------------------------------------------------------------------------*/
	["GetText", compileFinal {text format[
			endl+"%1:"+endl+"    Source: %2"+endl+"    Target: %3"+endl+"    Message: %4"+endl+"    Data: %5",
			_self get "#type" select 0,
			_self get "Source",
			_self get "Target",
			_self get "Message",
			str (_self get "Data")
		]}]
]