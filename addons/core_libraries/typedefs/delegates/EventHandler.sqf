#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_EventHandler
	<TypeDefinition>
        --- prototype
        XPS_typ_EventHandler : XPS_ifc_IEventHandler
        ---
        --- prototype
        createhashmapobject [XPS_typ_EventHandler,_signature]
        ---

Authors: 
	Crashdome
   
Description:
	<HashmapObject> which stores pointers to another function/method and calls them when invoked

Parameters: 
	_signature - (optional - Default: Anything) - a definition of parameters expected when calling "Invoke" method: in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
	
	This signature is strictly checked when Invoke is called and  will fail if parameters passed are not correct. This ensures a standard
	parameter set is expected by all receivers of the Invoke method. Since default is 'anything' all parameter compositions are initially allowed.

	However, a custom signature can be injected at creation or overridden by a derived class. See Example below.

Returns:
	<HashmapObject>

---------------------------------------------------------------------------- */
[
	["#type","XPS_typ_EventHandler"],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create",_signature]
        ---
    
    Parameters: 
        _signature - (optional - Default: Anything) - a definition of parameters expected when calling "Invoke" method: in the same format as the IsEqualTypeParams command - i.e. ["",[],objNull,0]
	
	Returns:
		True
    ----------------------------------------------------------------------------*/
	["#create",{
		params [["_mcDelegate",nil,[createhashmap]]];
		if (isNil "_mcDelegate" || {!(CHECK_IFC1(_mcDelegate,"XPS_if_IMultiCastDelegate"))}) then 
		{
			_self set ["_delegate",_mcDelegate];
		};
	}],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_Delegate"
		---
	----------------------------------------------------------------------------*/
	["#str",compilefinal {_self get "#type" select  0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_IEventHandler>
	----------------------------------------------------------------------------*/
	["@interfaces",["XPS_ifc_IEventHandler"]],
	["_delegate",nil],
    /*----------------------------------------------------------------------------
    Method: Add
    
        --- Prototype --- 
        call ["Add",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Adds a function/method pointer to the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Example Using Code:
		--- code 
        call ["Add",{ hint "Hello";}]
		---
		Example Using <HashmapObject> Method:
		--- code 
        call ["Add",[_hashmapobject, "MyMethodName"]]
		---
		
	Returns:
		True - if added

	Throws: 
		<XPS_typ_ArgumentNilException> - when parameter supplied is Nil value
		<XPS_typ_InvalidArgumentException> - when parameter supplied does not conform to the above
		<XPS_typ_InvalidArgumentException> - when parameter supplied was already added
    ----------------------------------------------------------------------------*/
	["Add",{
		_delegate call ["Add",_this];
	}],
    /*----------------------------------------------------------------------------
    Method: Remove
    
        --- Prototype --- 
        call ["Remove",_pointer]
        ---

        <XPS_ifc_IEventHandler>

		Removes a function/method pointer from the internal pointer collection
    
    Parameters: 
        _pointer - <Array> in format [<HashMapObject>,"MethodName"] -OR- <Code>

		Must be exactly the same as what was added.

	Returns:
		Deleted element or nothing if not found
    ----------------------------------------------------------------------------*/
	["Remove",{
		_delegate call ["Remove",_this];
	}]
]