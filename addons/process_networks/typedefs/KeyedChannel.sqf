#include "script_component.hpp" 
/* ----------------------------------------------------------------------------
TypeDef: process_network. XPS_PN_typ_KeyedChannel
	<TypeDefinition>
    	--- Prototype --- 
		XPS_PN_typ_KeyedChannel : XPS_PN_ifc_IChannel
    	---
    	--- Code --- 
    	createHashmapObject ["XPS_PN_typ_KeyedChannel"]
    	---

Authors: 
	Crashdome

Description:
	Represents a channel queue in a process network. Data is stored with a key so subsequent writes
	to the same key simply update the data rather than create a new item.

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_PN_typ_KeyedChannel"],
    /*----------------------------------------------------------------------------
    Parent: #base
    
		<XPS_PN_typ_Channel>
    ----------------------------------------------------------------------------*/
	["#base",XPS_PN_typ_Channel],
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

        _self call ["XPS_PN_typChannel.#create",_name];
        _self set ["_tokenData",createhashmap];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_PN_typ_KeyedChannel"
		---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements:
		<XPS_PN_ifc_IChannel>
	-----------------------------------------------------------------------------*/
	["_tokenData",nil],
	/*----------------------------------------------------------------------------
	Protected: updateTokenData
    
    	--- Prototype --- 
    	call ["updateTokenData",[_data, _ref*]]
    	---
    
    Parameters: 
		_data - <Anything> - the data to be stored within the key

	Optionals:
		_ref - <String> - (Optional : Default - a unique ID string) - the key to be added or updated    

	Returns:
		<Boolean> - if value was successfully set 
	-----------------------------------------------------------------------------*/
	["updateTokenData", compileFinal {
        params [["_data",nil,[]],["_ref",call XPS_fnc_createUniqueID,[""]]];
        _self get "_tokenData" set [_ref,_data]; 
	}],
	/*----------------------------------------------------------------------------
	Property: Name
    
		<XPS_PN_typ_Channel.Name>
	-----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Count
    
		<XPS_PN_typ_Channel.Count>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: IsEmpty
    
		<XPS_PN_typ_Channel.Count>
    ----------------------------------------------------------------------------*/	
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
        _self get "_tokenData" deleteat _ref;
    }],
    /*----------------------------------------------------------------------------
    Method: Write
    
        --- Prototype --- 
        call ["Write",[_data, _ref*]]
    	---
    
    Parameters: 
		_data - <Anything> - the data to be stored within the key

	Optionals:
		_ref - <String> - (Optional : Default - a unique ID string) - the key to be added or updated  

	Returns:
		<Boolean> - if value was successfully added/updated 
    ----------------------------------------------------------------------------*/
	["Write",compileFinal {
        params [["_data",nil,[]],["_ref",call XPS_fnc_createUniqueID,[""]]];
        _self call ["XPS_PN_typ_Channel.Enqueue",_ref];
        _self call ["updateTokenData",_this]; 
    }],
    /*----------------------------------------------------------------------------
    Method: WriteUnique
    
        --- Prototype --- 
        call ["WriteUnique",[_data, _ref*]]
    	---
    
    Parameters: 
		_data - <Anything> - the data to be stored within the key

	Optionals:
		_ref - <String> - (Optional : Default - a unique ID string) - the key to be added or updated     

	Returns:
		<Boolean> - if value was successfully added/updated, False if already exists - item will always update data if already existing
    ----------------------------------------------------------------------------*/
	["WriteUnique",compileFinal {
        params [["_data",nil,[]],["_ref",call XPS_fnc_createUniqueID,[""]]];
        private _result = _self call ["XPS_PN_typ_Channel.EnqueueUnique",_ref]; // adds if new - updates data always
        _self call ["updateTokenData",_this]; 
    }]
]
