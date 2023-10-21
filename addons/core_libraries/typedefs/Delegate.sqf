#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: main. XPS_typ_Delegate
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores a pointer to another function/method and calls it when invoked

Parent:
    none

Implements:
    <XPS_ifc_IDelegate>

Flags:
    unscheduled

---------------------------------------------------------------------------- */
[
	["#str",compilefinal {"XPS_typ_Delegate"}],
	["#type","XPS_typ_Delegate"],
	["@interfaces",["XPS_ifc_Delegate"]],
	["#flags",["unscheduled"]],
	["_pointer",{}],
	["_signature",[createhashmap,[]]], // default signature: [ sender object , argument array ]
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_Delegate,_signature]
        ---
    
    Parameters: 
        _signature (optional) - <Array> : a definition of parameters expected when calling "Invoke" method in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
    ----------------------------------------------------------------------------*/
	["#create",{
		if (typename _this == "ARRAY") then {
			_self set ["_signature",_this];
		};
	}],
    /*----------------------------------------------------------------------------
    Method: Attach
    
        --- Prototype --- 
        call ["Attach",_pointer]
        ---

        <XPS_ifc_IMultiCastDelegate>

		Attachs a pointer to another function/method
    
    Parameters: 
        _pointer - <Array> in format [HashMapObject,"MethodName"] or <Code>
		
	Returns:
		True - if attached
		False - if not [HashmapObject,"MthodName] or function <Code> block
    ----------------------------------------------------------------------------*/
	["Attach",{
		if (_this isEqualTypeParams [createhashmap,""] || _this isEqualType {}) then {
				_self set ["_pointer",_this];
				true;
		} else {
			false;
		};
	}],
    /*----------------------------------------------------------------------------
    Method: Invoke
    
        --- Prototype --- 
        call ["Invoke",_args]
        ---

        <XPS_ifc_IDelegate>
    
    Parameters: 
        _args - <Array> - the parameters to pass to the external function/method 
		must conform to the default signature or custom signature passed during creation
    ----------------------------------------------------------------------------*/
	["Invoke",{
		if !(_this isEqualTypeParams (_self get "_signature")) exitwith {false;};
		private _pointer = _self get "Pointer";

		switch (true) do {
			 case (_pointer isEqualTypeParams [createhashmap,""]) : {
				_pointer params ["_object","_method"];
				_object call [_method,_this];
				true;
			 };
			 case (_pointer isEqualType {}) : {
				_this call _pointer;
				true;
			 };
			 default {false};
		};
	}]
]