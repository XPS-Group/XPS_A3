#include "script_component.hpp"
/* -----------------------------------------------------------------------------
TypeDef: map_grids. XPS_MG_typ_SquareGrid
	<TypeDefinition>
	---prototype
	XPS_MG_typ_SquareGrid : XPS_MG_ifc_IGrid
	---
	---prototype
	XPS_MG_typ_SquareGrid
	---

Authors: 
	Crashdome

Description:
	Static Methods for calculating indices along a square grid independant of
	size.
--------------------------------------------------------------------------------*/
[
	["#type","XPS_MG_typ_SquareGrid"],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_MG_typ_SquareGrid"
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
		_cellkey - <Array> - 2-dimensional array of a square index position - (e.g. [10,4]) 
		_size - <Number> - the internal radius size of the square   

	Returns:
		_pos - <Array> - 2-dimensional array of world position 

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GetPositionByIndex",{
		if !(params [["_cellKey",[0,0],[[]],[2]],["_size",0,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetPositionByIndex",nil,_this]];};

		private _x = _size * (_cellKey#0);
		private _y = _size * (_cellKey#1);

		[_x,_y]
	}],
	/*----------------------------------------------------------------------------
	Method: GetIndexByPosition
    
    	--- Prototype --- 
    	call ["GetIndexByPosition",[_pos, _size]]
    	---
    
    	<XPS_MG_ifc_IGrid>
    
    Paramters: 
		_pos - <object> or <Array> - object with a world position -OR- 2 or 3-dimensional array of world position 
		_size - <Number> - the internal radius size of the square  

	Returns:
		_cellkey - <Array> - 2-dimensional array of a square index position - (e.g. [10,4]) 

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

		private _xkey = (_pos #0) / (_size); 
		private _ykey = (_pos #1) / (_size); 
		
		[_xKey,_yKey]
	}],
	/*----------------------------------------------------------------------------
	Method: GetNearbyIndexes
    
    	--- Prototype --- 
    	call ["GetIndexByPosition",[_center, _radius, _includeCenter*]]
    	---
    
    	<XPS_MG_ifc_IGrid>
    
	Paramters: 
		_center - <Array> - 2-dimensional index of the cell in which to start (index - NOT world position) 
		_radius - <Number> - the number of squares to include in terms of radius (in cells)

    Optionals:
		_includeCenter - <Boolean> - (Default: false) Set <True> to include the center hex in results

	Returns:
		_hexes - <Array> - an array of indices of the squares within the radius supplied (roughly circle shaped)

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GetNearbyIndexes",{
		if !(params [["_center",[0,0],[[]],[2]], ["_radius",0,[0]], "_includecenter"]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GetNearbyIndexes",nil,_this]];};
		if (isNil "_includeCenter" || {!(_includeCenter isEqualType true)}) then {_includeCenter = false};

		private _cells = [];
        private _maxDistance = _radius*_radius;
		for "_x" from -_radius to _radius do {
			for "_y" from -_radius to _radius do {
                private _distance = (_x*_x) + (_y*_y);

				if (_distance <= _maxDistance) then  { // clip 
					private _cellKey = _center vectorAdd [_x,_y]; 
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
    	call ["GenerateGrid",[_sizeSqr,_sizeWorld*]]
    	---
    
    	<XPS_MG_ifc_IGrid>
    
	Paramters: 
		_sizeSqr - <Number> - width of square from center point to center of flat edge in world units

    Optionals:
		_sizeWorld - <Number> - (Default: worldsize) - width (and height) of the grid in world units

	Returns:
		_array - <Array> - a multidimensional array composed of two elements: [indexes,positions]

		- indexes - <Array> - an array of 2d arrays for indexed position
		- positions - <Array> - an array of 2d arrays for world position

    Throws:
        <XPS_typ_ArgumentNilException> - if parameter was nil
	-----------------------------------------------------------------------------*/
	["GenerateGrid",{
		if !(params [["_sizeSqr",0,[0]],["_sizeWorld",worldsize,[0]]]) exitwith {throw createhashmapobject [XPS_typ_ArgumentNilException,[_self,"GenerateGrid",nil,_this]];};

		private _indexArray = [];
		private _posArray = [];

		private _xkey = 0;
		private _ykey = 0;
		private _x = 0;
		private _y = 0;
		private _increase = (2 * _sizeSqr);

		while {_y < _sizeWorld} do {
			while {_x < _sizeWorld} do {

				_indexArray pushback [_xkey, _ykey];
				 _posArray pushback [_x, _y];

				_x = _x + _increase;
				_xkey = _xkey + 1;
			};
			_x = 0;
			_y = _y + _increase;
			_ykey = _ykey + 1;
		};

		// Row_Length = Column_Height = round(worldSize / (2 * _sizeSqr));

		[_indexarray,_posArray];
	}]
]