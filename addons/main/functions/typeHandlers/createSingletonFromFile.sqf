#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: main. typeHandlers. XPS_fnc_createSingletonFromFile
	
	---prototype
	_result = [_varname, _filepath] call XPS_fnccreateSingletonFromFile
	---

Description:
    Reads a file containing a private Type Definition and returns a <HashmapObject>.
	It then sets the missionNamespace variable name to a compileFinal'd <HashmapObject>
	so that only one ever exists.

	File should return a <HashmapObject> and XPS_fnc_buildTypeDefintion should be called
	manually in SQF file if needed.

	The type definition should also include the NoCopy and Sealed flags as needed.

Example: File and calling code example

	File.sqf
	--- Code

		private _def = [ [ 
			["#type","Tag_typ_MySingleton"],
			["#flags",["sealed","nocopy","unscheduled"]],
			["Method", { hint "Hello World!"}]
		] ,false,true,true] call XPS_fnc_buildTypeDefinition;

		createhashmapobject [_def];
    ---

	To create the Singleton from above file:
	--- Code
		["MySingleton" , "File.sqf"] call XPS_fnc_createSingletonFromFile;
		MySingleton call ["Method"];
    ---

Authors: 
	Crashdome
------------------------------------------------------------------------------

	Parameter: _varname
		<string> - the variable in which the <HashmapObject> will be stored

	Optional: _filepath
		<string> - the path to the file  

	Return: _result
		<Boolean> - True is successful, otherwise false

---------------------------------------------------------------------------- */
if !(params [["_varname",nil,[""]],["_filepath",nil,[""]]]) exitwith {false;};

private _statement = "%1 = compilefinal (call compileScript [""%2"",false]);";
private _code =  format[_statement, _varname, _filepath];

call compile _code;

true;
