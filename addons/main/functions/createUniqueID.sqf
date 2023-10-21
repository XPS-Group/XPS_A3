#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. XPS_fnc_createUniqueID

    --- prototype
    _result = call XPS_fnc_creaeteUniqueID
    ---

    --- prototype
    _result = [_length, _chars] call XPS_fnc_creaeteUniqueID
    ---

Description:
    Create and return a new Unique ID in string format. This is _not_ a UUID based on standards.
    It is simply taking a random character from a desired string of characters and appending 
    it to a length desired.

    To prevent possible collisions when generating IDs, you can increase length or the chars 
    chosen to decrease probability. In my tests in Arma 3, a length of 8 from the default 16 char
    string produced about a 0.05% chance of collision - or about 500 for every 1,000,000. 
    
    Here are some additional tests to help you decide what you need:
    --- text
    Length  # of Chars  Probability of collision    In context
    8       16          0.05%                       About 500 in 1,000,000
    10      16          0.0004%                     About 4 in 1,000,000
    12      16          virtually none 

    4       32          ~35%                        About 35,000 in 1,000,000
    6       32          0.028%                      About 288 in 1,000,000
    8       32          virtually none 

    4       64          ~30%                        About 30,000 in 1,000,000
    5       64          0.05%                       About 500 in 1,000,000
    6       64          virtually none
    ---
    Sometimes you need to keep the ID short. In that case, increase characters and reduce to 
    desired length.

    Sometimes a short ID prepended or appended to something else that might be unique will reduce 
    collision probability also. 

    For Example: Tank_4f56a23e  might be fine if you only intend to have about 10 to 100 "Tank" names.

Authors: 
	Crashdome
----------------------------------------------------------------------------


Optional: _length 
    <Number> - desired length of the ID in chars - Default of 12 (total 12 chars) 

Optional: _chars 
    <String> - string of the possible chars to form the ID - Default ["01234567890abcdef"]
		
        * Note: chars can include a character more than once to increase odds of that character

Returns: _result
    <String> 

Example: Default
    --- Code
    _myUniqueID = call XPS_fnc_createUniqueID; // might return something like "0a74fbc8d5e1"
    ---

Example: Using both Optionals
    --- Code
    _myUniqueID = [5,"01"] call XPS_fnc_createUniqueID; // might return something like "01001"
    ---

Example: Using both Optionals 2
    --- Code
    _myUniqueID = [10,"abcdefghijklmnopqrstuvwxyz"] call XPS_fnc_createUniqueID; // might return something like "iosmfhxrslio"
    ---

---------------------------------------------------------------------------- */

params [["_length", 12, [0]],["_chars","01234567890abcdef",[""]]];

_charArray = _chars splitstring "";
_uniqueID = ""; 

for "_a" from 0 to (_length-1) do { 
	_uniqueID = _uniqueID + (selectrandom _charArray); 
}; 

_uniqueID;
