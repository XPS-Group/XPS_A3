#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: core. XPS_typ_ServiceProvider
	<TypeDefinition>
	---prototype
	XPS_typ_ServiceProvider : XPS_ifc_IServiceProvider
	---
	---prototype
	createhashmapobject [XPS_typ_ServiceProvider]
	---

Authors: 
	Craashdome

Description:
	Provides a repository of keyed (usually a <String> representation of an <Interface>) object type definitions
	for the purpose of resolving Dependancy Injection. Can handle scoped instances. If using a ServiceProvider 
	object directly, handling of scoped instances is done by cloning the object. Singletons inherit but Scoped 
	objects do not. 

	Alternatively to manual cloning. Consider using a <XPS_typ_ServiceContainer> object instead and calling it's 
	<XPS_typ_ServiceContainer.GetScope> method.

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_typ_ServiceProvider"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["#create"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",{
        _self set ["_services",createhashmap];
        _self set ["_instances",
            createhashmapfromarray [[str XPS_LifeTime_Scoped,createhashmap],[str XPS_LifeTime_Singleton,createhashmap]]
        ];
    }],
	/*----------------------------------------------------------------------------
	Clone: #clone
    
    	--- Prototype --- 
    	call ["#clone"]
    	---

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#clone",{
		// Remove deep copied scoped instances from new copy
        {
            _self get "_instances" get (str XPS_LifeTime_Scoped) deleteat _x;
        } foreach keys (_self get "_instances" get (str XPS_LifeTime_Scoped));
		
		// make singleton instances ref the parent : Note - new singletons in copy will also go to parent as a result
		_self get "_instances" set [str XPS_LifeTime_Singleton,_this get "_instances" get (str XPS_LifeTime_Singleton)];
    }],
	/*----------------------------------------------------------------------------
	Destructor: #delete
    
    	--- Prototype --- 
    	call ["#delete"]
    	---
    
	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#delete",{
        _self set ["_services",nil];
        _self set ["_instances",nil];
    }],
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		unscheduled
	----------------------------------------------------------------------------*/
	["#flags",["sealed","unscheduled"]],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_typ_ServiceProvider"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ifc_IServiceProvider>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IServiceProvider"]],
    ["_services",createhashmap],
    ["_instances",createhashmap],
	/*----------------------------------------------------------------------------
	Method: GetService
    
    	--- Prototype --- 
    	call ["GetService",[_key, _args*]]
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
    ["GetService",{
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"Add","Parameter supplied was Nil"]]};
		
        if !(params [["_key","",[""]],"_args"]) then {throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"GetService","Key was not a valid string.",_this]]; };
        
        if (_key in keys (_self get "_services")) then {
            private _item = _self get "_services" get _key;
            _item params ["_type","_lifeTime"];
            switch (_lifeTime) do {
                
                case XPS_LifeTime_Transient : {
                    createhashmapobject [_type, _args];
                };
                
                case XPS_LifeTime_Singleton;
                case XPS_LifeTime_Scoped : {
                    if (isNil {_self get "_instances" get (str _lifeTime) get _key}) then  {
                        _self get "_instances" get (str _lifeTime) set [_key, createhashmapobject [_type, _args]];
                    };
                    
                    _self get "_instances" get (str _lifeTime) get _key;
                };
            };
        } else {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"GetService","Key was not found.",_this]]; 
        };
    }],
	/*----------------------------------------------------------------------------
	Method: RegisterService
    
    	--- Prototype --- 
    	call ["RegisterService",[_key, _type, _lifeTime*]]
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
    ["RegisterService",{
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"Add","Parameter supplied was Nil"]]};
		
        if !(params [["_key","",[""]],["_type",createhashmap,["",createhashmap]],"_lifeTime"]) then {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"RegisterService","Parameters supplied were invalid.",_this]];
        };
        
        _lifeTime = _lifeTime param [0, XPS_LifeTime_Transient,[createhashmap]];
		private _enum = (_lifeTime getOrDefault ["#type",[""]])#0 ;
        if !((_lifeTime getOrDefault ["#type",[""]])#0 in ["XPS_LifeTime_Transient","XPS_LifeTime_Scoped","XPS_LifeTime_Singleton"]) then {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"RegisterService","LifeTime Parameter was invalid.",_this]];
        };

        if (_type isEqualtype "") then {_type = call compile _type;};
        
        if (_type isEqualTo createhashmap) then {
            throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"RegisterService","Type Parameter was invalid.",_this]];
        };

        _self get "_services" set [_key,[_type,_lifeTime]];
    }]
]