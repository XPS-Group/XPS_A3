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
        call ["#create",_type, _arg*]
        ---

    Parameters:
        _type - <Array> or <Hashmap> - that represents a <Type>
        _args - <Anything> - the arguments passed to the constructor

	Returns:
		<True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		if !(params [["_type",nil,[[],createhashmap]],["_args",[],[]]]) exitwith {
            throw createhashmaobject [XPS_typ_InvalidArgumentException,[_self,"#create","Argument passed was not an array or valid hashmap(object)",_this]]};

        _self set ["_object",createhashmapobject [_type, _args]];
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
    /*----------------------------------------------------------------------------
    Method: Build
    
        --- prototype
        call ["Build"]
        ---
    
	Parameters: 
		None
	
    Returns:
        <HashmapObject> - an instance of the type provided in the constructor
    ----------------------------------------------------------------------------*/
    ["Build", compileFinal {
        private _obj = _self get "_object";
        _self set ["_object",nil];
        _obj;
    }]
]