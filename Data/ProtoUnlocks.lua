local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local ProtoUnlock = {
{ 
type ="Skin Color customizations",
data = {
"Color - Source - Cost",
"Black Scales - True Friend with Wrathion and Sabellian - 400 Dragon Isles Supplies and one Awakened Earth",
"Blue Scales - Iskaara Tuskarr Renown (level 19) - 400 Dragon Isles Supplies and one Awakened Frost",
"Bronze Scales - Valdrakken Accord Renown (level 21) - 400 Dragon Isles Supplies and 1 Awakened Order",
"Green Scales - Maruuk Centaur Renown (level 19) - 400 Dragon Isles Supplies and 1 Awakened Air",
"Skin Scale Type customizations",
"Skin Scale Type - Source - Cost",
"Heavy - Drop from Echo of Doragosa in Algeth’ar Academy (any difficulty) for Renewed Proto-Drake - Free",
"Light - Default - Free",
},},

{
type = "Pattern",
data = {
"Pattern - Source - Cost",
"Predator - Inscription - Inscription materials",
"Harrier - Dragonscale Expedition Renown (level 14) - 100 Dragon Isles Supplies",
"Skyterror - Drop from Decatriarch Wratheye in Brackenhide Hollow (any difficulty) - Free",
},},

{
type = "Horns",
data = {
"Horns - Source - Cost",
"Swept - Dragonscale Expedition Renown (level 14) - 100 Dragon Isles Supplies",
"Curled - Rare drop from Dragon Racer’s Purse - Free",
"Coiled - Drop from Dragonhunter Igordan - Free",
"Ears - Drop from Sharpfang and Scav Notail - Free",
"Bovine - Inscription - Inscription materials",
"Thorn - Iskaara Tuskarr Renown (level 13) - 100 Dragon Isles Supplies",
"Impaler - Drop from Lookout Mordren - Free",
"Gradient - Quest reward for Mad Mordigan and The Crystal King - Free",
},},

{
type = "Horn Color",
data = {
"Horn Color - Source - Cost",
"White - Default - Free",
"Horn Style",
"Horn Style - Source - Cost",
"Light - Default - Free",
"Heavy - Drop from Klozicc the Ascended - Free",
},},
{
type = "Tail",
data = {
"Tail - Source - Cost",
"Bare - Default - Free",
"Spiked - Quest reward - Free",
"Spiked Club - Dragonscale Expedition Renown (level 14) - 100 Dragon Isles Supplies",
"Club - Drop from Ancient Hornswog - Free",
"Finned - World Drop - Free",
"Maned - Quest Reward Covering Their Tails - Free",
"Spined - Quest reward for Training Wings - Free",
},},
{
type = "Throat",
data = {
"Throat - Source - Cost",
"Bare - Default - Free",
"Spiked - Quest reward for The Black Locus - Free",
"Finned - Quest reward - Free",
},},
{
type = "Body Armor",
data = {
"Body Armor - Source - Cost",
"Saddle - Default - Free",
},},
{
type = "Armor Color",
data = {
"Armor Color - Source - Cost",
"Gold and red - Achievement Waking Shores: Gold  - Free",
"Silver and blue - Inscription - Inscription materials",
"Green and Gold - Default - Free",
"Silver and Purple - Valdrakken Accord Renown (level 26) - 750 Dragon Isles Supplies, 20 Draconium Ore, and 10 Tallstrider Sinew",
"Gold and Red - Achievement Waking Shores: Gold  - Free",
"Steel and Yellow - Fishing - Free",
},},
{
type = "Snout",
data = {
"Snout - Source - Cost",
"Toothy - Default - Free",
"Snub - World drop - Free",
"Razor - Quest reward for Home Is Where the Frogs Are - Free",
"Shark - World drop - Free",
"Beaked - Drops from Kyrakka and Erkhart - Free",
},},
{
type = "Crest",
data = {
},},{
type = "Jaw",
data = {
"Jaw - Source - Cost",
"Bare - Default - Free",
"Thick Spined - Reputation Reward with Cobalt Assembly Low - 100 Dragon Isles Supplies",
"Horned - Quest reward - Free",
"Hairy - Quest reward - Free",
"Spiked - Dragonscale Expedition Renown (level nine) - 50 Dragon Isles Supplies",
"Think Spined - Dragonriding racing world quests - Free",
"Broad Spiked - Quest Reward - Free",
"Finned - Quest reward - Free",
},},
{
type = "Brow",
data = {
"Brow - Source - Cost",
"Bare - Default - Free",
"Curved Spiked - Quest Reward - Free",
"Thick Spiked - Quest Reward - Free",
"Hairy - Quest Reward - Free",
"Spinned - Dragonscale Expedition Renown (level nine) - 50 Dragon Isles Supplies",
},},
{
type = "Hair Color",
data = {
"Hair Color - Source - Cost",
"Black - Default - Free",
"Blue - Reputation reward with Cobalt Assembly (Maximum) - 600 Dragon Isles Supplies",
"Brown - Quest reward - Free",
"Gray - Drops from Eaglemaster Niraak - Free",
"Purple - World drop - Free",
"Red - Inscription - Inscription materials",
},},
{
type = "Eyesight",
data = {
"Eyesight - Source - Cost",
"Both - Default - Free",
"Neither - Default - Free",
"Right - Default - Free",
"Left - Default - Free",
},},

{
type = "Eye Color",
data = {
"Currently, there are over 40 color customizations in the game that depend on the Eye Style you’re using.",
},},
{
type = "Eye Style",
data = {
"Eye Style - Source - Cost",
"Slit - Default - Free",
"Glow - Default - Free",
"Cross - Default - Free",
},},
}

addon.Data.ProtoUnlock = ProtoUnlock