class XPS_Type_Definitions {
	class ADDON {				
		XPS_CFG_IFC(ADDON,INode);

		XPS_CFG_TYP_SUB(ADDON,virtual,Composite);
		XPS_CFG_TYP_SUB(ADDON,virtual,Decorator);
		XPS_CFG_TYP_SUB(ADDON,virtual,Leaf);
		XPS_CFG_TYP_SUB(ADDON,virtual,LeafAsync);

		XPS_CFG_TYP_SUB(ADDON,base,Action);
		XPS_CFG_TYP_SUB(ADDON,base,ActionAsync);
		XPS_CFG_TYP_SUB(ADDON,base,Condition);
		XPS_CFG_TYP_SUB(ADDON,base,Inverter);
		XPS_CFG_TYP_SUB(ADDON,base,Parallel);
		XPS_CFG_TYP_SUB(ADDON,base,Selector);
		XPS_CFG_TYP_SUB(ADDON,base,Sequence);
		XPS_CFG_TYP_SUB(ADDON,base,SubTree);
	};
};