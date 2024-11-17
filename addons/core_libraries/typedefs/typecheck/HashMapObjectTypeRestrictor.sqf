/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_HashmapObjectTypeRestrictor
	<TypeDefinition>
	---prototype
	XPS_typ_HashmapObjectTypeRestrictor : XPS_ifc_ITypeRestrictor
	---
	---prototype
	createHashmapObject [XPS_typ_HashmapObjectTypeRestrictor, _allowedTypes]
	---

Authors: 
	CrashDome

Description:
	Provides a Hashmap Object Type checker

Parameters:
    _allowedTypes (optional) - <Array> - of Hashmap Object Types in string format (e.g. ["XPS_typ_Blackboard"] )

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_HashmapObjectTypeRestrictor"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create", _allowedTypes]
    	---

	Parameters:
		_allowedTypes (optional) - <Array> - of Hashmap Object Types in string format (e.g. ["XPS_typ_Blackboard"] )

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		if (isNil "_this" || {_this isEqualTo []}) exitWith {_self set ["_allowed",[]];};
		if (_this isEqualTypeAll "") then {
			_self set ["_allowed",_this];
		} else {
			//TODO throw
		};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_HashmapObjectTypeRestrictor"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ifc_ITypeRestrictor>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_ITypeRestrictor"]],
	["_allowed",[]],
	/*----------------------------------------------------------------------------
	Method: RegisterType
    
    	--- Prototype --- 
    	call ["RegisterType",_value]
        ---

        <XPS_ifc_ITypeRestrictor>
    
    Parameters: 
        _value - <String> - a <HashmapObject> Type ("#type") to add to allowed list

	Returns:
		<True> - if successfully registered
		<False> - type already exists

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["RegisterType", compileFinal {
        if !(params [["_type",nil,[""]]]) exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"RegisterType",nil,createHashMapFromArray [["_this",_this]]]];};
        private _list = _self get "_allowed";
        if (_type in _list) exitWith {false;};
        _list pushBack _type;
	}],
	/*----------------------------------------------------------------------------
	Method: IsAllowed
    
        --- Prototype --- 
        call ["IsAllowed",_value]
        ---

        <XPS_ifc_ITypeRestrictor>
    
    Parameters: 
        _value - <HashmapObject> - Value to check to see if it is allowed to be added

	Returns: 
		<True> - always
	-----------------------------------------------------------------------------*/
	["IsAllowed", compileFinal {
		params [["_value",createhashmap,[createhashmap]]];
        private _allowlist = _self get "_allowed";
        private _types = _value getOrDefault ["#type",[]];
        (count (_types arrayIntersect _allowlist) > 0);
	}]
]