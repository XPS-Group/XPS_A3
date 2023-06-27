/* -----------------------------------------------------------------------------
TypeDef: pathfinding. XPS_PF_typ_RoadNode
	<TypeDefinition>

Authors: 
	Crashdome

Description:
	<HashmapObject> which represents a road object with extra meta data 
	for pathfinding and navigation

Parent:
	none

Implements: 

	<XPS_PF_ifc_IRoadNode>

	<main. XPS_ifc_IAstarNode>

Flags: 
	none

--------------------------------------------------------------------------------*/
[
	["#str",compileFinal {"XPS_PF_typ_RoadNode"}],
	["#type","XPS_PF_typ_RoadNode"],
	["@interfaces",["XPS_PF_ifc_IRoadNode","XPS_ifc_IAstarNode"]],	
	/*----------------------------------------------------------------------------
	Property: BeginPos
    
    	--- Prototype --- 
    	get "BeginPos"
    	---
    
    Returns: 
		<Array> - beginning position in ASL
	-----------------------------------------------------------------------------*/
	["BeginPos",[]],
	/*----------------------------------------------------------------------------
	Property: ConnectedTo
    
    	--- Prototype --- 
    	get "ConnectedTo"
    	---
    
    Returns: 
		<Hashmap> - contains 4 keys: MAIN ROAD, ROAD, TRACK, and TRAIL. Each holds a <Hashmap> of 
		key/value pair of connected roads in format ["name",road object]
	-----------------------------------------------------------------------------*/
	["ConnectedTo",createhashmap],
	/*----------------------------------------------------------------------------
	Property: EndPos
    
    	--- Prototype --- 
    	get "EndPos"
    	---
    
    Returns: 
		<Array> - end Position in ASL
	-----------------------------------------------------------------------------*/
	["EndPos",[]],
	/*----------------------------------------------------------------------------
	Property: IsBridge
    
    	--- Prototype --- 
    	get "IsBridge"
    	---
    
    Returns: 
		<Boolean> - true if object is a bridge object
	-----------------------------------------------------------------------------*/
	["IsBridge",false],
	/*----------------------------------------------------------------------------
	Property: PosASL
    
    	--- Prototype --- 
    	get "PosASL"
    	---
    
    Returns: 
		<Array> - position in ASL
	-----------------------------------------------------------------------------*/
	["PosASL",[]],
	/*----------------------------------------------------------------------------
	Property: Index
    
    	--- Prototype --- 
    	get "Index"
    	---

		<main. XPS_ifc_IAstarNode>

    Returns: 
		<String> - the key used to store this in a <XPS_PF_typ_RoadGraph>
	-----------------------------------------------------------------------------*/
	["Index",nil],
	/*----------------------------------------------------------------------------
	Property: RoadObject
    
    	--- Prototype --- 
    	get "RoadObject"
    	---
    
    Returns: 
		<Object> - the road object associated with this node
	-----------------------------------------------------------------------------*/
	["RoadObject",nil],
	/*----------------------------------------------------------------------------
	Property: Type
    
    	--- Prototype --- 
    	get "Type"
    	---
    
    Returns: 
		<String> - the type of road object associated with this node. Can be one of
		"MAIN ROAD", "ROAD", "TRACK", "TRAIL"
	-----------------------------------------------------------------------------*/
	["Type",""],
	/*----------------------------------------------------------------------------
	Property: Width
    
    	--- Prototype --- 
    	get "Width"
    	---
    
    Returns: 
		<Number> - Width of road object
	-----------------------------------------------------------------------------*/
	["Width",0],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	_result = createHashmapObject ["XPS_typ_Name",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		_result - <HashmapObject>
	-----------------------------------------------------------------------------*/
	["#create",compileFinal {
		params [["_index",nil,[""]],["_object",objNull,[objNull]]];
		_self set ["Index",_index];
		_self set ["RoadObject",_object];
		_self set ["ConnectedTo",createhashmap];
		//_self set ["ConnectedToPath",createhashmapfromarray [["RHDrive",createhashmap],["RHWalk",createhashmap],["LHDrive",createhashmap],["LHWalk",createhashmap]]];
		private _roadInfo = getRoadInfo _object;
		_self set ["Type",_roadInfo#0]; 
		_self set ["Width",_roadInfo#1]; 
		_self set ["BeginPos",_roadInfo#6]; 
		_self set ["EndPos",_roadInfo#7]; 
		_self set ["IsBridge",_roadInfo#8]; 
		private _aslPos = getposASL _object;
		_aslPos set [2,((_roadInfo#7#2) + (_roadInfo#6#2))/2];
		_self set ["PosASL",_aslPos]; 
	}]
]