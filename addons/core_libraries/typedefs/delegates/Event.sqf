#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_Event
	<TypeDefinition>
        --- prototype
        XPS_typ_Event : XPS_ifc_IDelegate, XPS_typ_MultiCastDelegate
        ---
        --- prototype
        createHashmapObject [XPS_typ_Event]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores pointers to another function/method and calls them when invoked.

	The signature of the Invoke method is set as [sender: <HashmapObject> , args: <Array>]

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_Event"],
    /*----------------------------------------------------------------------------
    Parent: #base 
		<XPS_typ_MultiCastDelegate>
    ----------------------------------------------------------------------------*/
	["#base", XPS_typ_MultiCastDelegate],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---

	Returns:
		<True>
    ----------------------------------------------------------------------------*/
	["#create", compileFinal {
		_self call ["XPS_typ_MultiCastDelegate.#create",[createhashmap,[]]];
	}]
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Event"
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IDelegate>
	----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Subscribe
		<XPS_typ_MultiCastDelegate.Subscribe>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Unsubscribe
		<XPS_typ_MultiCastDelegate.Unsubscribe>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Invoke
		<XPS_typ_MultiCastDelegate.Invoke>
    ----------------------------------------------------------------------------*/
]
