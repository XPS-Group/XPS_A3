/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_HashmapObjectTypeRestrictor
	<TypeDefinition>
	---prototype
	XPS_typ_HashmapObjectTypeRestrictor : XPS_ifc_ITypeRestrictor
	---
	---prototype
	createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor, _allowedTypes]
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
	["#type","XPS_typ_HashmapObjectTypeRestrictor"],
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
	["#create",{
		params [["_allowedTypes",[],[[]]]];
		_self set ["_allowed",_allowedTypes];
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_HashmapObjectTypeRestrictor"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
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

    Does nothing for this class. Simply Satisfies Interface
    
    Parameters: 
        _value - <String> - a <HashmapObject> Type ("#type") to add to allowed list

	Returns:
		<True> - if successfully registered
		<False> - type already exists

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["RegisterType",{
        if !(params [["_type",nil,[""]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"RegisterType",nil,_this]];};
        private _list = _self get "_allowed";
        if (_type in _list) exitwith {false;};
        _list pushback _type;
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
	["IsAllowed",{
		params ["_value",createhashmap,[createhashmap]];
        private _allowlist = _self get "_allowed";
        private _types = _value getOrDefault ["#type",[]];
        (count (_types arrayIntersect _allowlist) > 0);
	}]
]