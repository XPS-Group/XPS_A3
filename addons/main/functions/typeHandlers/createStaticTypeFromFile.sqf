#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_createStaticTypeFromFile
	
	---prototype
	_result = [_varname, _XPS_FILEPATH] call XPS_fnc_createStaticTypeFromFile
	---

Description:
    Reads a file containing a private Type Definition and returns a Read-Only <HashmapObject>.
	It then sets the current namespace variable name to the compileFinal'd <HashmapObject>
	so that only one ever exists and can never be altered.

	Files should return a <HashmapObject> and therefore XPS_fnc_buildTypeDefinition should be called
	manually in the SQF file before returning the result if needed.

Authors: 
	Crashdome

------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which the <HashmapObject> will be stored

	Optional: _XPS_FILEPATH
		<string> - the path to the file  

	Return: _result
		<Boolean> - <True> is successful, otherwise false

	
Example: File and calling code example

	File.sqf
	--- Code

		private _def = [ [ 
			["#type","Tag_typ_MyStaticClass"],
			["Method",  compileFinal { hint "Hello World!"}]
		] ,false,true,true] call XPS_fnc_buildTypeDefinition;

		createHashmapObject [_def];
    ---

	To create the Static object from above file:
	--- Code
		["MyStatic" , "File.sqf"] call XPS_fnc_createStaticTypeFromFile;
		MyStatic call ["Method"];
    ---

---------------------------------------------------------------------------- */
if !(params [["_varname",nil,[""]],["_XPS_FILEPATH",nil,[""]]]) exitWith {false;};

currentNamespace setVariable [_varname, compileFinal (call compileScript [_XPS_FILEPATH,false])];

