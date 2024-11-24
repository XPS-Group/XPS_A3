#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Builder
	<TypeDefinition>
        --- prototype
        XPS_typ_Builder : XPS_ifc_IBuilder
        ---
        --- prototype
        createHashmapObject [XPS_typ_Builder]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores pointers to another function/method and calls them when invoked.

	The signature of the Invoke method is set as [sender: <HashmapObject> , args: <Array>]

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Builder"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",_type]
        ---

    Paramters:
        _type - <Array> or <Hashmap> - that represents a <Type>

	Returns:
		<True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_type",nil,[[],createhashmap]]];
        _self call ["New",_this];
	}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		unscheduled
	----------------------------------------------------------------------------*/
	["#flags",["unscheduled"]],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Builder"
		---
	----------------------------------------------------------------------------*/
    ["#str",{_self get "#type" select 0}],
    ["_object",nil],
    ["_type",nil],
    /*----------------------------------------------------------------------------
    Method: New
    
        --- prototype
        call ["New",_type]
        ---
    
	Paramters: 
        _type - <Array> or <Hashmap> - that represents a <Type>
	
    Returns:
        <HashmapObject> - this builder object
    ----------------------------------------------------------------------------*/
    ["New", compileFinal {
        params [["_type",nil,[[],createhashmap]]];
        if !(isNil "_type") then {
            private _t = [+_type,createhashmapfromarray _type] select {_type isEqualType []};
            _self set ["_type",_t];
        };
        _self;
    }],
    /*----------------------------------------------------------------------------
    Method: Build
    
        --- prototype
        call ["Build",_args]
        ---
    
	Paramters: 
		_args - <Anything> - arguments to be passed into the type definition constructor or []
	
    Returns:
        <HashmapObject> - an instance of the type provided in the <#create>/<New> methods or nil
    ----------------------------------------------------------------------------*/
    ["Build", compileFinal {
        params [["_args",[],[]]];
        private _t = _self get "_type";
        _self set ["_type",nil];
        if (isNil "_t") then {nil} else {
            createhashmapobject [_t,_args];
        };
    }]
]