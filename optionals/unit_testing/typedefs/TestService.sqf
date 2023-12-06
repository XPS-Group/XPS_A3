/* -----------------------------------------------------------------------------
TypeDef: unit_testing. XPS_UT_typ_TestService
	<TypeDefinition>
	---prototype
	XPS_UT_typ_TestService : XPS_ADDON_ifc_IName, XPS_typ_Name
	---
	---prototype
	createhashmapobject [XPS_UT_typ_TestService, []]
	---

Authors: 
	Crashdome

Description:

    
Optionals: 
	_var1* - <Object> - (Optional - Default : objNull) 
	_var2* - <String> - (Optional - Default : "") 

Returns:
	<HashmapObject>

--------------------------------------------------------------------------------*/
[
	["#type","XPS_UT_typ_TestService"],
	/*----------------------------------------------------------------------------
	Parent: #base
    	<XPS_typ_Name>
	-----------------------------------------------------------------------------*/
	// ["#base",XPS_typ_Name],
	/*----------------------------------------------------------------------------
	Constructor: #create
    
    	--- Prototype --- 
    	call ["create",[_var1*,_var2*]]
    	---
    
    Optionals: 
		_var1* - <Object> - (Optional - Default : objNull) 
    	_var2* - <String> - (Optional - Default : "") 

	Returns:
		<True>
	-----------------------------------------------------------------------------*/
	["#create",{
		diag_log "Creating Service";
		_self set ["_testClassCollection",createhashmapobject [XPS_typ_TypeCollection,
				createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_UT_typ_TestClass"]]]]];

		_self set ["_unitTestCollection",createhashmapobject [XPS_typ_TypeCollectionN,
				createhashmapobject [XPS_typ_HashmapObjectTypeRestrictor,[["XPS_UT_typ_UnitTest"]]]]];
		_self set ["CollectionChanged",(_self get "_unitTestCollection") get "CollectionChanged"];

	}],
	["#delete",{
		diag_log "Deleting Test Service";
	}],
	/*----------------------------------------------------------------------------
	Str: #str
    	--- text --- 
    	"XPS_UT_typ_TestService"
    	---
	-----------------------------------------------------------------------------*/
	["#str",{_self get "#type" select 0}],
	/*----------------------------------------------------------------------------
	Implements: @interfaces
    	<XPS_ADDON_ifc_IName>
	-----------------------------------------------------------------------------*/
	// ["@interfaces",["XPS_ADDON_ifc_IName"]],
	["_testClassCollection",nil],
	["_unitTestCollection",nil],
	/*----------------------------------------------------------------------------
	Protected: myProp
    
    	--- Prototype --- 
    	get "myProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	["updateItem",{
		params ["_classID","_args"];
		private _list = _self get "_unitTestCollection";
		_list call ["UpdateItem",_this];
	}],
	/*----------------------------------------------------------------------------
	Property: MyProp
    
    	--- Prototype --- 
    	get "MyProp"
    	---
    
    Returns: 
		<Object> - description
	-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------
	Method: MyMethod
    
    	--- Prototype --- 
    	call ["MyMethod",[_object*,_var1*]]
    	---
    
    Optionals: 
		_object* - <Object> - (Optional - Default : objNull) 
		_var1* - <String> - (Optional - Default : "") 
	-----------------------------------------------------------------------------*/
	["LoadTests",{
		private _classes = _self get "_testClassCollection";
		private _unitTests = _self get "_unitTestCollection";

		private _tests = XPS_UT_TestClasses call ["GetInstance"] call ["GetClasses"];
		{
			private _class = _x;
			private _className = _x get "Description";
			_classes call ["AddItem",[_className,_class]];
			_unitTests call ["AddItem",[[_className,""],createhashmapobject [XPS_UT_typ_UnitTest,[_className,""]]]];
			{
				_unitTests call ["AddItem",[[_className,_x],createhashmapobject [XPS_UT_typ_UnitTest,[_className,_x]]]];
			} foreach (_class get "TestOrder");
		} foreach _tests;
	}],
	["AddToSelected",{
		_self call ["updateItem",[_this,["IsSelected",true]]];
	}],
	["RemoveFromSelected",{
		_self call ["updateItem",[_this,["IsSelected",false]]];
	}],
	["RunAll",{}],
	["RunSelected",{}],
	["Reset",{
		_self get "_testClassCollection" call ["Clear"];
		_self get "_unitTestCollection" call ["Clear"];
		_self call ["LoadTests"];
	}],
	["CollectionChanged",nil]
]