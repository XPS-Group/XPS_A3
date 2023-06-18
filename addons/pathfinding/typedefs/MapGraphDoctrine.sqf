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
	["#str",compileFinal {"XPS_PF_typ_MapGraphDoctrine"}],
	["#type","XPS_PF_typ_MapGraphDoctrine"],
	["@interfaces",["XPS_PF_ifc_IMapGraphDoctrine"]],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_PF_typ_MapGraphDoctrine",[_heuristics*,_roadTypes*]]
    	---
    
    Optionals: 
		_heuristics* - <Array> - (Optional - Default : [0,0,0,0]) - an array of values in format [a,b,c,d]

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_heuristics",[0,0,0,0],[[]],[3]]];
		_self set ["Heuristics",_heuristics];
		_self set ["CanUseLand",true],
		_self set ["CanUseTrails",true],
		_self set ["CanUseRoads",true],
		_self set ["CanUseWater",true],
		_self set ["CanUseAir",true],
		_self set ["MaxSlope",0],
		_self set ["MaxDensity",0]
	}],
	/*----------------------------------------------------------------------------
	Property: Heuristics
    
    	--- Prototype --- 
    	get "Heuristics"
    	---
    
    Returns: 
		<Array> - (Default : [0,0,0,0]) - an array of values in format [a,b,c,d]
		where first to last is: 
		
			- Road Modifier
			- Water Modifier
			- Height Modifier
			- Density Modifier
	-----------------------------------------------------------------------------*/
	["Heuristics",nil],
    ["CanUseLand",nil],
    ["CanUseTrails",nil],
    ["CanUseRoads",nil],
    ["CanUseWater",nil],
    ["CanUseAir",nil],
    ["MaxSlope",nil],
    ["MaxDensity",nil]
]