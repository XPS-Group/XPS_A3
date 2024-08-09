#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_SampleTestClassA
	<TypeDefinition>
	---prototype
	XPS_UT_typ_SampleTestClassA : XPS_UT_ifc_ITestClass, XPS_UT_typ_TestClass
	---

Authors: 
	Crashdome
   
Description:
	A sample Unit Test Class.
	
	Contains Methods which will be called according to order defined in <TestOrder> property

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_SampleTestClassA"],
	/*----------------------------------------------------------------------------
	Parent: #base
		<XPS_UT_typ_TestClass>
	----------------------------------------------------------------------------*/
	["#base", XPS_UT_typ_TestClass],
	/*----------------------------------------------------------------------------
	Property: Description
		---code 
		"Sample Test Class A"
		---
	----------------------------------------------------------------------------*/
	["Description","Sample Test Class A"],
	/*----------------------------------------------------------------------------
	Property: TestOrder
		---code 
		[
			"Check A and B are same type",
			"Check B and C are same type",
			"Check A and C are same type",
			"Check A and B are not the same",
			"Check A and B are not equal to each other",
			"Check We can set A to 10",
			"Check A plus B equals 3"
		]
		---
	----------------------------------------------------------------------------*/
	["TestOrder",[
		"Check A and B are same type",
		"Check B and C are same type",
		"Check A and C are same type",
		"Check A and B are not the same",
		"Check A and B are not equal to each other",
		"Check A plus B equals 12",
		"Check We can set A to 10"
	 ]],
	/*----------------------------------------------------------------------------
	Method: InitTest
		---code 
		{
			//Initialize some testing values
			XPS_SampleTest_Values = createhashmapfromarray [
				["A",1],
				["B",2],
				["C",3]
			];
		}
		---
	----------------------------------------------------------------------------*/
	["InitTest", compileFinal {
		//Initialize some testing values
		XPS_SampleTest_Values = createhashmapfromarray [
			["A",1],
			["B",2],
			["C",3]
		];
	}],
	/*----------------------------------------------------------------------------
	Method: FinalizeTest
		---code 
		{			
			//Destroy testing values
			XPS_SampleTest_Values = nil;
		}
		---
	----------------------------------------------------------------------------*/
	["FinalizeTest", compileFinal {
		//Destroy testing values
		XPS_SampleTest_Values = nil;
	}],
	// Test Methods ------------------------------------
	/*----------------------------------------------------------------------------
	Method: Check A and B are same type
		---code 
		{			
			private _a = XPS_SampleTest_Values get "A";
			private _b = XPS_SampleTest_Values get "B";

			XPS_UT_Assert call ["IsEqualType",[_a,_b]];
		}
		---
	----------------------------------------------------------------------------*/
	["Check A and B are same type",{
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["IsEqualType",[_a,_b]];
	}],
	/*----------------------------------------------------------------------------
	Method: Check B and C are same type
		---code 
		{			
			private _c = XPS_SampleTest_Values get "C";
			private _b = XPS_SampleTest_Values get "B";

			XPS_UT_Assert call ["IsEqualType",[_c,_b]];
		}
		---
	----------------------------------------------------------------------------*/
	["Check B and C are same type",{
		private _c = XPS_SampleTest_Values get "C";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["IsEqualType",[_c,_b]];
	}],
	/*----------------------------------------------------------------------------
	Method: Check A and C are same type
		---code 
		{			
			private _a = XPS_SampleTest_Values get "A";
			private _c = XPS_SampleTest_Values get "C";

			XPS_UT_Assert call ["IsEqualType",[_a,_c]];
		}
		---
	----------------------------------------------------------------------------*/
	["Check A and C are same type",{
		private _a = XPS_SampleTest_Values get "A";
		private _c = XPS_SampleTest_Values get "C";

		XPS_UT_Assert call ["IsEqualType",[_a,_c]];
	}],
	/*----------------------------------------------------------------------------
	Method: Check A and B are not the same
		---code 
		{			
			private _a = XPS_SampleTest_Values get "A";
			private _b = XPS_SampleTest_Values get "B";

			XPS_UT_Assert call ["AreNotSame",[_a,_b]];
		}
		---
	----------------------------------------------------------------------------*/
	["Check A and B are not the same",{
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["AreNotSame",[_a,_b]];
	}],
	/*----------------------------------------------------------------------------
	Method: Check A and B are not equal to each other
		---code 
		{			
			private _a = XPS_SampleTest_Values get "A";
			private _b = XPS_SampleTest_Values get "B";

			XPS_UT_Assert call ["AreNotEqual",[_a,_b]];
		}
		---
	----------------------------------------------------------------------------*/
	["Check A and B are not equal to each other",{
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["AreNotEqual",[_a,_b]];
	}],
	/*----------------------------------------------------------------------------
	Method: Check A plus B equals 3
		---code 
		{			
			private _sum = (XPS_SampleTest_Values get "A") + (XPS_SampleTest_Values get "B");

			XPS_UT_Assert call ["AreEqual",[_sum,3]]; 
		}

		// THIS TEST FAILS - because we set A to 10 : (10 + 2 = 12) in our testing order prior to this test
		---
	----------------------------------------------------------------------------*/
	["Check A plus B equals 12",{
		private _sum = (XPS_SampleTest_Values get "A") + (XPS_SampleTest_Values get "B");

		XPS_UT_Assert call ["AreEqual",[_sum,12]];
	}],
	/*----------------------------------------------------------------------------
	Method: Check We can set A to 10
		---code 
		{			
			XPS_SampleTest_Values set ["A",10];
			private _a = XPS_SampleTest_Values get "A";

			XPS_UT_Assert call ["AreEqual",[_a,10]];
		}
		---
	----------------------------------------------------------------------------*/
	["Check We can set A to 10",{
		XPS_SampleTest_Values set ["A",10];
		private _a = XPS_SampleTest_Values get "A";

		XPS_UT_Assert call ["AreEqual",[_a,10]];
	}]
]
