#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: action_planning. XPS_AP_typ_Sensor
	<TypeDefinition>
	---prototype
	XPS_AP_typ_Sensor : XPS_AP_ifc_Sensor
	---
	---prototype
	createhashmapobject [XPS_AP_typ_Sensor, [_var1*, _var2*]]
	---

Authors: 
	CrashDome

Description:
	(Description)

    
Optionals: 
	_var1* - <Object> - (Optional - Default : objNull) 
	_var2* - <String> - (Optional - Default : "") 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_AP_typ_Sensor"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
        params [["_bus",nil,[createhashmap]]];
        if !(isNil "_bus") then {
            if !(XPS_CHECK_IFC1(_bus,XPS_ifc_IEventBus)) exitwith {
                throw createhashmapobject [XPS_typ_InvalidArgumentException,[_self,"#create","Event bus Type Parameter was Invalid type",_this]];
            };

            _self set ["SensorUpdated",_bus];
        } else {
            _self set ["SensorUpdated",createhashmapobject [XPS_typ_EventBus]];
		};

        _self call ["Init"];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_AP_typ_Sensor"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_AP_ifc_ISensor>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_AP_ifc_ISensor"]],
	
	["formatEvent", {}],
	["Init", {}],
	["Register", compileFinal {
		//params ["_pointer","_key"];
		_self get "SensorUpdated" call ["Subscribe",_this];
	}],
    ["UpdateSensor", compileFinal {
        _self get "SensorUpdated" call ["Publish", [_self call ["formatEvent",_this]]];
    }],
    ["SensorUpdated",nil]
]

