
class XPS_CFG_TD_BASECLASSNAME {
	class ADDON {
		class Interfaces {
			XPS_CFG_IFC_SUB(base,INode);
		};

		class Enumerations {
			XPS_CFG_ENUM_SUB(base,NodeType);
		};

		class BaseNodes {
			XPS_CFG_TYP_SUB(base,Composite);
			XPS_CFG_TYP_SUB(base,Decorator);
			XPS_CFG_TYP_SUB(base,Leaf);
			XPS_CFG_TYP_SUB(base,LeafSAsync);
			XPS_CFG_TYP_SUB(base,LeafUAsync);
		};
		class VirtualNodes {
			XPS_CFG_TYP(Action);
			XPS_CFG_TYP(ActionSAsync);
			XPS_CFG_TYP(ActionUAsync);
			XPS_CFG_TYP(Condition);
			XPS_CFG_TYP(Elector);
			XPS_CFG_TYP(Inverter);
			XPS_CFG_TYP(Parallel);
			XPS_CFG_TYP(Selector);
			XPS_CFG_TYP(Sequence);
			XPS_CFG_TYP(SubTree);
		};		
	};
};
