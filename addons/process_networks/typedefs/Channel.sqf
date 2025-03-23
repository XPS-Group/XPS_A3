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
    ["_tokens",nil],
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
        _self get "_tokens" call ["Dequeue"];
    }],
    /*----------------------------------------------------------------------------
    Method: Write
    
        --- Prototype --- 
        call ["Write",_data]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		_data - <Anything> - the data to be stored   

	Returns:
		<Boolean> - if value was successfully set 
    ----------------------------------------------------------------------------*/
	["Write",compileFinal {
        _self get "_tokens" call ["Enqueue",_this];
    }],
    /*----------------------------------------------------------------------------
    Method: WriteUnique
    
        --- Prototype --- 
        call ["WriteUnique",_data]
        ---

        <XPS_ifc_IChannel>
    
    Parameters: 
		_data - <Anything> - the data to be stored   

	Returns:
		<Boolean> - if value was successfully added, False if already exists - item will always update data if already existing
    ----------------------------------------------------------------------------*/
	["WriteUnique",compileFinal {
        _self get "_tokens" call ["EnqueueUnique",_this]; 
    }]
]