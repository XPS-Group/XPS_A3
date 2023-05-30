/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_RoadGraphDoctrine
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	Provides Heuristics and Road Type conditions for a search of a <XPS_PF_typ_RoadGraph> object

Parent:
	none

Implements: 
	none

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",{"XPS_PF_typ_RoadGraphDoctrine"}],
	["#type","XPS_PF_typ_RoadGraphDoctrine"],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_PF_typ_RoadGraphDoctrine",[_heuristics*,_roadTypes*]]
    	---
    
    Optionals: 
		_heuristics* - <Array> - (Optional - Default : [0.9, 1, 1.2]) 
    	_roadTypes* - <Array> - (Optional - Default : ["MAIN ROAD","ROAD","TRACK"]) 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_heuristics",[0.9, 1, 1.2],[[]],[3]],["_roadTypes",["MAIN ROAD","ROAD","TRACK"],[[]],[1,2,3,4]],["_drive","RHDrive",[""]]];
		_self set ["Heuristics",_heuristics];
		_self set ["RoadTypes",_roadTypes];
		// if !(_drive in ["RHDrive","LHDrive","RHWalk","LHWalk"]) then {_drive = "RHDrive"};
		// _self set ["Drive",_drive];
	}],
	/*----------------------------------------------------------------------------
	Property: Heuristics
    
    	--- Prototype --- 
    	get "Heuristics"
    	---
    
    Returns: 
		<Array> - (Deafult : [0.90, 1.00, 1.20]) - an array of values in format [a,b,c]
		where first value is for type "MAINROAD", second type is for "ROAD", and third 
		value is for "TRACK" and also "TRAIL" if included
	-----------------------------------------------------------------------------*/
	["Heuristics",nil],
	/*----------------------------------------------------------------------------
	Property: RoadTypes
    
    	--- Prototype --- 
    	get "RoadTypes"
    	---
    
    Returns: 
		<Array> - (Default : ["MAIN ROAD","ROAD","TRACK"]) - the array to pass into 
		nearestTerrainObjects to filter types of roads when doing a search. Can include
		"TRAIL" in array if searching path for walking units.
	-----------------------------------------------------------------------------*/
	["RoadTypes",["MAIN ROAD","ROAD","TRACK"]]
	//,["Drive",nil]
]