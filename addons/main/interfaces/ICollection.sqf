#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Interface: main. XPS_ifc_ICollection
<Interface>

Authors:
    Crashdome

	Property: AllowedTypes
	<Array>
	
	Property: Items
	<Hashmap>

	Method: RegisterType
	
	Method: AddItem

	Method: RemoveItem
---------------------------------------------------------------------------- */
[
	["AllowedTypes","ARRAY"],
	["Items","HASHMAP"],
	["RegisterType","CODE"],
	["AddItem","CODE"],
	["RemoveItem","CODE"]
]