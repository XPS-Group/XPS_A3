#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_Engine
	<TypeDefintion>

Authors: 
	Crashdome

Description:
	A Singleton object which is a collection of Unit Test Classes that can be run
	to perform Unit Tests of other <Hashmap Objects>

Parent:
	none

Implements: 
	none

Flags: 
	NoCopy
	Sealed

---------------------------------------------------------------------------- */
[
	["#str", {_self get "#type" select  0}],
	["#type","XPS_UT_type_Engine"],
	["#flags",["sealed","nocopy"]],
	["#base",XPS_typ_HashmapCollection],
	["Selected",[]],
	["RunAll",{}],
	["RunSelected",{}]
];