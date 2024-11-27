#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_Channel
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_Channel : XPS_PN_ifc_IChannel
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_Channel"]
    	---

Authors: 
	Crashdome

Description:
	Represents a channel queue in a process network.

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_Channel"],
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
        _self set ["_tokens",createhashmapobject [XPS_typ_Queue]];
        _self set ["_tokenData",createhashmap];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_Channel"
		---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IChannel>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_PN_ifc_IChannel"]],
	["_tokenData",nil],
    ["_tokens",nil],
	/*----------------------------------------------------------------------------
	Protected: updateTokenData
    
    	--- Prototype --- 
    	call ["updateTokenData",[_ref, _data]]
    	---
    
    Parameters: 
		_ref - <HashmapKey> - the key to be added or updated 
		_data - <Anything> - the data to be stored within the key, along with the key. Final stored value will be [_ref, _data]    

	Returns:
		<Boolean> - if value was successfully set 
	-----------------------------------------------------------------------------*/
	["updateTokenData", compileFinal {
        params ["_ref",["_data",nil,[]]];
		_ref = [str _ref,_ref] select {_ref isEqualType ""};
        _self get "_tokenData" set [_ref,[_ref,_this] select {isNil "_data"}]; 
	}],
	/*----------------------------------------------------------------------------
	Property: Name
    
    	--- Prototype --- 
    	get "Name"
    	---  

	Returns:
		<String> - identifier of this channel object 
	-----------------------------------------------------------------------------*/
    ["Name", nil],
    /*----------------------------------------------------------------------------
    Method: Count
    
        --- Prototype --- 
        call ["Count"]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		none
		
	Returns:
		<Number> - the number of elements in the queue
    ----------------------------------------------------------------------------*/
	["Count", compileFinal {_self get "_tokens" call ["Count"]}],
    /*----------------------------------------------------------------------------
    Method: IsEmpty
    
        --- Prototype --- 
        call ["IsEmpty"]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		none
		
	Returns:
		<Boolean> - <True> if queue is empty, otherwise <False>.
    ----------------------------------------------------------------------------*/
    ["IsEmpty",compileFinal {_self get "_tokens" call ["IsEmpty"]}],
	
    /*----------------------------------------------------------------------------
    Method: Read
    
        --- Prototype --- 
        call ["Read"]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		none
		
	Returns:
		<Anything> - removes and returns first element in the queue or nil if empty
    ----------------------------------------------------------------------------*/
    ["Read", compileFinal {
        private _ref = _self get "_tokens" call ["Dequeue"];
		_ref = [str _ref,_ref] select {_ref isEqualType ""};
        _self get _ref;
    }],
    /*----------------------------------------------------------------------------
    Method: Write
    
        --- Prototype --- 
        call ["Write",[_ref, _data]]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		_ref - <HashmapKey> - the key to be added or updated 
		_data - <Anything> - the data to be stored within the key, along with the key. Final stored value will be [_ref, _data]    

	Returns:
		<Boolean> - if value was successfully set 
    ----------------------------------------------------------------------------*/
	["Write",compileFinal {
        params ["_ref",["_data",nil,[]]];
        _self get "_tokens" call ["Enqueue",_ref];
        _self call ["updateTokenData",_this]; 
    }],
    /*----------------------------------------------------------------------------
    Method: WriteUnique
    
        --- Prototype --- 
        call ["WriteUnique",[_ref, _data]]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		_ref - <HashmapKey> - the key to be added or updated 
		_data - <Anything> - the data to be stored within the key, along with the key. Final stored value will be [_ref, _data]    

	Returns:
		<Boolean> - if value was successfully added, False if already exists - item will always update data if already existing
    ----------------------------------------------------------------------------*/
	["WriteUnique",compileFinal {
        params ["_ref",["_data",nil,[]]];
        private _result = _self get "_tokens" call ["EnqueueUnique",_ref]; // adds if new - updates data always
        _self call ["updateTokenData",_this]; 
		_result;
    }]
]