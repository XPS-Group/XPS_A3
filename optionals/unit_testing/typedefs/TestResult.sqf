#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestResult
	<TypeDefinition>

	--- prototype
	createhashmapobject [XPS_UT_typ_TestResult,[_itemID, _methodName, _result, _exception]];
	---

Authors: 
	Crashdome
   
Description:
	Contains data about the current status or result of a Unit Test

Parent:
    none

Implements:
    <XPS_UT_ifc_ITestResult>

Flags:


---------------------------------------------------------------------------- */
[
	["#str",compilefinal {_self get "#type" select 0}],
	["#type","XPS_UT_typ_TestResult"],
	["@interfaces",["XPS_UT_ifc_ITestResult"]],
	/*----------------------------------------------------------------------------
	Property: ItemID
    
    	--- Prototype --- 
    	get "ItemID"
    	---
		
		<XPS_UT_ifc_ITestResult>
    
    Returns: 
		<String> - The Test Class identifier in the Test Queue
	-----------------------------------------------------------------------------*/
	["ItemID",""],
	/*----------------------------------------------------------------------------
	Property: MethodName
    
    	--- Prototype --- 
    	get "MethodName"
    	---
		
		<XPS_UT_ifc_ITestResult>
    
    Returns: 
		<String> - the name of the method being tested
	-----------------------------------------------------------------------------*/
	["MethodName",""],
	/*----------------------------------------------------------------------------
	Property: Result
    
    	--- Prototype --- 
    	get "Result"
    	---
		
		<XPS_UT_ifc_ITestResult>
    
    Returns: 
		<String> - "SUCCESS", "FAILURE", or "RUNNING"
	-----------------------------------------------------------------------------*/
	["Result",""],
	/*----------------------------------------------------------------------------
	Property: Exception
    
    	--- Prototype --- 
    	get "Exception"
    	---
		
		<XPS_UT_ifc_ITestResult>
    
    Returns: 
		Nil or <main. XPS_typ_Exception> - if any exception was thrown
	-----------------------------------------------------------------------------*/
	["Exception",nil],
	
]