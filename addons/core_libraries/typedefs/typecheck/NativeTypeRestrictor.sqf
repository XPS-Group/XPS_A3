/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_NativeTypeRestrictor
	<TypeDefinition>
	---prototype
	XPS_typ_NativeTypeRestrictor : XPS_ifc_ITypeRestrictor
	---
	---prototype
	createHashmapObject [XPS_typ_NativeTypeRestrictor, _allowedTypes]
	---

Authors: 
	CrashDome

Description:
	Provides a Native Type checker

Parameters:
    _allowedTypes (optional) - <Array> - of Native Types in same format as IsEqualTypeParams (e.g. [objNull,0,[],""] )

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_NativeTypeRestrictor"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create", _allowedTypes]
    	---

	Parameters:
		_allowedTypes (optional) - <Array> - of Native Types in same format as IsEqualTypeParams (e.g. [objNull,0,[],""] )

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		if (isNil "_this") then {_self set ["_allowed",[]];};
		if (_this isEqualType []) then {
			_self set ["_allowed",_this];
		} else {
			//TODO throw
		};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_NativeTypeRestrictor"
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
        _value - <Anything> - a Native Type to add to allowed list

	Returns:
		<True> - if successfully registered
		<False> - type already exists

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["RegisterType", compileFinal {
        if !(params [["_type",nil,[]]]) exitWith {throw createHashmapObject [XPS_typ_ArgumentNilException,[_self,"RegisterType",nil,createHashMapFromArray [["_this",_this]]]];};
        private _list = _self get "_allowed";
        if (_type isEqualTypeAny _list) exitWith {false;};
        _list pushBack _type;
	}],
	/*----------------------------------------------------------------------------
	Method: IsAllowed
    
        --- Prototype --- 
        call ["IsAllowed",_value]
        ---

        <XPS_ifc_ITypeRestrictor>
    
    Parameters: 
        _value - <Anything> - Value to check to see if it is allowed to be added

	Returns: 
		<True> - always
	-----------------------------------------------------------------------------*/
	["IsAllowed", compileFinal {
		params ["_value"];
        private _allowlist = _self get "_allowed";
		_value isEqualTypeAny _allowList;
	}]
]
