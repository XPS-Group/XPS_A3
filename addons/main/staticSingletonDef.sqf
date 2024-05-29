// Used for static class to retrieve singletons ONLY
// expects '_instanceVar' variable within scope when called
createhashmapobject [[
	["#str",{(_self get "#type") select 0}],
	["#type","XPS_typ_StaticSingletonProvider"],
	["GetInstance",compile format["%1",_instanceVar]]
]];