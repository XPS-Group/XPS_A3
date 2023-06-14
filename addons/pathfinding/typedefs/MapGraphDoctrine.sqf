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
		_heuristics* - <Array> - (Optional - Default : [0.9, 1, 1.2]) 
    	_roadTypes* - <Array> - (Optional - Default : ["MAIN ROAD","ROAD","TRACK"]) 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_heuristics",[0,0,0,0],[[]],[3]],["_roadTypes",["MAIN ROAD","ROAD","TRACK"],[[]],[1,2,3,4]],["_drive","RHDrive",[""]]];
		_self set ["Heuristics",_heuristics];
		_self set ["MapTypes",_roadTypes];
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
	["Heuristics",nil]
]