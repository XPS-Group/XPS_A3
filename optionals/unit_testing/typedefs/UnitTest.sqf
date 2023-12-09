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
	["#create",{
		params [["_className","",[""]],["_methodName","",[""]]];
		_self set ["ClassName", _className];
		_self set ["MethodName", _methodName];
		_self set ["Details",[]];
	}],
	["@interfaces",["XPS_UT_ifc_IUnitTest"]],
	["#str",{_self get "#type" select 0}],
	["ClassName",""],
	["MethodName",""],
	["Result","Not Run"],
	["Details",[]],
	["IsSelected",true]
]