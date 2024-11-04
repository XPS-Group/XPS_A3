#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_UnitTest
	<TypeDefinition>
	---prototype
	XPS_UT_typ_UnitTest : XPS_UT_ifc_IUnitTest
	---
	---prototype
	createHashmapObject [XPS_UT_typ_UnitTest,[_class, _methodName]]
	---

Authors: 
	Crashdome
   
Description:
	Used to inform Display of what data is to be placed in ListNBoxes
	
Optionals:
	_class - <HashmapObject> - of type <XPS_UT_typ_TestClass>
	_methodName - <String> - name of the method to test or Empty <string> ("") if the initialization of the class

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_UnitTest"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_class, _methodName]]
    	---
    
	Optionals:
		_class - <HashmapObject> - of type <XPS_UT_typ_TestClass>
		_methodName - <String> - name of the method to test or Empty <string> ("") if the initialization of the class

	-----------------------------------------------------------------------------*/
	["#create", compileFinal {
		params [["_className","",[""]],["_methodName","",[""]]];
		_self set ["ClassName", _className];
		_self set ["MethodName", _methodName];
		_self set ["Details",[]];
	}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_UT_ifc_IUnitTest>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_UT_ifc_IUnitTest"]],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_UnitTest"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Protected: ClassName
    
    	--- Prototype --- 
    	get "ClassName"
    	---
    
    Returns: 
		<String> - description
	-----------------------------------------------------------------------------*/
	["ClassName",""],
	/*----------------------------------------------------------------------------
	Protected: MethodName
    
    	--- Prototype --- 
    	get "MethodName"
    	---
    
    Returns: 
		<String> - Method name
	-----------------------------------------------------------------------------*/
	["MethodName",""],
	/*----------------------------------------------------------------------------
	Protected: Result
    
    	--- Prototype --- 
    	get "Result"
    	---
    
    Returns: 
		<String> - State of the Unit Test e.g. Failed, Passed, etc...
	-----------------------------------------------------------------------------*/
	["Result","Not Run"],
	/*----------------------------------------------------------------------------
	Protected: Details
    
    	--- Prototype --- 
    	get "Details"
    	---
    
    Returns: 
		<Array> - An array of arrays where each array element is ["Name","Value"]
	-----------------------------------------------------------------------------*/
	["Details",[]],
	/*----------------------------------------------------------------------------
	Protected: IsSelected
    
    	--- Prototype --- 
    	get "IsSelected"
    	---
    
    Returns: 
		<Boolean>
	-----------------------------------------------------------------------------*/
	["IsSelected",true]
]