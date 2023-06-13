#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarGraph
<Interface>

Authors:
    Crashdome

	Method: GetEstimatedDistance

	Method: GetNeighbors

	Method: GetMoveCost

	Method: GetNodeAt

	Method: Init
---------------------------------------------------------------------------- */
[
	["GetEstimatedDistance","CODE"], // params [_current,_end]
	["GetNeighbors","CODE"], // params [_current,_prev,_doctrine]
	["GetMoveCost","CODE"], // params [_current,_next,_doctrine]
	["GetNodeAt","CODE"], // params [_pos,_doctrine]
	["Init","CODE"]
]