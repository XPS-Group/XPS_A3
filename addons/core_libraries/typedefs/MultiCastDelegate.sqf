#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_MultiCastDelegate
	<TypeDefinition>

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores pointers to other functions/methods and calls them when invoked

Parent:
    none

Implements:
    <XPS_ifc_IMultiCastDelegate>

Flags:
    unscheduled

---------------------------------------------------------------------------- */
[
	["#str",compilefinal {_self get "#type"}],
	["#type","XPS_typ_MultiCastDelegate"],
	["@interfaces",["XPS_ifc_IMultiCastDelegate"]],
	//["#flags",["unscheduled"]],
	["_pointers",[],[["CTOR"]]],
	["_signature",[createhashmap,[]],[["CTOR","[createhashmap,[]]"]]], 
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_MultiCastDelegate,_signature]
        ---
    
    Parameters: 
        _signature (optional) - <Array> - (Default: [createhashmap,[]]) - a definition of parameters expected when calling "Invoke" method in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]

		The default signature sent to the invoked method is as follows:
		--- code 
		[
			sender - usually the class calling Invoke - e.g. (_self) as (<HashmapObject>), 
			arguments - Array of stuff
		]
		---
		This signature is strictly checked when Invoke is called and will fail if not correct. This ensures a standard
		parameter set is expected by all receivers of the Invoke method.

		However, a custom signature can be injected at creation or in an overridden #create method when the
		arguments sent to the <Invoke> method are expected to be different - e.g in a derived class. See Example at <XPS_typ_Delegate>

    ----------------------------------------------------------------------------*/
	["#create",{
		if (_this isEqualType []) then {
			_self set ["_signature",_this];
		};
	}],
    /*----------------------------------------------------------------------------
    Method: Add
    
        --- Prototype --- 
        call ["Add",_pointer]
        ---

        <XPS_ifc_IMultiCastDelegate>

		Adds a function/method pointer to the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		As Code:
		--- code 
        call ["Add",{ hint "Hello";}]
		---
		As <HashmapObject> Method:
		--- code 
        call ["Add",[_self, "MyMethodName"]]

	Returns:
		True - if added
		False - if already added or not [HashmapObject,"MthodName] or function <Code> block
    ----------------------------------------------------------------------------*/
	["Add",{
		//Deep copy the array
		if (_this isEqualType []) then {_this = +_this};

		switch (true) do {
			 case (_this isEqualTypeParams [createhashmap,""] || _this isEqualType {}) : {
				(_self get "_pointers" pushbackUnique _this) > _1;
			 };
			 case (_this isEqualTypeParams [{}]) : {
				(_self get "_pointers" pushbackUnique (_this#0)) > -1;
			 };
			 default {false};
		};
	}],
    /*----------------------------------------------------------------------------
    Method: Remove
    
        --- Prototype --- 
        call ["Remove",_pointer]
        ---

        <XPS_ifc_IMultiCastDelegate>

		Removes a function/method pointer from the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Remove",{
		private _pointers = _self get "_pointers";
		_pointers deleteat (_pointers find _this);
	}],
    /*----------------------------------------------------------------------------
    Method: Invoke
    
        --- Prototype --- 
        call ["Invoke",_args]
        ---

        <XPS_ifc_IMultiCastDelegate>

		Calls the attached <code> blocks AND/OR <hashmapobject> methods with _args as the parameters.
    
    Parameters: 
        _args - <Array> - the parameters to pass to the external functions/methods must conform to the default signature or custom signature passed during creation
    ----------------------------------------------------------------------------*/
	["Invoke",{
		if !(_this isEqualTypeParams (_self get "signature")) exitwith {false;};
		{
			if (_x isEqualTypeParams [createhashmap,""]) then {
				_x params ["_object","_method"];
				_object call [_method,_this];
			} else {
				if (_x isEqualType {}) then {
					_this call _x;
				};
			};
		} foreach (_self get "_pointers");
	}]
]