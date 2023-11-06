#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Exception
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores data about an error condition. 
	Typically is thrown using the <throw: https://community.bistudio.com/wiki/throw> command and
	possibly handled using <try: https://community.bistudio.com/wiki/try> / <catch: https://community.bistudio.com/wiki/catch>

Parent:
    none

Implements:
    <XPS_typ_Exception>

Flags:

---------------------------------------------------------------------------- */
[
	["#str", {format[
			"%1: Source: %2 Target: %3 Message: %4",
			_self get "#type" select 0,
			_self get "Source",
			_self get "Target",
			_self get "Message"
		]
	}],
	["#type","XPS_typ_Exception"],
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
	/*----------------------------------------------------------------------------
	Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_Exception, _source", _target*, _message*]
        ---
    
    Optionals: 
        _source (optional) - <Anything>
        _target (optional) - <Anything>
        _message (optional) - <String> - custom message to override the default

	-----------------------------------------------------------------------------*/
	["#create",{
		params [["_source","",[]],["_target","",[]],["_message","",[""]]];
		_source = [str _source,_source] select (_source isEqualType "");
		_target = [str _target,_target] select (_target isEqualType "");

		_self set ["Source",_source];
		_self set ["Target",_target];
		_self set ["Message",_message];
		 //TODO : If I ever get a debugger going
		// if !(isNil {XPS_MissionDebugger}) then {
		// 	XPS_MissionDebugger call ["AddToCallStack",[_self]];
		// };
	}]
]