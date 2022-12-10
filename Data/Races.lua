local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local races = {
	[2022] = --The Waking Shores
	{
		{name = "Apex Canopy River Run", quest = 66732, av_quest = 66733, achievementID = {bronze = 15730 , silver = 15731, gold = 15732, av_bronze = 15733, av_silver = 15734, av_gold = 15735}, x = .232, y = .842, silver = "56.00", gold = "53.00", av_silver = "48.00", av_gold = "45.00"},
		{name = "Emberflow Flight", quest = 66727, av_quest = 66728, achievementID = {bronze = 15724 , silver = 15725, gold = 15726, av_bronze = 15727, av_silver = 15728, av_gold = 15729}, x = .419, y = .673, silver = "53.00", gold = "50.00", av_silver = "47.00", av_gold = "44.00"},
		{name = "Flashfrost Flyover", quest = 66710, av_quest = 66712, achievementID = {bronze = 15705 , silver = 15706, gold = 15707, av_bronze = 15709, av_silver = 15710, av_gold = 15711}, x = .627, y = .740, silver = "66.00", gold = "63.00", av_silver = "64.00", av_gold = "61.00"},
		{name = "Ruby Lifeshrine Loop", quest = 66679, av_quest = 66692, achievementID = {bronze = 15696 , silver = 15697, gold = 15698, av_bronze = 15702, av_silver = 15703, av_gold = 15704}, x = .632, y =  .708, silver = "56.00", gold = "53.00", av_silver = "55.00", av_gold = "52.00"},
		{name = "Uktulut Coaster", quest = 66777, av_quest = 66778, achievementID = {bronze = 15736 , silver = 15737, gold = 15738, av_bronze = 15739, av_silver = 15740, av_gold = 15741}, x = .554, y = .411, silver = "48.00", gold = "45.00", av_silver = "43.00", av_gold = "40.00"},
		{name = "Wild Preserve Circuit", quest = 66710, av_quest = 66726, achievementID = {bronze = 15718 , silver = 15719, gold = 15720, av_bronze = 15721, av_silver = 15722, av_gold = 15723}, x = .426, y = .949, silver = "43.00", gold = "40.00", av_silver = "41.00", av_gold = "38.00"},
		{name = "Wild Preserve Slalom", quest = 66721, av_quest = 66722, achievementID = {bronze = 15712 , silver = 15713, gold = 15714, av_bronze = 15715, av_silver = 15716, av_gold = 15717}, x = .470, y = .855, silver = "45.00", gold = "42.00", av_silver = "43.00", av_gold = "40.00"},
	}, 

	[2023] = --Ohn'Ahran Plains
	{
		{name = "Emerald Garden Ascent", quest = 66885, av_quest = 66886, achievementID = {bronze = 15777 , silver = 15777, gold = 15777, av_bronze = 15778, av_silver = 15779, av_gold = 15780}, x = .257, y = .550, silver = "66.00", gold = "63.00", av_silver = "59.00", av_gold = "56.00"},
		{name = "Fen Flythrough", quest = 66877, av_quest = 66878, achievementID = {bronze = 15763 , silver = 15764, gold = 15765, av_bronze = 15766, av_silver = 15767, av_gold = 15768}, x = .862, y = .358, silver = "51.00", gold = "48.00", av_silver = "44.00", av_gold ="41.00"},
		{name = "Maruukai Dash", quest = 66921, av_quest = 0, achievementID = {bronze = 15782 , silver = 15783, gold = 15784, av_bronze = 0, av_silver = 0, av_gold = 0}, x = .595, y = .355, silver = "28.00", gold = "25.00", av_silver = nil, av_gold = nil},
		{name = "Mirror of the Sky Dash", quest = 66933, av_quest = 0, achievementID ={bronze = 15785 , silver = 15786, gold = 15787, av_bronze = 0, av_silver = 0, av_gold = 0}, x = .474, y = .706, silver = "29.00", gold = "26.00", av_silver = nil, av_gold = nil},
		{name = "Ravine River Run", quest = 66880, av_quest = 66881, achievementID = {bronze = 15769 , silver = 15770, gold = 15771, av_bronze = 15772, av_silver = 15773, av_gold = 15774}, x = .808 , y = .721,  silver = "52.00", gold = "49.00", av_silver = "50.00", av_gold = "47.00"},
		{name = "River Rapids Route", quest = 70710, av_quest = 70711, achievementID = {bronze = 16302 , silver = 16303, gold = 16304, av_bronze = 16305, av_silver = 16306, av_gold = 16307}, x = .437, y = .668, silver = "51.00", gold = "48.00", av_silver = "46.00", av_gold = "43.00"},
		{name = "Sundapple Copse Circuit", quest = 66835, av_quest = 66836, achievementID = {bronze = 15757 , silver = 15758, gold = 15759, av_bronze = 15760, av_silver = 15761, av_gold = 15762}, x = .637, y = .305, silver = "52.00", gold = "49.00", av_silver = "44.00", av_gold = "41.00"},

	},

	[2024] = --Azure Span
	{
		{name = "Archive Ambit", quest = 67741, av_quest = 67742, achievementID = {bronze = 15847 , silver = 15848, gold = 15849, av_bronze = 15850, av_silver = 15851, av_gold = 15852}, x = .422, y = .566, silver = "94.00", gold = "91.00", av_silver = "84.00", av_gold = "81.0"},
		{name = "Azure Span Slalom", quest = 67002, av_quest = 67003, achievementID = {bronze = 15799 , silver = 15800, gold = 15801, av_bronze = 15802, av_silver = 15803, av_gold = 15804}, x = .209, y = .226, silver = "61.00", gold = "58.00", av_silver = "59.00", av_gold = "56.00"},
		{name = "Azure Span Sprint", quest = 66946, av_quest = 66946, achievementID = {bronze = 15788 , silver = 15789, gold = 15790, av_bronze = 15791, av_silver = 15792, av_gold = 15793}, x = .479, y = .407, silver = "66.00", gold = "63.00", av_silver = "61.00", av_gold="58.0"},
		{name = "Frostland Flyover", quest = 67565, av_quest = 67566, achievementID = {bronze = 15841 , silver = 15842, gold = 15843, av_bronze = 15844, av_silver = 15845, av_gold = 15846}, x = .484, y = .358, silver = "79.0", gold = "76.00", av_silver = "75.00", av_gold = "72.00"},
		{name = "Iskaara Tour", quest = 67296, av_quest = 67297, achievementID = {bronze = 15835 , silver = 15836, gold = 15837, av_bronze = 15838, av_silver = 15839, av_gold = 15840}, x = .165, y = .493, silver = "78.00", gold = "75.00", av_silver = "73.00", av_gold ="70.00"},
		{name = "Vakthros Ascent", quest = 67031, av_quest = 67032, achievementID = {bronze = 15818 , silver = 15819, gold = 15820, av_bronze = 15821, av_silver = 15822, av_gold = 15823}, x = .713, y = .246, silver = "61.00", gold = "58.00", av_silver = "59.00", av_gold = "56.00"},
	},

	[2025] = --Thaldraszus
	{
		{name = "Academy Ascent", quest = 70059, av_quest = 70060, achievementID = {bronze = 15897 , silver = 15898, gold = 15899, av_bronze = 15900, av_silver = 15901, av_gold = 15902}, x = .603, y = .416, silver = "57.00", gold = "54.00", av_silver = "55.00", av_gold = "52.00"},
		{name = "Caverns Criss-Cross", quest = 70161, av_quest = 70163, achievementID = {bronze = 15909 , silver = 15910, gold = 15911, av_bronze = 15912, av_silver = 15913, av_gold = 15914}, x = .580, y = .336, silver = "53.00", gold = "50.00", av_silver = "48.00", av_gold = "45.00"},
		{name = "Cliffside Circuit", quest = 70051, av_quest = 70052, achievementID = {bronze = 15891 , silver = 15892, gold = 15893, av_bronze = 15894, av_silver = 15895, av_gold = 15896}, x = .376, y = .489, silver = "45.00", gold = "42.00", av_silver = "43.00", av_gold = "40.00"},
		{name = "Flowing Forest Flight", quest = 67095, av_quest = 67096, achievementID = {bronze = 15827 , silver = 15828, gold = 15829, av_bronze = 15830, av_silver = 15831, av_gold =15832}, x = .577, y = .750, silver = "52.00", gold = "49.00", av_silver = "43.00", av_gold = "40.00"},
		{name = "Garden Gallivant", quest = 70157, av_quest = 70158, achievementID = {bronze = 15903 , silver = 15904, gold = 15905, av_bronze = 15906, av_silver = 15907, av_gold = 15908}, x = .395, y = .761, silver = "64.00", gold = "61.00", av_silver = "57.00", av_gold = "54.00"},
		{name = "Tyrhold Trial", quest = 69957, av_quest = 69958, achievementID = {bronze = 15855 , silver = 15856, gold = 15857, av_bronze = 15858, av_silver = 15859, av_gold = 15860}, x = .572, y = .668, silver = "84.00", gold = "81.00", av_silver = "78.00", av_gold = "75.00"}, --?
	},
}

addon.Data.races = races
