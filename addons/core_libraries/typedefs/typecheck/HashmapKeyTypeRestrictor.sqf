/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_HashmapKeyTypeRestrictor
	<TypeDefinition>
	---prototype
	XPS_typ_HashmapKeyTypeRestrictor : XPS_typ_NativeTypeRestrictor, XPS_ifc_ITypeRestrictor
	---
	---prototype
	createHashmapObject [XPS_typ_HashmapKeyTypeRestrictor]
	---

Authors: 
	CrashDome

Description:
	Provides a Native Type checker limited to <Hashmap Supported Key Types : https://community.bistudio.com/wiki/HashMap>
	
	- <Array>
	- <Boolean>
	- <Code>
	- <Config>
	- <Namespace>
	- <Number>
	- <Side>
	- <String>

Parameters: 
	none

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_HashmapKeyTypeRestrictor"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_NativeTypeRestrictor>
	-----------------------------------------------------------------------------*/
	["#base",XPS_typ_NativeTypeRestrictor],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self call ["XPS_typ_NativeTypeRestrictor.#create",[[],true,{},configFile,localNamespace,0,sideEmpty,""]];
	}]
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_HashmapKeyTypeRestrictor"
    	---
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ifc_ITypeRestrictor>
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: RegisterType

        <XPS_ifc_ITypeRestrictor>
		<XPS_typ_NativeTypeRestrictor.RegisterType>

	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: IsAllowed

        <XPS_ifc_ITypeRestrictor>
		<XPS_typ_NativeTypeRestrictor.IsAllowed>

	-----------------------------------------------------------------------------*/
]