#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_UT_typ_Engine
	<Singleton>

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
private _def = [
	["#str", {_self get "#type"}],
	["#type","XPS_UT_type_Engine"],
	["#flags",["sealed","nocopy"]],
	["#base",XPS_typ_HashmapCollection],
	["AddItem",{}],
	["RemoveItem",{}],
	["Selected",[]],
	["RunAll",{}],
	["RunSelected",{}]
];

compilefinal createhashmapobject [_def];