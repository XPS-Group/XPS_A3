#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_CachedHashmap
	<TypeDefinition>
        --- prototype
        XPS_typ_CachedHashmap : XPS_ifc_IList
        ---
        --- prototype
        createHashmapObject [XPS_typ_CachedHashmap]
        ---

Authors: 
	Crashdome
   
Description:
	A collection where items are cached until a request forces an update. 

Returns:
	<HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_CachedHashmap"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---
    
    Return:
        <True>
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self set ["_itemMap",createhashmap];
        true;
    }],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_CachedHashmap"
		---
	----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
	----------------------------------------------------------------------------*/
	["#flags",["sealed"]],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IList>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_IList"]],
	["_itemMap",nil],
    /*----------------------------------------------------------------------------
    Protected: getNewItem
    
        --- Prototype --- 
        call ["getNewItem",[_key]]
        ---

        <XPS_ifc_IList>

        Retrieves an item from original source. 
        
        Must be Overridden. 
    
    Parameters: 
		_key - <Anything> - the key which identifies what to retrieve from source
		
	Returns:
		<Anything> - the item to be cached
    ----------------------------------------------------------------------------*/
	["getNewItem", compileFinal {
		true;
	}],
    /*----------------------------------------------------------------------------
    Method: Clear
    
        --- Prototype --- 
        call ["Clear"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		Nothing
    ----------------------------------------------------------------------------*/
	["Clear", compileFinal {
		_self set ["_itemMap",createhashmap];
	}],
    /*----------------------------------------------------------------------------
    Method: Count
    
        --- Prototype --- 
        call ["Count"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Number> - the number of elements in the stack
    ----------------------------------------------------------------------------*/
	["Count", compileFinal {
		count keys (_self get "_itemMap");
	}],
    /*----------------------------------------------------------------------------
    Method: IsEmpty
    
        --- Prototype --- 
        call ["IsEmpty"]
        ---

        <XPS_ifc_IList>
    
    Parameters: 
		none
		
	Returns:
		<Boolean> - <True> if queue is empty, otherwise <False>.
    ----------------------------------------------------------------------------*/
	["IsEmpty", compileFinal {
		count (_self get "_itemMap") isEqualTo 0;
	}],
    /*----------------------------------------------------------------------------
    Method: GetItem
    
        --- Prototype --- 
        call ["GetItem",[_key, _forceNew*]]
        ---
    
    Parameters: 
		_key - <Anything> - the key which identifies what to retrieve from cache or source if not cached
		_forceNew* - <Boolean> - (Optional - Default : False) - passing true forces cache update on item.

	Returns:
		<Anything> - removes and returns first element in the queue or nil if empty
    ----------------------------------------------------------------------------*/
	["GetItem", compileFinal {
        params ["_key",["_forceNew",false,[true]]];
        if (!_forceNew && {_key in keys (_self get "_itemMap")}) then {
            _self get "_itemMap" get _key;
        } else {
		    private _newItem = _self call ["getItemNew",[_key]];
            if !(isNil "_newItem") then {
                _self get "_itemMap" set [_key, _newItem]
            } else {
                _self get "_itemMap" deleteat _key
            };
            _newItem;
        };
	}]
]
