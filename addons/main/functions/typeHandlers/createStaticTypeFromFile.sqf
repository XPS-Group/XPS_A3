#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_createStaticTypeFromFile
	
	---prototype
	_result = [_varname, _filepath] call XPS_fnc_createStaticTypeFromFile
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

	Optional: _filepath
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

		createhashmapobject [_def];
    ---

	To create the Static object from above file:
	--- Code
		["MyStatic" , "File.sqf"] call XPS_fnc_createStaticTypeFromFile;
		MyStatic call ["Method"];
    ---

---------------------------------------------------------------------------- */
if !(params [["_varname",nil,[""]],["_filepath",nil,[""]]]) exitwith {false;};

private _statement = "%1 = compilefinal (call compileScript [""%2"",false]);";
private _code =  format[_statement, _varname, _filepath];

call compile _code;

true;
