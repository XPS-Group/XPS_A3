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
	["#create", compileFinal {
        params [["_id",nil,[""]]];

        if (isNil "_id") then {_id = call XPS_fnc_createUniqueID};

        _self set ["Id", _id];
        _self set ["_tokens",createhashmapobject [XPS_typ_Queue]];
	}],
	["#flags",["unscheduled"]],
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
	["_tokenData",createhashmap,["CTOR"]],
    ["_tokens",nil],
	["updateTokenData", compileFinal {
        params ["_ref",["_data",nil,[]]];
		_ref = [str _ref,_ref] select {_ref isEqualType ""};
        _self get "_tokenData" set [_ref,[_ref,_this] select {isNil "_data"}]; 
	}],
    ["Id", nil],
	["Count", compileFinal {_self get "_tokens" call ["Count"]}],
    ["IsEmpty",compileFinal {_self get "_tokens" call ["IsEmpty"]}],
    ["Read", compileFinal {
        private _ref = _self get "_tokens" call ["Dequeue"];
		_ref = [str _ref,_ref] select {_ref isEqualType ""};
        _self get _ref;
    }],
	["Write",compileFinal {
        params ["_ref",["_data",nil,[]]];
        _self get "_tokens" call ["Enqueue",_ref];
        _self call ["updateTokenData",_this]; 
    }],
	["WriteUnique",compileFinal {
        params ["_ref",["_data",nil,[]]];
        _self get "_tokens" call ["EnqueueUnique",_ref]; // adds if new - updates data always
        _self call ["updateTokenData",_this]; 
    }]
]