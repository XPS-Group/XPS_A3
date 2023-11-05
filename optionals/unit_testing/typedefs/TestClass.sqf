#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestClass
	<TypeDefinition>

	--- prototype
	createhashmapobject [XPS_UT_typ_TestClass];
	---

Authors: 
	Crashdome
   
Description:
	Contains Methods which will be called according to order defined in <TestOrder> property

Parent:
    none

Implements:
    <XPS_UT_ifc_ITestClass>

Flags:


---------------------------------------------------------------------------- */
[
	["#str",compilefinal {_self get "#type" select 0}],
	["#type","XPS_UT_typ_TestClass"],
	["@interfaces",["XPS_UT_ifc_ITestClass"]],
	//["#flags",["unscheduled"]],
	/*----------------------------------------------------------------------------
	Property: Description
    
    	--- Prototype --- 
    	get "Description"
    	---
		
		<XPS_UT_ifc_ITestClass>
    
    Returns: 
		<String> - A friendly description of what the Test Methods are testing
	-----------------------------------------------------------------------------*/
	["Description","Base Test Class"],
	/*----------------------------------------------------------------------------
	Property: TestOrder
    
    	--- Prototype --- 
    	get "TestOrder"
    	---
		
		<XPS_UT_ifc_ITestClass>
    
    Returns: 
		<Array> - of <Strings> of method names in the order they should be tested
	-----------------------------------------------------------------------------*/
	["TestOrder",[]]
]