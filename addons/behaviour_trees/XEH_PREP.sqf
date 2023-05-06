// All functions in root folder or subfolder of root
//PREP(myFunction);
//SUBPREP(sub,myFunction)

// All functions in a folder called 'functions'
//PREP_F(sub,myFunction);
//SUBPREP_F(sub,myFunction);


PREP_IFC(INode);

SUBPREP_TYP(virtual,Composite);
SUBPREP_TYP(virtual,Decorator);
SUBPREP_TYP(virtual,Leaf);
SUBPREP_TYP(virtual,LeafAsync);

SUBPREP_TYP(base,Action);
SUBPREP_TYP(base,ActionAsync);
SUBPREP_TYP(base,Condition);
SUBPREP_TYP(base,Inverter);
SUBPREP_TYP(base,Parallel);
SUBPREP_TYP(base,Selector);
SUBPREP_TYP(base,Sequence);
SUBPREP_TYP(base,SubTree);
