#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: core. XPS_ifc_IException
<Interface>

Authors:
    Crashdome
----------------------------------------------------------------------------

	Property: ExceptionType
		<String>
		
	Property: Source 
		Anything

	Property: Target
		Anything

	Property: Message
		<String>

	Property: Data
		<Hashmap>

	Property: GetText
		<Code>

---------------------------------------------------------------------------- */
[
	["ExceptionType","STRING"],
	["Source","ANYTING"],
	["Target","ANYTHING"],
	["Message","STRING"],
	["Data","HASHMAP"],
	["GetText","CODE"]
]