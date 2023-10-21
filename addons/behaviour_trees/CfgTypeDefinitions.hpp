class XPS_CFG_BASECLASSNAME {
	class ADDON {				
		XPS_CFG_IFC(INode);

		XPS_CFG_TYP_SUB(virtual,Composite);
		XPS_CFG_TYP_SUB(virtual,Decorator);
		XPS_CFG_TYP_SUB(virtual,Leaf);
		XPS_CFG_TYP_SUB(virtual,LeafAsync);

		XPS_CFG_TYP(Action);
		XPS_CFG_TYP(ActionAsync);
		XPS_CFG_TYP(Condition);
		XPS_CFG_TYP(Inverter);
		XPS_CFG_TYP(Parallel);
		XPS_CFG_TYP(Selector);
		XPS_CFG_TYP(Sequence);
		XPS_CFG_TYP(SubTree);
	};
};