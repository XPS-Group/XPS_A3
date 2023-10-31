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

	Protected: popQueue

		<main. XPS_typ_JobScheduler.popQueue>

	Property: CurrentItem

		<main. XPS_typ_JobScheduler.CurrentItem>

	Property: CurrentUID

		<main. XPS_typ_JobScheduler.CurrentUID>

	Property: ProcessesPerFrame

		<main. XPS_typ_JobScheduler.ProcessesPerFrame>

	Property: Queue

		<main. XPS_typ_JobScheduler.Queue>

    Method: AddItem

		<main. XPS_typ_Hashmapcollection.AddItem>

	Method: FinalizeCurrent

		<main. XPS_typ_JobScheduler.FinalizeCurrent>

    Method: RegisterType

		<main. XPS_typ_Hashmapcollection.RegisterType>

    Method: RemoveItem

		<main. XPS_typ_Hashmapcollection.RemoveItem>

	Method: Start

    	<main. XPS_typ_JobScheduler.Start>

	Method: Stop

    	<main. XPS_typ_JobScheduler.Stop>
--------------------------------------------------------------------------------*/
[
	["#str", compileFinal {"XPS_PF_typ_PathfindingScheduler"}],
	["#type","XPS_PF_typ_PathfindingScheduler"],
	["#base",XPS_typ_JobScheduler],
	/*----------------------------------------------------------------------------
	Property: AllowedTypes
    
    	--- Prototype --- 
    	get "AllowedTypes"
    	---
    
		Override of <main. XPS_typ_Hashmapcollection.AllowedTypes>

    Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["AllowedTypes",["XPS_PF_typ_MapGraphSearch","XPS_PF_typ_RoadGraphSearch","XPS_typ_AstarSearch"]],
	/*----------------------------------------------------------------------------
	Property: ProcessCurrent
    
    	--- Prototype --- 
    	get "ProcessCurrent"
    	---
    
		Override of <main. XPS_ifc_IJobScheduler.ProcessCurrent>

    Returns: 
		Nothing
	-----------------------------------------------------------------------------*/
	["ProcessCurrent",compileFinal {
		_self call ["XPS_typ_JobScheduler.ProcessCurrent"];
		private _current = _self get "CurrentItem";
		if !(isNil {_current}) then {
			_current call ["ProcessNextNode"];
			if (_current get "Status" in ["SUCCESS","FAILED"]) then {
				_self call ["FinalizeCurrent"];
			};
		};
	}]
]