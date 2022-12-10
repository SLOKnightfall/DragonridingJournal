local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local Rostrum =
{
	[2022] = --The Waking Shores
	{
		{name = "Rostrum of Transformation", achievementID = 0, x = .7403 , y = .5813,},

	},

	[2023] = --Ohn'Ahran Plains
	{
		{name = "Rostrum of Transformation",achievementID = 0, x = .8464 , y = .3555,},

	},

	[2024] = --Azure Span
	{
		{name = "Rostrum of Transformation", achievementID = 0, x = .6361 , y = .1321,},
	},
	
	[2025] = --Thaldraszus
	{
		{name = "Rostrum of Transformation", achievementID = 0, x = .2524 , y = .5033,},
	},
}

addon.Data.Rostrum = Rostrum