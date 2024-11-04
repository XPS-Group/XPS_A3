#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_ServiceContainer
	<TypeDefinition>
	---prototype
	XPS_typ_ServiceContainer : XPS_ifc_IServiceContainer
	---
	---prototype
	createHashmapObject [XPS_typ_ServiceContainer]
	---

Authors: 
	Craashdome

Description:
	Provides a wrapper around any <XPS_ifc_IServiceProvider> object to automatically handle creation of scoped instances

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_ServiceContainer"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create",_provider*]
    	---
	
	Paramters:
		_provider* - <HashmapObject> - (Optional - Default : new XPS_typ_ServiceProvider) - an object which implements <XPS_ifc_IServiceProvider>

	Returns:
		<True>

    Throws:
        <XPS_typ_InvalidArgumentException> - if parameter does not implement the <XPS_ifc_ITypeRestrictor> interface
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_provider",createHashmapObject [XPS_typ_ServiceProvider],[createhashmap]]];		
		if !(CHECK_IFC1(_provider,XPS_ifc_IServiceProvider)) exitWith {
            throw createHashmapObject [XPS_typ_InvalidArgumentException,[_self,"#create","_provider parameter was an invalid type",_this]];
		};
		
		_self set ["_provider",_provider];
    }],
	/*----------------------------------------------------------------------------
	Clone: #clone
    
    	--- Prototype --- 
    	call ["#clone"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#clone", compileFinal {
		_self  set ["_provider",+(_this get "_provider")];
    }],
	/*----------------------------------------------------------------------------
	Destructor: #delete
    
    	--- Prototype --- 
    	call ["#delete"]
    	---
    
	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#delete", {}],
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		unscheduled
	----------------------------------------------------------------------------*/
	["#flags",["sealed","unscheduled"]],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_ServiceContainer"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ifc_IServiceContainer>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IServiceContainer"]],
    ["_provider",createhashmap],
	/*----------------------------------------------------------------------------
	Method: Resolve
    
    	--- Prototype --- 
    	call ["Resolve",[_key, _args*]]
    	---
    
    Optionals: 
		_key - <String> - the key of the type. Typically name of an interface 
        _args* - <Array>, <Anything> - (Optional) an argument or array of arguments to pass to #create method
 		
	Returns:
		<Hashmapobject> - an instance of the registered type to the key

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied is not a string
		<XPS_typ_InvalidArgumentException> - when parameter supplied was not found
	-----------------------------------------------------------------------------*/
    ["Resolve", compileFinal {
		_self get "_provider" call ["GetService",_this];
    }],
	/*----------------------------------------------------------------------------
	Method: Add
    
    	--- Prototype --- 
    	call ["Add",[_key, _type, _lifeTime*]]
    	---
    
    Optionals: 
        _key - <String> - the desired key to register to - typically an interface or type 
		_type - <String> or <Hashmap> - a string representation of the type's global variable or a hashmap type definition
        _lifeTime* - <XPS_enum_LifeTime> - (Optional - Default : Transient) the desired scope of any instances

	Returns:
		<Boolean> - <True> if added successfully, otherwise <False>

	Throws: 
		<XPS_typ_ArgumentNilException> - when a parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when lifeTime parameter supplied is not a valid enum
		<XPS_typ_InvalidArgumentException> - when type parameter supplied is not a string
	-----------------------------------------------------------------------------*/
    ["Add", compileFinal {
		_self get "_provider" call ["RegisterService",_this];
    }],
	/*----------------------------------------------------------------------------
	Method: GetScope
    
    	--- Prototype --- 
    	call ["GetScope"]
    	---
	Returns:
		<XPS_typ_ServiceContainer> - A copy of this object which inherits the singleton instances by ref and a blank scope instance map

	-----------------------------------------------------------------------------*/
    ["GetScope", compileFinal {
		//createHashmapObject [_self get "#type" select 0,+(_self get "_provider")];
		+_self;
    }]
]