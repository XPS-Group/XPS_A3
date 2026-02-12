	/* ----------------------------------------------------------------------------
	Nested: Builder
			---prototype
			XPS_BT_typ_Elector.Builder : core.XPS_ifc_IBuilder, core.XPS_typ_Builder
			---

		Nested <TypeDefinition>
		
		In Type Definition Only

			--- Code --- 
			createHashmapObject [XPS_BT_typ_Elector get "Builder"]
			---
		
		Instance Methods: see <core. XPS_typ_Builder> for more

			--- Code --- 
			call ["New"]
			---

			--- Code --- 
			call ["WithCondition", _code]
			---

			--- Code --- 
			call ["Build"]
			---
	---------------------------------------------------------------------------- */
	["Builder",[
		
		["#type","XPS_BT_typ_Elector.Builder"],
		["#base",XPS_typ_Builder],
		["#create", compileFinal {
			_self call ["XPS_typ_Builder.#create",XPS_BT_typ_Elector];
		}],
		["New", compileFinal {
			_self call ["XPS_typ_Builder.New",XPS_BT_typ_Elector];
		}],
		["WithCondition", compileFinal {_self get "typeDef" set ["Condition", compileFinal _this]; _self;}]
	],[["NESTED_TYPE"],["IN_TYPE_ONLY"]]]
