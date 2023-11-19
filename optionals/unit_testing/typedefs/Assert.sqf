#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_Assert
	<TypeDefinition>
		---prototype
		XPS_UT_typ_Assert
		---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> with methods to perform equality and type checks

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_Assert"],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_UT_typ_Assert"
		---
	----------------------------------------------------------------------------*/
	["#str", {_self get "#type" select 0}],
	/*-----------------------------------------------------------------------------
	Method: AreEqual 
    
    	--- Prototype --- 
    	call ["AreEqual",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTo check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal

    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["AreEqual",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if !(_arg1 isEqualTo _arg2) then {
			_self call ["Fail",["AreEqual",_this#2,createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: AreNotEqual 
    
    	--- Prototype --- 
    	call ["AreNotEqual",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTo check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["AreNotEqual",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if (_arg1 isEqualTo _arg2) then {
			_self call ["Fail",["AreNotEqual",_this#2,createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: AreSame 
    
    	--- Prototype --- 
    	call ["AreSame",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualRef check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["AreSame",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if !(_arg1 isEqualRef _arg2) then {
			_self call ["Fail",["AreSame",_this#2,createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: AreNotSame 
    
    	--- Prototype --- 
    	call ["AreNotSame",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualRef check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["AreNotSame",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if (_arg1 isEqualRef _arg2) then {
			_self call ["Fail",["AreNotSame",_this#2,createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: Fail 
    
    	--- Prototype --- 
    	call ["Fail",[_target*, _message*, _data*]]
    	---
	
	Always Fails with <XPS_UT_typ_AssertFailedException>

	Optionals:
		_target* - <String> - (Optional - Default : "Fail") - Usually the Method Name 
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception
		_data* - <Hashmap> or <HashmapObject>  - (Optional - Default : Empty Hashmap) - Usually the parameters supplied
	-----------------------------------------------------------------------------*/
	["Fail",{
		params [["_target","Fail",[""]],["_message",nil,[""]],["_data",createhashmap,[createhashmap]]];
		private _e =  compileFinal createhashmapobject [XPS_UT_typ_AssertFailedException,[_self get "#type" select 0,_target,_this#1,_data]];
		throw _e;
	}],
	/*-----------------------------------------------------------------------------
	Method: Inconclusive 
    
    	--- Prototype --- 
    	call ["Inconclusive",[_target*, _message*, _data*]]
    	---
	
	Always Fails but with an <XPS_UT_typ_AssertInconclusiveException> 

	Optionals:
		_target* - <String> - (Optional - Default : "Inconclusive") - Usually the Method Name 
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception
		_data* - <Hashmap> or <HashmapObject>  - (Optional - Default : Empty Hashmap) - Usually the parameters supplied
	-----------------------------------------------------------------------------*/
	["Inconclusive",{
		params [["_target","Inconclusive",[""]],["_message",nil,[""]],["_data",createhashmap,[createhashmap]]];
		private _e =  compileFinal createhashmapobject [XPS_UT_typ_AssertInconclusiveException,[_self get "#type" select 0,_target,_this#1]];
		throw _e;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsEqualType 
    
    	--- Prototype --- 
    	call ["IsEqualType",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualType check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsEqualType",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if !(_arg1 isEqualType _arg2) then {
			_self call ["Fail",["IsEqualType",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotEqualType 
    
    	--- Prototype --- 
    	call ["IsNotEqualType",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualType check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotEqualType",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if (_arg1 isEqualType _arg2) then {
			_self call ["Fail",["IsNotEqualType",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsEqualTypeAll 
    
    	--- Prototype --- 
    	call ["IsEqualTypeAll",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeAll check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsEqualTypeAll",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if !(_arg1 isEqualTypeAll _arg2) then {
			_self call ["Fail",["IsEqualTypeAll",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotEqualTypeAll 
    
    	--- Prototype --- 
    	call ["IsNotEqualTypeAll",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeAll check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - Anything - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotEqualTypeAll",{
		params ["_arg1","_arg2",["_message",nil,[""]]];
		if (_arg1 isEqualTypeAll _arg2) then {
			_self call ["Fail",["IsNotEqualTypeAll",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsEqualTypeAny 
    
    	--- Prototype --- 
    	call ["IsEqualTypeAny",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeAny check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - <Array> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsEqualTypeAny",{
		params ["_arg1",["_arg2",[],[[]]],["_message",nil,[""]]];
		if !(_arg1 isEqualTypeAll _arg2) then {
			_self call ["Fail",["IsEqualTypeAny",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotEqualTypeAny 
    
    	--- Prototype --- 
    	call ["IsNotEqualTypeAny",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeAny check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - <Array> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotEqualTypeAny",{
		params ["_arg1",["_arg2",[],[[]]],["_message",nil,[""]]];
		if (_arg1 isEqualTypeAll _arg2) then {
			_self call ["Fail",["IsNotEqualTypeAny",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsEqualTypeArray 
    
    	--- Prototype --- 
    	call ["IsEqualTypeArray",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeArray check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - <Array> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsEqualTypeArray",{
		params ["_arg1",["_arg2",[],[[]]],["_message",nil,[""]]];
		if !(_arg1 isEqualTypeArray _arg2) then {
			_self call ["Fail",["IsEqualTypeArray",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotEqualTypeArray 
    
    	--- Prototype --- 
    	call ["IsNotEqualTypeArray",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeArray check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - <Array> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotEqualTypeArray",{
		params ["_arg1",["_arg2",[],[[]]],["_message",nil,[""]]];
		if (_arg1 isEqualTypeArray _arg2) then {
			_self call ["Fail",["IsNotEqualTypeArray",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsEqualTypeParams 
    
    	--- Prototype --- 
    	call ["IsEqualTypeParams",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeParams check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - <Array> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsEqualTypeParams",{
		params ["_arg1",["_arg2",[],[[]]],["_message",nil,[""]]];
		if !(_arg1 isEqualTypeParams _arg2) then {
			_self call ["Fail",["IsEqualTypeParams",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotEqualTypeParams 
    
    	--- Prototype --- 
    	call ["IsNotEqualTypeParams",[_arg1, _arg2, _message*]]
    	---

	Performs an IsEqualTypeParams check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_arg1 - Anything - The value to check
    	_arg2 - <Array> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotEqualTypeParams",{
		params ["_arg1",["_arg2",[],[[]]],["_message",nil,[""]]];
		if (_arg1 isEqualTypeParams _arg2) then {
			_self call ["Fail",["IsNotEqualTypeParams",_this#2, createhashmapfromarray [["_arg1",_arg1],["_arg2",_arg2]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsFalse 
    
    	--- Prototype --- 
    	call ["IsFalse",[_bool, _message*]]
    	---

	Performs an <Boolean> check. Fails with <XPS_UT_typ_AssertFailedException> if Equal
	
    Parameters: 
		_bool - <Boolean> - The value to check

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsFalse",{
		params [["_bool",false,[true]],["_message",nil,[""]]];
		if (_bool) then {
			_self call ["Fail",["IsFalse",_this#1, createhashmapfromarray [["_bool",_bool]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsTrue 
    
    	--- Prototype --- 
    	call ["IsTrue",[_bool, _message*]]
    	---

	Performs an <Boolean> check. Fails with <XPS_UT_typ_AssertFailedException> if Not Equal
	
    Parameters: 
		_bool - <Boolean> - The value to check

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsTrue",{
		params [["_bool",false,[true]],["_message",nil,[""]]];
		if !(_bool) then {
			_self call ["Fail",["IsTrue",_this#1, createhashmapfromarray [["_bool",_bool]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsInstanceOfType 
    
    	--- Prototype --- 
    	call ["IsInstanceOfType",[_hashmap, _type, _message*]]
    	---

	Performs an check on the Hashmap's "#type" key. Fails with <XPS_UT_typ_AssertFailedException> if 
	_type is not in "#type" <array>.
	
    Parameters: 
		_hashmap - <Hashmap> or <HashmapObject> - The value to check
    	_type - <String> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsInstanceOfType",{
		params [["_hashmapobject",createhashmapfromarray [["#type",[]]],[createhashmap]],["_type","",[""]],["_message",nil,[""]]];
		if !(_type in _hashmapobject get "#type") then {
			_self call ["Fail",["IsInstanceOfType",_this#2, createhashmapfromarray [["_hashmapobject",_hashmapobject],["_type",_type]]]];
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotInstanceOfType 
    
    	--- Prototype --- 
    	call ["IsNotInstanceOfType",[_hashmap, _type, _message*]]
    	---

	Performs an check on the Hashmap's "#type" key. Fails with <XPS_UT_typ_AssertFailedException> if 
	_type is in "#type" <array>.
	
    Parameters: 
		_hashmap - <Hashmap> or <HashmapObject> - The value to check
    	_type - <String> - The value expected

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotInstanceOfType",{
		params [["_hashmapobject",createhashmapfromarray [["#type",[]]],[createhashmap]],["_type","",[""]],["_message",nil,[""]]];
		if (_type in _hashmapobject get "#type") then {
			_self call ["Fail",["IsNotInstanceOfType",_this#2, createhashmapfromarray [["_hashmapobject",_hashmapobject],["_type",_type]]]];
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNil 
    
    	--- Prototype --- 
    	call ["IsNil",[_arg, _message*]]
    	---

	Performs an IsNil check. Fails with <XPS_UT_typ_AssertFailedException> if Not Nil
	
    Parameters: 
		_arg - Anything - The value to check

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNil",{
		params ["_arg",["_message",nil,[""]]];
		if !(isNil {_arg}) then {
			_self call ["Fail",["IsNil",_this#1, createhashmapfromarray [["_arg",_arg]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotNil 
    
    	--- Prototype --- 
    	call ["IsNotNil",[_arg, _message*]]
    	---

	Performs an IsNil check. Fails with <XPS_UT_typ_AssertFailedException> if Nil
	
    Parameters: 
		_arg - Anything - The value to check

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotNil",{
		params ["_arg",["_message",nil,[""]]];
		if (isNil {_arg}) then {
			_self call ["Fail",["IsNotNil",_this#1, createhashmapfromarray [["_arg",_arg]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNull 
    
    	--- Prototype --- 
    	call ["IsNull",[_arg, _message*]]
    	---

	Performs an IsNull check. Fails with <XPS_UT_typ_AssertFailedException> if Not Null
	
    Parameters:
		- _arg - See Below: 
		
		Accepted Types to check:
		<Object>
		<Group>
		<Control>
		<Display>
		<Location>
		<Task>
		<Script>
		<Config>
		<Diary Record>
		<Team Member>

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNull",{
		params [["_arg",configFile,[objNull]],["_message",nil,[""]]];
		if !(isNull _arg) then {
			_self call ["Fail",["IsNull",_this#1, createhashmapfromarray [["_arg",_arg]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: IsNotNull 
    
    	--- Prototype --- 
    	call ["IsNotNull",[_arg, _message*]]
    	---

	Performs an IsNull check. Fails with <XPS_UT_typ_AssertFailedException> if Null
	
    Parameters: 
		- _arg - See Below: 

		Accepted Types to check:
		<Object>
		<Group>
		<Control>
		<Display>
		<Location>
		<Task>
		<Script>
		<Config>
		<Diary Record>
		<Team Member>

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["IsNotNull",{
		params [["_arg",objNull,[objNull]],["_message",nil,[""]]];
		if (isNull _arg) then {
			_self call ["Fail",["IsNotNull",_this#1, createhashmapfromarray [["_arg",_arg]]]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: ThrowsException 
    
    	--- Prototype --- 
    	call ["ThrowsException",[_code, _exceptionType, _message*]]
    	---

	Runs the code supplied. Local variables should pass through from the Test Method but if desired,
	the entire test can be passed as the code parameter.
	
    Parameters: 
		- _code - <Code> - the code to execute which is expected to throw an exception
		- _exceptionType <string> - the exception type to catch (can be a parent class)

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["ThrowsException",{
		params [["_code",{},[{}]],["_exceptionType","",[""]],["_message",nil,[""]]];
		try {
			call _code;
			_self call ["Fail",["ThrowsException",_this#2, createhashmap]]
		} catch {
			if (_exception isequaltype createhashmap) then {
				if !(_exceptionType in (_exception getordefault ["#type",[]])) then {
					_self call ["Fail",["ThrowsException",_this#2, _exception]];
				};
			} else {
				_self call ["Fail",["ThrowsException",_this#2, createhashmapfromarray [["_exception",_exception]]]];
			};
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: WithinRange 
    
    	--- Prototype --- 
    	call ["WithinRange",[_num, ,_min, _max,  _message*]]
    	---

	Performs a Within Range check. Fails with <XPS_UT_typ_AssertFailedException> if _num is out of bounds
	
    Parameters: 
		- _num - <Scalar> - the number to check
		- _min - <Scalar> - the minimum value _num can be
		- _max - <Scalar> - the maximum value _num can be

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["WithinRange",{
		params [["_num"],0,[0],["_min"],0,[0],["_max",0,[0]],["_message",nil,[""]]];
		if (_num > _max || _num < _min) then {
			_self call ["Fail",["WithinRange",_this#3, createhashmap]]
		};
		nil;
	}],
	/*-----------------------------------------------------------------------------
	Method: OutOfRange 
    
    	--- Prototype --- 
    	call ["OutOfRange",[_num, ,_min, _max,  _message*]]
    	---

	Performs an Out of Range check. Fails with <XPS_UT_typ_AssertFailedException> if _num is within bounds
	
    Parameters: 
		- _num - <Scalar> - the number to check
		- _min - <Scalar> - the minimum value _num cannot be in range of
		- _max - <Scalar> - the maximum value _num cannot be in range of

	Optionals:
		_message* - <String> - (Optional - Default : nil) - The message to place in the Exception if failed
	-----------------------------------------------------------------------------*/
	["OutOfRange",{
		params [["_num"],0,[0],["_min"],0,[0],["_max",0,[0]],["_message",nil,[""]]];
		if (_num <= _max && _num >= _min) then {
			_self call ["Fail",["OutOfRange",_this#3, createhashmap]]
		};
		nil;
	}]
]