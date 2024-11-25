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
	Str: #str
		--- prototype
		"XPS_typ_Builder"
		---
	----------------------------------------------------------------------------*/
    ["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		unscheduled
	----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Protected: typeDef
    
        --- prototype
        get "typeDef"
        ---
	
    Returns:
        <Hashmap> - the current working typedefinition
    ----------------------------------------------------------------------------*/
    ["typeDef",nil],
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
            if (_type isEqualType []) then {
                _self set ["typeDef",createhashmapfromarray _type];
            } else {
                _self set ["typeDef",+_type];
            }
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
        private _t = _self get "typeDef";
        _self set ["typeDef",nil];
        if (isNil "_t") then {nil} else {
            createhashmapobject [_t,_args];
        };
    }]
]