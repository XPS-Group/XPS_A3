#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_ProcessSAsync
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_ProcessSAsync : XPS_PN_ifc_IProcess, XPS_PN_typ_Process
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_ProcessSAsync"]
    	---

Authors: 
	Crashdome

Description:
	Takes required tokens from Input Channels and invokes a process which may 
	or may not produce an output token. Output tokens can be optionally written 
	to Output Channels . This process runs asynchronously in a Scheduled environment

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_ProcessSAsync"],
	/*----------------------------------------------------------------------------
	Parent: #base

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	["#base", XPS_PN_typ_Process],
    /*----------------------------------------------------------------------------
    Constructor: #create

		<XPS_PN_typ_Process>
    ----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Flags: #flags
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_ProcessSAsync"
		---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IProcess>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: inputChannels

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: outputChannels

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: callback
    
    	--- Prototype --- 
    	call ["callback",_output]
    	---

	Description:
		The callback which handles the _output after <process> has finished

	Parameters:
		_output - <Anything> 

	Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["callback",compileFinal {
		_output = _this;
		{
			_x params ["_channel","_numTokens"]
			for "_n" from 1 to _numTokens do {
				_channel call ["Enqueue",_output];
			};
		} foreach (_self get "_outputChannels");
		_self set ["handle",nil];
	}],
	/*----------------------------------------------------------------------------
	Protected: handle
    
    	--- Prototype --- 
    	get "handle"
    	---
    
    Returns: 
		<Number> - the handle of the executing script called asynchronously.
		Nil if not executing.
	-----------------------------------------------------------------------------*/
	["handle",nil],
	/*----------------------------------------------------------------------------
	Protected: preProcess

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Protected: process

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Property: Name

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddInput

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: AddOutput

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: CanExecute

		<XPS_PN_typ_Process>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: Execute
    
    	--- Prototype --- 
    	call ["Execute"]
    	---  

	Description:
		Starts processing.
		
	Returns:
		<Boolean> - True if running, otherwise False
	-----------------------------------------------------------------------------*/
	["Execute" compileFinal {
		private _tokens = _self call ["preProcess"];
		if (_tokens isEqualtype []) then {
				_handle = [_self,_tokens] spawn {
					params ["_process","_tokens"];
					private _output = _process call ["process",_tokens]; 
					_process call ["callback",_output]
				};
				_self set ["handle",_handle];
			true;
		} else {false};
	}]
]