#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_IAstarGraph
<Interface>

Authors:
    Crashdome

	Method: GetEstimatedDistance

	Recommended Parameters:
	
		_current - <XPS_ifc_IAstarNode>
		_end - <XPS_ifc_IAstarNode>

	Method: GetNeighbors

	Recommended Parameters:
	
		_current - <XPS_ifc_IAstarNode>
		_prev - <XPS_ifc_IAstarNode>
		_doctrine - <XPS_ifc_IAstarNode>

	Method: GetMoveCost

	Recommended Parameters:
	
		_current - <XPS_ifc_IAstarNode>
		_next - <XPS_ifc_IAstarNode>
		_doctrine - <XPS_ifc_IAstarNode>

	Method: GetNodeAt

	Recommended Parameters:
	
		_pos - <Array>

	Method: Init
---------------------------------------------------------------------------- */
[
	["GetEstimatedDistance","CODE"], // params [_current,_end]
	["GetNeighbors","CODE"], // params [_current,_prev,_doctrine]
	["GetMoveCost","CODE"], // params [_current,_next,_doctrine]
	["GetNodeAt","CODE"], // params [_pos]
	["Init","CODE"]
]