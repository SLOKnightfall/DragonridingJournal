local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local glyphs =
{
	[2022] = --The Waking Shores
	{
		{name = "Crumbling Life Archway", achievementID = 15991, x = .577, y = .553,},
		{name = "Dragonheart Outpost", achievementID = 16051, x = .698, y = .462,},
		{name = "Flashfrost Enclave", achievementID = 16669, x = .581, y = .787,},
		{name = "Life-Binder Observatory", achievementID = 15990, x = .526, y = .170,},
		{name = "Obsidian Bulwark", achievementID = 15987, x = .409, y = .719,},
		{name = "Obsidian Throne", achievementID = 16053, x = .217, y = .514, },
		{name = "Overflowing Spring", achievementID = 15989, x = .464, y = .521,},
        {name = "Ruby Life Pools", achievementID = 15988, x = .545, y = .741,},
	    {name = "Rubyscale Outpost", achievementID = 16670, x = .487, y = .867,},
		{name = "Scalecracker Peak", achievementID = 16052, x = .732, y = .202,},
		{name = "Skytop Rostrum", achievementID = 16668, x = .742, y = .575,},
		{name = "Skytop Tower", achievementID = 15985, x = .751, y = .567,},
		{name = "Wingrest Embassy", achievementID = 15986, x = .748, y = .373,},
	},

	[2023] = --Ohn'Ahran Plains
	{
		{name = "Dragonsprings Summit", achievementID = 16061, x = .842, y = .775,},
		{name = "Emerald Gardens", achievementID = 16056, x = .300, y = .612,},
		{name = "Eternal Kurgans", achievementID = 16057, x = .293, y = .745,},
		{name = "Forkriver Crossing", achievementID = 16672, x = .701, y = .866, },
		{name = "Mirewood Fen", achievementID = 16671, x = .784, y = .214,},
		{name = "Mirror of the Sky", achievementID = 16059, x = .472, y = .723,},
		{name = "Nokhudon Hold", achievementID = 16055, x = .307, y = .361,},
		{name = "Ohn'ahra Roost", achievementID = 16054, x = .579, y = .312,},
		{name = "Ohn'iri Springs", achievementID = 16060, x = .571, y = .801,},
		{name = "Rusza'Thar Reach", achievementID = 16062, x = .865, y = .394,},
		{name = "Szar Skeleth", achievementID = 16058, x = .445, y = .649,},
		{name = "Windsong Rise", achievementID = 16063, x = .615, y = .644,},
	},

	[2024] = --Azure Span
	{
		{name = "Azure Archive", achievementID = 16065, x = .393, y = .630,},
		{name = "Brackenhide Hollow", achievementID = 16068, x = .106, y = .357,},
		{name = "Cobalt Assembly", achievementID = 16064, x = .458, y = .260,},
		{name = "Creektooth Den", achievementID = 16069, x = .267, y = .316,},
		{name = "Fallen Course", achievementID = 16673, x = .567, y = .160, },
		{name = "Imbu", achievementID = 16070, x = .606, y = .700,},
		{name = "Kalthraz Fortress", achievementID = 16072, x = .676, y = .291,},
		{name = "Lost Ruins", achievementID = 16067, x = .705, y = .462,},
		{name = "Ruins of Karnthar", achievementID = 16066, x = .686, y = .603,},
		{name = "Vakthros Range", achievementID = 16073, x = .725, y = .394, },
		{name = "Zelthrak Outpost", achievementID = 16071, x = .528, y = .488,},
	},

	[2025] = --Thaldraszus
	{

		{name = "Algeth'Ar Academy", achievementID = 16104, x = .624, y = .404,},
		{name = "Algeth'Era", achievementID = 16102, x = .499, y = .403,},
		{name = "Gelikyr Overlook", achievementID = 16666, x = .527, y = .674,},
		{name = "Passage of Time", achievementID = 16667, x = .556, y = .721,},
		{name = "South Hold Gate", achievementID = 16100, x = .355, y = .855,},
		{name = "Stormshroud Peak", achievementID = 16099, x = .460, y = .740,},
		{name = "Temporal Conflux", achievementID = 16098, x = .660, y = .823,},
		{name = "Thaldraszus Apex", achievementID = 16107, x = .729, y = .692,},
		{name = "Tyrhold", achievementID = 16103, x = .615, y = .566,},
		{name = "Valdrakken", achievementID = 16101, x = .412, y = .581,},
		{name = "Vault of the Incarnates", achievementID = 16106, x = .723, y = .514,},
		{name = "Veiled Ossuary", achievementID = 16105, x = .670, y = .117,},

	},
}

addon.Data.glyphs = glyphs