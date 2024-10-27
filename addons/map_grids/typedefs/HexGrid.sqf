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
	size. Hexagonal grid uses pointy-top formulas (vs flat-top)
--------------------------------------------------------------------------------*/
[
	["#type","XPS_MG_typ_HexGrid"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_MG_typ_HexGrid"
    	---
	-----------------------------------------------------------------------------*/
	["#str", compileFinal {_self get "#type" select 0}],
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
	["GetPositionByIndex", compileFinal {
		if !(params [["_cellKey",[0,0,0],[[]],[3]],["_size",0,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetPositionByIndex",nil,createhashmapfromarray [["_this",_this]]]];};

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
	["GetIndexByPosition", compileFinal {
		if !(params [["_position",[100,100],[[],objnull],[2,3]],["_size",nil,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetIndexByPosition",nil,createhashmapfromarray [["_this",_this]]]];};

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
	["GetNearbyIndexes", compileFinal {
		if !(params [["_center",[0,0,0],[[]],[3]], ["_radius",0,[0]], "_includecenter"]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetNearbyIndexes",nil,createhashmapfromarray [["_this",_this]]]];};
		if (isNil "_includeCenter" || {!(_includeCenter isEqualType true)}) then {_includeCenter = false};

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
	}],
	/*----------------------------------------------------------------------------
	Method: GenerateGrid
    
    	--- Prototype --- 
    	call ["GenerateGrid",[_sizeHex,_sizeWorld*]]
    	---
    
    	<XPS_MG_ifc_IGrid>
    
	Paramters: 
		_sizeHex - <Number> - width of hex from center point to center of flat edge in world units

    Optionals:
		_sizeWorld - <Number> - (Default: worldsize) - width (and height) of the hex grid in world units

	Returns:
		_array - <Array> - a multidimensional array composed of two elements: [indexes,positions]

		- indexes - <Array> - an array of 3d arrays for indexed position
		- positions - <Array> - an array of 2d arrays for world position

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GenerateGrid", compileFinal {
		if !(params [["_sizeHex",0,[0]],["_sizeWorld",worldsize,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GenerateGrid",nil,createhashmapfromarray [["_this",_this]]]];};

		private _indexArray = [];
		private _posArray = [];
		private _sqrtThree = sqrt(3);
		private _yIncrease = 1.5 * _sizeHex;

		private _xStart = 0;
		private _xkey = 0;
		private _ykey = 0;
		private _zkey = 0;
		private _x = 0;
		private _y = 0;
		private _offset = true;

		while {_y < _sizeWorld} do {
			_xKey = _xStart;
			while {_x < _sizeWorld} do {
				_zKey = 0-_xKey-_yKey;

				_indexArray pushback [_xkey, _ykey,_zKey];
				 _posArray pushback [_x, _y];

				_x = _x + (_sqrtThree * _sizeHex);
				_xkey = _xkey + 1;
			};
			if (_offset) then {
				_x = _sqrtThree * _sizeHex / 2; 
				_xStart = _xStart + 1;
				_ykey = _ykey - 1;
			} else {
				_x = 0;
				_ykey = _ykey - 1;
			};
			_y = _y + _yIncrease;
			_offset = !_offset;
		};

		// Row_Length = ceil(worldSize / (_sqrtThree * _sizeHex));
		// Column_Height = ceil(worldSize / _yIncrease);

		[_indexarray,_posArray]
	}]
]