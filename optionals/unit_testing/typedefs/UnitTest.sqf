#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_UnitTest
	<TypeDefinition>
	---prototype
	XPS_UT_typ_UnitTest : XPS_UT_ifc_IUnitTest
	---
	---prototype
	createhashmapobject [XPS_UT_typ_UnitTest,[_class, _methodName]]
	---

Authors: 
	Crashdome
   
Description:
	
Optionals:
	_class - <HashmapObject> - of type <XPS_UT_typ_TestClass>
	_methodName - <String> - name of the method to test or Empty <string> ("") if the initialization of the class

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_UnitTest"],
	["#str",_self get "#type" select 0],
	["#create",{
		params [["_class",createhashmap,[createhashmap]],["_methodName","",[""]]];
		_self set ["_classRef",_class];
		_self set ["_className",_class get "Description"];
		_self set ["_classMethod",_methodName];
		_self set ["_isMethod",(_methodName isNotEqualTo "")];
		_self set ["_testResult",""];
		_self set ["_testDetail","Not Tested"];
		_self set ["_isSelected",true];
	}],
	["@interfaces",["XPS_UT_ifc_IUnitTest"]],
	["_classRef",nil],
	["_className",nil],
	["_classMethod",nil],
	["_testResult",nil],
	["_testDetail",nil],
	["_isSelected",nil],
	["_isMethod",nil],
	["IsMethod",{
		_self get "_isMethod";
	}],
	["IsSelected",{
		_self get "_isSelected";
	}],
	["SetSelected",{
		param [0,true,[true]];
		_self set ["_isSelected",_this];
	}],
	["GetClass",{
		_self get "_classRef";
	}],
	["GetClassName",{
		_self get "_className";
	}],
	["GetData",{
		[
			_self get "_isSelected", 
			_self get "_className",
			_self get "_isMethod", 
			_self get "_classMethod", 
			_self get "_testResult",
			_self get "_testDetail"
		]
	}],
	["SetResult",{
		params [["_result","",[""]],["_detail","",[""]]];
		_self set ["_testResult",_result];
		_self set ["_testDetail",_detail];
	}]
]