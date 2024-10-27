#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_MapGraphDoctrine
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Provides Heuristics and Weights for a search of a <XPS_PF_typ_MapGraph> object

Parent:
	none

Implements: 
	<XPS_PF_ifc_IMapGraphDoctrine>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str", compileFinal {"XPS_PF_typ_MapGraphDoctrine"}],
	["#type","XPS_PF_typ_MapGraphDoctrine"],
	["@interfaces",["XPS_PF_ifc_IMapGraphDoctrine"]],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_PF_typ_MapGraphDoctrine",[_modifiers*,_capabilities*,_limits*]]
    	---
    
    Optionals: 
		_modifiers* - <Array> - (Optional - Default : [0,0,0,0]) - an array of values in format [a,b,c,d]
		_capabilities* - <Array> - (Optional - Default : [true,true,true,true,true]) - an array of values in format [a,b,c,d,e]
		_limits* - <Array> - (Optional - Default : [0,0,0]) - an array of values in format [a,b,c]

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		if !(params [["_modifiers",[0,0,0,0],[[]],[4]],["_capabilities",[true,true,true,true,true],[[]],[5]],["_limits",[0,0,0],[[]],[3]]]) exitwith {nil;};

		_self set ["Weights",["RoadWeight","WaterWeight","HeightWeight","DensityWeight"] createhashmapfromarray _modifiers];
		_self set ["Capabilities",["CanUseLand","CanUseTrails","CanUseRoads","CanUseWater","CanUseAir"] createhashmapfromarray _capabilities];
		_self set ["Limits",["MaxSlope","MaxDensity","MaxWaterDistance"] createhashmapfromarray _limits];
	}],
	/*----------------------------------------------------------------------------
	Property: Weights
    
    	--- Prototype --- 
    	get "Weights"
    	---
    
    Returns: 
		<Hashmap> - (Default : [0,0,0,0]) where keys from first to last are: 
		
		- RoadWeight - <Number> - normalized value from -1 to 1
		- WaterWeight - <Number> - normalized value from -1 to 1
		- HeightWeight - <Number> - normalized value from -1 to 1
		- DensityWeight - <Number> - normalized value from -1 to 1
	-----------------------------------------------------------------------------*/
	["Weights",createhashmap],
	/*----------------------------------------------------------------------------
	Property: Capabilities
    
    	--- Prototype --- 
    	get "Capabilities"
    	---
    
    Returns: 
		<Hashmap> - (Default : [true,true,true,true,true]) where keys from first to last are: 
		
    	- CanUseLand - <Boolean>
    	- CanUseTrails - <Boolean>
    	- CanUseRoads - <Boolean>
    	- CanUseWater - <Boolean>
    	- CanUseAir - <Boolean>
	-----------------------------------------------------------------------------*/
	["Capabilities",createhashmap],
	/*----------------------------------------------------------------------------
	Property: Limits
    
    	--- Prototype --- 
    	get "Limits"
    	---
    
    Returns: 
		<Hashmap> - (Default : [0,0]) where keys from first to last are: 
		
		- MaxSlope - <Number> - value from 0 to 1
		- MaxDensity - <Number> - value from 0 to 100
		- MaxWaterDistance- <Number> - value from 0 to Infinity (WorldSize?)
	-----------------------------------------------------------------------------*/
	["Limits",createhashmap]
]