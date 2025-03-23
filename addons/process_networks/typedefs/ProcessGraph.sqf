#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_ProcessGraph
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_ProcessGraph : XPS_PN_ifc_IProcessGraph
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_ProcessGraph"]
    	---

Authors: 
	Crashdome

Description:

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_ProcessGraph"],
	["#create", compileFinal {
		_self set ["channels",createhashmap];
		_self set ["processes",[]];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_ProcessGraph"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IProcessGraph>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_PN_ifc_IProcessGraph"]],
	/*----------------------------------------------------------------------------
	Protected: currentprocess
    
    	--- Prototype --- 
    	get "currentprocess"
    	---  

	Returns:
		<HashmapObject> - current running or previously ran process 
	-----------------------------------------------------------------------------*/
	["currentprocess",nil],
	/*----------------------------------------------------------------------------
	Protected: channels
    
    	--- Prototype --- 
    	get "channels"
    	---  

	Returns:
		<Hashmap> - all registered channels 
	-----------------------------------------------------------------------------*/
	["channels",nil],
	/*----------------------------------------------------------------------------
	Protected: processes
    
    	--- Prototype --- 
    	get "processes"
    	---  

	Returns:
		<Array> - all registered processes 
	-----------------------------------------------------------------------------*/
	["processes",nil],
	/*----------------------------------------------------------------------------
	Method: AddChannel
    
    	--- Prototype --- 
    	call ["AddChannel", [_channel, _key]]
    	---  

	Description:
		Adds a channel 

	Parameters: 
		_channel - <XPS_PN_ifc_IChannel>
		_key - <String>
		
	Returns:
		<HashmapObject> - this object 
	-----------------------------------------------------------------------------*/
	["AddChannel", compileFinal {
		params [["_channel",createhashmap,[createhashmap]],["_key","",[""]]];
		
		if (_key isEqualTo "" || !{XPS_CHECK_IFC1(_channel,XPS_PN_ifc_IChannel)}) exitWith {false};

		_self get "channels" set [_key,_channel];
		_self;
	}],
	/*----------------------------------------------------------------------------
	Method: AddProcess
    
    	--- Prototype --- 
    	call ["AddProcess", _process]
    	---  

	Description:
		Adds a process 

	Parameters: 
		_process - <XPS_PN_ifc_IProcess>
		_key - <String>
		
	Returns:
		<HashmapObject> - this object 
	-----------------------------------------------------------------------------*/
	["AddProcess", compileFinal {
		params [["_process",createhashmap,[createhashmap]]];
		
		if (_key isEqualTo "" || !{XPS_CHECK_IFC1(_process,XPS_PN_ifc_IProcess)}) exitWith {false};

		_self get "processes" pushback _process;
		_self;
	}],
	/*----------------------------------------------------------------------------
	Method: ExecuteNext
    
    	--- Prototype --- 
    	call ["ExecuteNext"]
    	---  

	Description:
		Executes the next <XPS_ifc_IProcess> in the <processes> <array>.
		
	Returns:
		Nothing
	-----------------------------------------------------------------------------*/
	["ExecuteNext", compileFinal {
		
		if (_self get "currentProcess" get "Status" isEqualTo XPS_Status_Running) exitwith {false};

		private _next = _self get "processes" deleteat 0;
		_self set ["currentProcess",_next];
		if (_next call ["CanExecute"]) then {
			_next call ["Execute"];
		};
		_self get "processes" pushback _next;
		nil;
	}]
]