#include "script_component.hpp"
/* ----------------------------------------------------------------------------
TypeDef: core. XPS_typ_TypeCollectionN
	<TypeDefinition>
        --- prototype
        XPS_typ_TypeCollectionN : XPS_ifc_ICollection, XPS_ifc_ITypeRestrictor, XPS_ifc_ICollectionNotifier, XPS_typ_TypeCollection
        ---
        --- prototype
        createHashmapObject [XPS_typ_TypeCollection,[_typeRestrictor]]
        ---

Authors: 
	Crashdome
   
Description:
<HashmapObject> which stores items only if the type is allowed. Implements CollectionChanged Event handler.

Parameters: 
    _typeRestrictor (optional) - <HashmapObject> that implements <XPS_ifc_ITypeRestrictor> 

Returns:
    <HashmapObject>
---------------------------------------------------------------------------- */
[
	["#type", "XPS_typ_TypeCollectionN"],
    /*----------------------------------------------------------------------------
    Parent: #base
        <XPS_typ_TypeCollection>
    ----------------------------------------------------------------------------*/    
    ["#base",XPS_typ_TypeCollection],
    /*----------------------------------------------------------------------------
    Constructor: #create
    
        --- prototype
        call ["#create"]
        ---
    
    Return:
        <True>
    ----------------------------------------------------------------------------*/
    ["#create", compileFinal {
        _self call ["XPS_typ_TypeCollection.#create",_this];
        _self set ["_onCollectionChangedEvent",createHashmapObject [XPS_typ_Event]];
        _self set ["CollectionChanged",createHashmapObject [XPS_typ_EventHandler,[_self get "_onCollectionChangedEvent"]]];
    }],
	/*----------------------------------------------------------------------------
	Str: #str
		--- prototype
		"XPS_typ_TypeCollectionN"
		---
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Flags: #flags
		sealed
		unscheduled
	----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Implements: @interfaces
		<XPS_ifc_ICollection>
        <XPS_ifc_ICollectionNotifier>
	----------------------------------------------------------------------------*/
    ["@interfaces", ["XPS_ifc_ICollectionNotifier"]],
    ["_onCollectionChangedEvent",nil],
    /*----------------------------------------------------------------------------
    Method: Clear
        <XPS_typ_TypeCollection.Clear>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: Count
        <XPS_typ_TypeCollection.Count>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: IsEmpty
        <XPS_typ_TypeCollection.IsEmpty>
    ----------------------------------------------------------------------------*/
    /*----------------------------------------------------------------------------
    Method: AddItem
        <XPS_typ_TypeCollection.AddItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["AddItem", compileFinal {
        private _key = _self call ["XPS_typ_TypeCollection.AddItem",_this];
        _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["AddItem",_this]]];
        _key;
    }],
    /*----------------------------------------------------------------------------
    Method: RemoveItem
        <XPS_typ_TypeCollection.RemoveItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["RemoveItem",compileFinal {
        private _item = _self call ["XPS_typ_TypeCollection.RemoveItem",_this];
        if !(isNil "_item") then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["RemoveItem",[_this,_item]]]];
        };
        _item;
    }],
    /*----------------------------------------------------------------------------
    Method: GetItem
        <XPS_typ_TypeCollection.GetItem>
    ----------------------------------------------------------------------------*/

    /* -----------------------------------------------------------------------
    Method: GetItems
        <XPS_typ_TypeCollection.GetItems>
    -------------------------------------------------------------------------*/ 
    /*----------------------------------------------------------------------------
    Method: SetItem
        <XPS_typ_TypeCollection.SetItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["SetItem", compileFinal {
        if (_self call ["XPS_typ_TypeCollection.SetItem",_this]) then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["SetItem",_this]]];
            true;
        } else {false};
	}],
    /*----------------------------------------------------------------------------
    Method: UpdateItem
        <XPS_typ_OrderedCollection.UpdateItem>
        Invokes CollectionChanged
    ----------------------------------------------------------------------------*/
	["UpdateItem", compileFinal {
        if (_self call ["XPS_typ_TypeCollection.UpdateItem",_this]) then {
            _self get "_onCollectionChangedEvent" call ["Invoke",[_self,["UpdateItem",_this]]];
            true;
        } else {false};
	}],
    /*----------------------------------------------------------------------------
    EventHandler: CollectionChanged
    
        --- Prototype --- 
        get "CollectionChanged"
        ---

        <XPS_ifc_ICollectionNotifier>

        Handles Subscriptions to the onCollectionChangedEvent

    Returns:
        <XPS_typ_EventHandler>
    ----------------------------------------------------------------------------*/
    ["CollectionChanged",nil]
]