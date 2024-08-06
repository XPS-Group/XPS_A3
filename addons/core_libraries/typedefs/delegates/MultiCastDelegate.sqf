#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_MultiCastDelegate
	<TypeDefinition>
        --- prototype
        XPS_typ_MultiCastDelegate : XPS_ifc_IMultiCastDelegate
        ---
        --- prototype
        createhashmapobject [XPS_typ_MultiCastDelegate,_signature]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores pointers to another function/method and calls them when invoked

Parameters: 
	_signature - (optional - Default: Anything) - a definition of parameters expected when calling "Invoke" method: in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
	
	This signature is strictly checked when Invoke is called and  will fail if parameters passed are not correct. This ensures a standard
	parameter set is expected by all receivers of the Invoke method. Since default is 'anything' all parameter compositions are initially allowed.

	However, a custom signature can be injected at creation or overridden by a derived class. See Example below.

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_MultiCastDelegate"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",_signature]
        ---
    
    Parameters: 
        _signature - (optional - Default: Anything) - a definition of parameters expected when calling "Invoke" method: in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
	
	Returns:
		<True>
    ----------------------------------------------------------------------------*/
	["#create",{
		if !(isnil "_this") then {
			_self set ["_signature",_this];
		} else {
			_self set ["_signature",[]];
		};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_MultiCastDelegate"
		---
	----------------------------------------------------------------------------*/
	["#str",compilefinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IMultiCastDelegate>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IMultiCastDelegate"]],
	["_pointers",[],[["CTOR"]]],
	["_signature",[]], 
    /*----------------------------------------------------------------------------
    Method: Add
    
        --- Prototype --- 
        call ["Add",_pointer]
        ---

        <XPS_ifc_IMultiCastDelegate>

		Adds a function/method pointer to the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Example Using Code:
		--- code 
        call ["Add",{ hint "Hello";}]
		---
		Example Using <HashmapObject> Method:
		--- code 
        call ["Add",[_hashmapobject, "MyMethodName"]]
		---
		
	Returns:
		<True> - if added

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
		<XPS_typ_InvalidArgumentException> - when parameter supplied was already added
    ----------------------------------------------------------------------------*/
	["Add", compileFinal {
		if (isNil "_this") then {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"Add","Parameter supplied was Nil"]]};
		
		if (_this isEqualType {} || {							//if just code we're good
				_this isEqualTypeParams [createhashmap,""] && 	//if hmobject with methodname...
				{(_this#1) in (_this#0) && 					//check methodname exists...
				{(_this#0) get (_this#1) isEqualType {}}}}			//if methodname is type code - we're good
			) then {
				//pushBackUnique doesn't support unique Hashmap Objects (compares by string)
				// if ((_self get "_pointers" pushbackUnique _this) > -1) then {true} else {
				// 	throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"Add","Functon/Method supplied was already added.",_this]];
				// };
				//Add a RPT log if it's getting overloaded 
				if ((_self get "_pointers" pushback _this) < 10000) then {true} else {
					diag_log text format ["MC Delegate %1 has too many subscribers. consider using an intermediary. Last added: %2",_self,_this];
				};
		} else {
			throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"Add","Argument supplied was not a code block or [hashmapobject,""methodName""] array.",_this]];
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
	["Remove", compileFinal {
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
	
	Returns:
		Nothing

	Throws: 
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to defined signature
		<XPS_typ_InvalidOperationException> - when an attached code or method pointer no longer exists
    ----------------------------------------------------------------------------*/
	["Invoke", compileFinal {
		if !(_this isEqualTypeParams (_self get "_signature")) exitwith {
			throw createhashmapobject[XPS_typ_InvalidArgumentException,[_self,"Invoke","Signature does not match supplied parameters.",_this]];
		};
		{
			switch (true) do {
				case (_x isEqualType {}) : {
					_this call _x;
				};
				case (_x isEqualTypeParams [createhashmap,""] && {!isNil {_x#0} && {_x#0 getorDefault[_x#1,[]] isEqualType {}}}) : {
					_x params ["_object","_method"];
					_object call [_method,_this];
				};
				default {
					throw createhashmapobject[XPS_typ_InvalidOperationException,[_self,"Invoke","Attached code or method pointer no longer exists",_this]];
				};
			};
		} foreach (_self get "_pointers");
	}]
]