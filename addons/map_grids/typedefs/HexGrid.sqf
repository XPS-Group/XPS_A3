#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: map_grids. XPS_MG_typ_HexGrid
	<TypeDefinition>
	---prototype
	XPS_MG_typ_HexGrid : XPS_MG_ifc_IGrid
	---
	---prototype
	XPS_MG_typ_HexGrid
	---

Authors: 
	Crashdome

Description:
	Static Methods for calculating indices along a hexagonal grid independant of
	size.
--------------------------------------------------------------------------------*/
[
	["#type","XPS_MG_typ_HexGrid"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_MG_typ_HexGrid"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_MG_ifc_IGrid>
	-----------------------------------------------------------------------------*/
	["@interfaces",["XPS_MG_ifc_IGrid"]],
	/*----------------------------------------------------------------------------
	Method: GetPositionByIndex
    
    	--- Prototype --- 
    	call ["GetPositionByIndex",[_cellkey, _size]]
    	---

    	<XPS_MG_ifc_IGrid>
    
    Paramters: 
		_cellkey - <Array> - 3-dimensional array of a hex index position - (e.g. [10,15,4]) 
		_size - <Number> - the radius size of the hex  

	Returns:
		_pos - <Array> - 2-dimensional array of world position 

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GetPositionByIndex",{
		if !(params [["_cellKey",[0,0,0],[[]],[3]],["_size",0,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetPositionByIndex",nil,_this]];};

		private _sqrtThree = sqrt(3);
		private _x = _size * ((_sqrtThree*(_cellKey#0))+(_sqrtThree/2*(_cellkey#1)));
		private _y = _size * -(3/2*(_cellKey#1));

		[_x,_y]
	}],
	/*----------------------------------------------------------------------------
	Method: GetIndexByPosition
    
    	--- Prototype --- 
    	call ["GetIndexByPosition",[_pos, _size]]
    	---
    
    	<XPS_MG_ifc_IGrid>

    Paramters: 
		_pos - <object> or <Array> - object with a world position -OR- 2-dimensional array of world position 
		_size - <Number> - the radius size of the hex  

	Returns:
		_cellkey - <Array> - 3-dimensional array of a hex index position - (e.g. [10,15,4]) 

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GetIndexByPosition",{
		if !(params [["_position",[100,100],[[],objnull],[2,3]],["_size",nil,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetIndexByPosition",nil,_this]];};

		private _pos = [];
		if (_position isEqualType []) then {
			_pos = _position;
		} else {
			_pos = getPosASL _position;
		};

		private _xkey = round(((sqrt(3)/3 * (_pos #0)) + (1/3*(_pos#1))) / (_size)); 
		private _ykey = round((-(2/3*(_pos #1))) / (_size)); 
		private _zKey = 0-_xKey-_yKey; 
		
		[_xKey,_yKey,_zKey]
	}],
	/*----------------------------------------------------------------------------
	Method: GetNearbyIndexes
    
    	--- Prototype --- 
    	call ["GetIndexByPosition",[_center, _radius, _includeCenter*]]
    	---
    
    	<XPS_MG_ifc_IGrid>
    
	Paramters: 
		_center - <Array> - 3-dimensional index of the cell in which to start (index - NOT world position) 
		_radius - <Number> - the number of hexes to include in terms of radius (in cells)

    Optionals:
		_includeCenter - <Boolean> - (Default: false) Set <True> to include the center hex in results

	Returns:
		_hexes - <Array> - an array of indices of the hexes within the radius supplied 

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GetNearbyIndexes",{
		if !(params [["_center",[0,0,0],[[]],[3]], ["_radius",0,[0]], "_includecenter"]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetNearbyIndexes",nil,_this]];};
		if (isNil "_includeCenter" || !{_includeCenter isEqualType true}) then {_includeCenter = false};

		private _cells = [];

		for "_x" from -_radius to _radius do {
			for "_y" from -_radius to _radius do {
				private _cellKey = [_x,_y,0]; //get X/Y
				_cellKey set [2,-(_cellKey#0)-(_cellKey#1)]; // calc Z
				if (selectMax (_cellKey apply {abs(_x)}) <= _radius) then  { // clip Z
					_cellKey = _center vectorAdd _cellKey; 
					if (_cellKey isEqualTo _center) then {
						if (_includeCenter) then {_cells pushback _cellKey;}; // else dont include
					} else {_cells pushback _cellKey;};
				};
			};
		};

		_cells;
	}]
]