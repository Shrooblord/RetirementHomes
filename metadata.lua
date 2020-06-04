return PlaceObj('ModDef', {
	'title', "RetirementHomes",
	'description', 'Adds a button to Residential Buildings and Domes that marks them as "Retirement Homes". Seniors (who are outside the workforce) have priority on living there, and even kick non-Seniors out of their home so they can live there instead.\n\nThis allows you to force-allocate non-working citizens to separate Domes, so you can have, for example, a "work district" and a "leisure district", where people can enjoy the twilight of their days outside of the busy bustle of young people going about their work.\n\nYou can toggle between macro-setting an entire Dome as an RH, or micro-manage individual Residential Buildings:\n- Set a Dome to be an RH, and Seniors will have priority over any Resident within that Dome (including Arcology Spires; excluding kids in Nurseries), and even shunt out non-Seniors to make space for them.\n- Set a Residential Building to be an RH, and only that specific Building will be added to the list of possible places for these Seniors to move with priority (and evict others from).\n\nThere is also the setting "Workhouse" for the button, which effectively functions in exactly the opposite way: Seniors are evicted from this Residential Building (or from *any* Residential Building within this Dome) if a non-Senior is looking for a place to live. This includes Children not housed by Nurseries!\n\nFor clarity, the button is a toggle-switch between the states "Normal Residence" (no change from Vanilla behaviour), "Retirement Home", and "Workhouse".\n\nP.S.\nDependent on ChoCGi\'s *excellent* library full of excellent utility functions. Why re-invent the wheel? Especially if you\'re looking at an expert carpenter\'s work...',
	'dependencies', {
		PlaceObj('ModDependency', {
			'id', "ChoGGi_Library",
			'title', "ChoGGi's Library",
			'version_major', 8,
			'version_minor', 2,
		}),
	},
	'id', "cWiQKJY",
	'pops_desktop_uuid', "e058a5d2-c46d-460d-a569-36b9e0ab04c5",
	'pops_any_uuid', "caf3ad21-6e4c-4e73-9674-cccdf2748baa",
	'author', "Shrooblord",
	'version', 6,
	'lua_revision', 233360,
	'saved_with_revision', 249143,
	'code', {
		"Code/MigrateOldFogies.lua",
	},
	'saved', 1591276297,
})