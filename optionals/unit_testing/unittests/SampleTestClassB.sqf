#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_SampleTestClassB
	<TypeDefinition>
	---prototype
	XPS_UT_typ_SampleTestClassB : XPS_UT_ifc_ITestClass, XPS_UT_typ_TestClass
	---

Authors: 
	Crashdome
   
Description:
	A sample Unit Test Class.
	
	Contains Methods which will be called according to order defined in <TestOrder> property

---------------------------------------------------------------------------- */
[
	["#type","XPS_UT_typ_SampleTestClassB"],
	/*----------------------------------------------------------------------------
	Parent: #base
		<XPS_UT_typ_TestClass>
	----------------------------------------------------------------------------*/
	["#base", XPS_UT_typ_TestClass],
	["Description","Sample Test Class B"],
	["TestOrder",[
		"Check A and B are same type",
		"Check B and C are same type",
		"Check A and C are same type",
		"Check A and B are not the same",
		"Check A and B are not equal to each other",
		"Check We can append [10] to A"
	 ]],
	["InitTest", compileFinal {
		//Initialize some testing values
		XPS_SampleTest_Values = createHashMapFromArray [
			["A",[1]],
			["B",[2]],
			["C",[3]]
		];
	}],
	["FinalizeTest", compileFinal {
		//Destroy testing values
		XPS_SampleTest_Values = nil;
	}],
	// Test Methods ------------------------------------
	["Check A and B are same type", compileFinal {
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["IsEqualType",[_a,_b]];
	}],
	["Check B and C are same type", compileFinal {
		private _c = XPS_SampleTest_Values get "C";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["IsEqualType",[_c,_b]];
	}],
	["Check A and C are same type", compileFinal {
		private _a = XPS_SampleTest_Values get "A";
		private _c = XPS_SampleTest_Values get "C";

		XPS_UT_Assert call ["IsEqualType",[_a,_c]];
	}],
	["Check A and B are not the same", compileFinal {
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["AreNotSame",[_a,_b]];
	}],
	["Check A and B are not equal to each other", compileFinal {
		private _a = XPS_SampleTest_Values get "A";
		private _b = XPS_SampleTest_Values get "B";

		XPS_UT_Assert call ["AreNotEqual",[_a,_b]];
	}],
	["Check We can append [10] to A", compileFinal {
		XPS_SampleTest_Values get "A" append [10];
		private _a = XPS_SampleTest_Values get "A";

		XPS_UT_Assert call ["AreEqual",[_a,[1,10]]];
	}]
]
