[
	["#str",compileFinal {"TestObjectA"}],
	["#type","TestObjectA"],
	["@interfaces",["ITestObject"]],
    ["PropertyA",10,["VALIDATE_TYPE",0]],
	["PropertyB","Hello"],
	["@ArrayTest",[3,2,1],["VALiDaTe_ALL",0]],
	["Method",{},["OBSOLETE"]],
	["Method",{_self get "PropertyB" + str (_sef get "PropertyA") + _self get "_privateVar"}],
	["TestTrue",true,["CONDITIONAL",{true}]],
	["TestFalse",true,["CONDITIONAL",{false}]],
	["_privateVar","*sneaks away*"]
]