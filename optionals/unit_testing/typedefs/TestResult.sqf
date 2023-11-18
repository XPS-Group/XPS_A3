#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestResult
	<TypeDefinition>
		---prototype
		XPS_UT_typ_TestResult : XPS_UT_ifc_ITestResult
		---
		---prototype
		createhashmapobject [XPS_UT_typ_TestResult]
		---

Authors: 
	Crashdome
   
Description:
	Contains data about the current status or result of a Unit Test

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_TestResult"],
	/*----------------------------------------------------------------------------
	Str: #str
		---text
		"XPS_UT_typ_TestResult"
		---
	----------------------------------------------------------------------------*/
	["#str",compilefinal {_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_UT_ifc_ITestResult>
	----------------------------------------------------------------------------*/
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
	["Exception",nil]
	
]