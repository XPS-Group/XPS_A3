/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_NoTypeRestrictor
	<TypeDefinition>
	---prototype
	XPS_typ_NoTypeRestrictor : XPS_ifc_ITypeRestrictor
	---
	---prototype
	createhashmapobject [XPS_typ_NoTypeRestrictor]
	---

Authors: 
	CrashDome

Description:
	Provides a 'No Restriction' Type checker

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_NoTypeRestrictor"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create"]
    	---

	Returns:
		True
	-----------------------------------------------------------------------------*/
	["#create",{}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_NoTypeRestrictor"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ifc_ITypeRestrictor>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_ITypeRestrictor"]],
	/*----------------------------------------------------------------------------
	Method: RegisterType
    
    	--- Prototype --- 
    	call ["RegisterType",_value]
        ---

        <XPS_ifc_ITypeRestrictor>

    Does nothing for this class. Simply Satisfies Interface
    
    Parameters: 
        _value - Anything - Value type to add to allowed list

	Returns:
		True - always
	-----------------------------------------------------------------------------*/
	["RegisterType",{true}],
	/*----------------------------------------------------------------------------
	Method: IsAllowed
    
        --- Prototype --- 
        call ["IsAllowed",_value]
        ---

        <XPS_ifc_ITypeRestrictor>
    
    Parameters: 
        _value - Anything - Value to check to see if it is allowed to be added

	Returns: 
		True - always
	-----------------------------------------------------------------------------*/
	["IsAllowed",{true}]
]