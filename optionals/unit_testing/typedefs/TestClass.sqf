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
    	get "TestDescription"
    	---
		
		<XPS_UT_ifc_ITestClass>
    
    Returns: 
		<String> - A friendly description of what the Test Methods are testing
	-----------------------------------------------------------------------------*/
	["TestDescription","Base Test Class"],
	/*----------------------------------------------------------------------------
	Method: FinalizeTest
    
    	--- Prototype --- 
    	call ["FinalizeTest"]
    	---
		
		This method is called by the Unit Testing Engine AFTER it performs
		any Unit Tests. This can be used to clean up the testing environment.

		- When directly inherited this method Does Nothing
		- Can Be Overridden

		<XPS_UT_ifc_ITestClass>
    
    Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["FinalizeTest",{
		//Do Nothing
	}],
	/*----------------------------------------------------------------------------
	Method: InitTest
    
    	--- Prototype --- 
    	call ["InitTest"]
    	---
		
		This method is called by the Unit Testing Engine BEFORE it performs
		any Unit Tests. This can be used to set up the testing environment for
		testing.

		- When directly inherited this method Does Nothing
		- Can Be Overridden

		<XPS_UT_ifc_ITestClass>
    
    Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["InitTest",{
		//Do Nothing
	}],
	/*----------------------------------------------------------------------------
	Property: TestOrder
    
    	--- Prototype --- 
    	get "TestOrder"
    	---
		
		Must Be Overridden and contain values upon creation

		<XPS_UT_ifc_ITestClass>
    
    Returns: 
		<Array> - of <Strings> of method names in the order they should be tested
	-----------------------------------------------------------------------------*/
	["TestOrder",[]]
]