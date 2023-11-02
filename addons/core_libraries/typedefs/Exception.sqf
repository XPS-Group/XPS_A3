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
	["Handled",false],
	["Message",""],
	["Source",nil],
	["Target",nil],
	["#create",{
		params ["_source","_target","_message"];
		_source = [str _source,_source] select (_source isEqualType "");
		_target = [str _target,_target] select (_target isEqualType "");
		_message = [_message] param [0,"",[""]];

		_self set ["Source",_source];
		_self set ["Target",_target];
		_self set ["Message",_message];
		 
		if !(isNil {XPS_ExceptionHandler}) then {
			XPS_ExceptionHandler call ["AddToStackTrace",[_self]];
		};
	}],
	["#delete",{
	}]
]