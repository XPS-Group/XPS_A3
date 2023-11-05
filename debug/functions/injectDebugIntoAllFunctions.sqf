{
	with (_x) do {
		{
			if (_x isEqualType {}) then (_x = call compile ((str _x) insert [1,XPS_DebugHeader_FNC]));
		} foreach (allvariables _x);
	}
} foreach [missionNamespace, uiNamespace];