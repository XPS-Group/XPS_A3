#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Delegate
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
	["#str",compilefinal {_self get "#type" select  0}],
	["#type","XPS_typ_Delegate"],
	["@interfaces",["XPS_ifc_IDelegate"]],
	//["#flags",["unscheduled"]],
	["_pointer",{}],
	["_signature",[createhashmap,[]]], // default signature: [ sender object , argument array ]
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        createhashmapobject [XPS_typ_Delegate,_signature]
        ---
    
    Parameters: 
        _signature (optional) - <Array> : a definition of parameters expected when calling "Invoke" method in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
		
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
		arguments sent to the <Invoke> method are expected to be different - e.g in a derived class. See Example below.
    ----------------------------------------------------------------------------*/
	["#create",{
		if (_this isEqualType []) then {
			_self set ["_signature",_this];
		} else {
			_self set ["_signature",[createhashmap,[]]];
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
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		As Code:
		--- code 
        call ["Attach",{ hint "Hello";}]
		---
		As <HashmapObject> Method:
		--- code 
        call ["Attach",[_self, "MyMethodName"]]
		---
		
	Returns:
		True - if attached
		False - if not [HashmapObject,"MthodName] or function <Code> block
    ----------------------------------------------------------------------------*/
	["Attach",{
		//Deep copy the array
		if (_this isEqualType []) then {_this = +_this};
		
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

		Calls the attached <code> block OR <hashmapobject> method with _args as the parameters.
    
    Parameters: 
        _args - <Array> - the parameters to pass to the external function/method 
		must conform to the default signature or custom signature passed during creation
    ----------------------------------------------------------------------------*/
	["Invoke",{
		if !(_this isEqualTypeParams (_self get "_signature")) exitwith {false;};
		private _pointer = _self get "_pointer";

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
/*---------------------------------------------------------------------------------------
Example: Override class to change signature

	Lets imagine that we not only want to pass the sender and arguments to subscribers but also, the method name 
	that was used to Invoke the call.
	
	--- code 
	private _newDelegate = [
		["#type", "Tag_typ_New_Delegate"],
		["#base", XPS_typ_Delegate"],
		["#create", {
			private _newSignature = [createhashmap, "", []]; // new signature : [sender, methodName, arguments]
			_self call ["XPS_typ_Delegate.#create", _newSignature];
		}],
	];

	Tag_typ_New_Delegate = [_newDelegate, false, true, true] call XPS_fnc_buildTypeDefintion;
	---
	
	Now we can use the new delegate type and call Invoke and pass the extra parameters without stuffing them into "arguments" parameter.
	--- code 
	Some Example Object Definition:
	[
		["#type", "Example"],
		["delegate", createhasmapobject ["Tag_typ_New_Delegate"]],
		["MyMethod", { 
			//do some stuff
			private _someArgs = ["I successfully did some stuff"];
			_self get "delegate" call ["Invoke", [_self, "MyMethod", _someArgs]]; 
		}]
	---
	So whenever the Example's MyMethod is called, it will send to the subscribers attached method (if any) 
	a set of parameters following the new signature
	---------------------------------------------------------------------------------------*/