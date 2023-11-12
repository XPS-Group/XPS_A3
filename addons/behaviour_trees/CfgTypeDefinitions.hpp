
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		XPS_CFG_IFC(INode);

		XPS_CFG_ENUM(Result);

		XPS_CFG_TYP_SUB(base,Composite);
		XPS_CFG_TYP_SUB(base,Decorator);
		XPS_CFG_TYP_SUB(base,Leaf);
		XPS_CFG_TYP_SUB(base,LeafAsync);

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