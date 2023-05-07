#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_PathfindingScheduler
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Takes <XPS_typ_AstarSearch> items and processes them gradually on a per frame basis.

Parent:
	<main.XPS_typ_JobScheduler>

Implements: 
	<main.XPS_ifc_IJobScheduler>, <main.XPS_ifc_ICollection>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_PF_typ_PathfindingScheduler"}],
	["#parent","XPS_typ_JobScheduler"],
	["AllowedTypes",["XPS_typ_AstarSearch"]],
	["ProcessCurrent",compileFinal {
		private _current = _self get "CurrentItem";
		if !(isNil {_current}) then {
			_current call ["ProcessNextNode"];
		};
	}]
]