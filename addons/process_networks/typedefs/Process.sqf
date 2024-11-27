#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_Process
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_Process : XPS_PN_ifc_IProcess
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_Process"]
    	---

Authors: 
	Crashdome

Description:
	Takes required tokens from Input Channels and invokes a process which may 
	or may not produce an output token. Output tokens can be optionally written 
	to Output Channels  

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_Process"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",_name]
        ---
	
	Paramters:
		_name - <String> - a unique name for this object
    
    Return:
        <True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
        params [["_name",nil,[""]]];

        if (isNil "_name") then {_name = call XPS_fnc_createUniqueID};

        _self set ["Name", _name];
		_self set ["inputChannels",[]];
		_self set ["outputChannels",[]];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_Process"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IProcess>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_PN_ifc_IProcess"]],
	/*----------------------------------------------------------------------------
	Protected: inputChannels
    
    	--- Prototype --- 
    	get "inputChannels"
    	---  

	Returns:
		<Array> - an array of <XPS_PN_typ_Chennel> references 
	-----------------------------------------------------------------------------*/
	["inputChannels",[]],
	/*----------------------------------------------------------------------------
	Protected: outputChannels
    
    	--- Prototype --- 
    	get "outputChannels"
    	---  

	Returns:
		<Array> - an array of <XPS_PN_typ_Chennel> references 
	-----------------------------------------------------------------------------*/
	["outputChannels",[]],
	/*----------------------------------------------------------------------------
	Protected: preProcess
    
    	--- Prototype --- 
    	call ["preProcess"]
    	---  

	Description:
		Checks <inputChannels> and retrrieves one or more tokens from each channel. If 
		a channel is empty or does not contain enough tokens, it will fail.

	Returns:
		<Array> or <Boolean> - an array of tokens or <False> if failed
	-----------------------------------------------------------------------------*/
	["preProcess", compileFinal {
		scopeName "tokens"
		private _tokens = []; 
		{
			_x params ["_input","_numTokens"];
			for "_n" from 1 to _numTokens do {
				private _token = _input call ["Dequeue"];
				if !(isNil "_token") then {_tokens = false; breakTo "tokens"};
				_tokens pushback _token;
			}
		} foreach (_self get "inputChannels");
		_tokens;
	}],
	/*----------------------------------------------------------------------------
	Protected: process
    
    	--- Prototype --- 
    	call ["process", _tokens]
    	---  

	Description:
		Processes each token from the <preProcess> method. Result should be a new token
		that will be sent to each output channel in <outputChannels>
		
		This contains no functionality and must be overridden

	Parameters: 
		_tokens - <Array> - an array of tokens to be processed

	Returns:
		<Anything> - a token 
	-----------------------------------------------------------------------------*/
	["process", {}],
	/*----------------------------------------------------------------------------
	Property: Name
    
    	--- Prototype --- 
    	get "Name"
    	---  

	Returns:
		<String> - identifier of this process object 
	-----------------------------------------------------------------------------*/
    ["Name", nil],
	/*----------------------------------------------------------------------------
	Method: AddInput
    
    	--- Prototype --- 
    	call ["AddInput", [_channel, _numTokens]]
    	---  

	Description:
		Adds a channel to <inputChannels>

	Parameters: 
		_channel - <XPS_PN_typ_Channel>
		_numTokens - <Number> - the number of tokens the channel must have in order
		for this process to execute.
		
	Returns:
		<HashmapObject> - this process object 
	-----------------------------------------------------------------------------*/
	["AddInput", compileFinal {
		params [["_channel",nil,[createhashmap]],["_numTokens",1,[0]]];
		if (isNil "_channel") exitWith {false};
		if !( XPS_CHECK_IFC1(_input,XPS_PN_ifc_IChannel) ) exitWith {false};

		_self get "inputChannels" pushback [_channel,_numTokens];
		_self;
	}],
	/*----------------------------------------------------------------------------
	Method: AddOutput
    
    	--- Prototype --- 
    	call ["AddOutput", [_channel, _numTokens]]
    	---  

	Description:
		Adds a channel to <inputChannels>

	Parameters: 
		_channel - <XPS_PN_typ_Channel>
		_numTokens - <Number> - the number of tokens the channel will receive when
		this process is executed
		
	Returns:
		<HashmapObject> - this process object 
	-----------------------------------------------------------------------------*/
	["AddOutput", compileFinal {
		params [["_channel",nil,[createhashmap]],["_numTokens",1,[0]]];
		if (isNil "_channel") exitWith {false};
		if !( XPS_CHECK_IFC1(_output,XPS_PN_ifc_IChannel) ) exitWith {false};

		_self get "outputChannels" pushback [_channel,_numTokens];
		_self;
	}],
	/*----------------------------------------------------------------------------
	Method: CanExecute
    
    	--- Prototype --- 
    	call ["CanExecute"]
    	---  

	Description:
		Checks if the <inputChannels> each have enough tokens for <Execute> not to fail.
		
	Returns:
		<Boolean> 
	-----------------------------------------------------------------------------*/
	["CanExecute", compileFinal {
		(_self get "inputChannels") select {(_x#0) call ["Count"] < (_x#1)} isEqualTo 0;
	}],
	/*----------------------------------------------------------------------------
	Method: Execute
    
    	--- Prototype --- 
    	call ["Execute"]
    	---  

	Description:
		Starts processing.
		
	Returns:
		<Boolean> - True is succeeded, otherwise False
	-----------------------------------------------------------------------------*/
	["Execute" compileFinal {
		private _tokens = _self call ["preProcess"];
		if (_tokens isEqualtype []) then {
			private _output = _self call ["process",_tokens];
			{
				_x params ["_channel","_numTokens"]
				for "_n" from 1 to _numTokens do {
					_channel call ["Enqueue",_output];
				};
			} foreach (_self get "_outputChannels");
			true;
		} else {false};
	}]
]