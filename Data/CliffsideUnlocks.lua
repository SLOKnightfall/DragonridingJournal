local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local CliffsideUnlocks = {
{ 
type ="Skin Color customizations",
data = {
"Color - Source - Cost",
"Black Scales - True Friend with Wrathion and Sabellian  - 400 Dragon Isles Supplies and one Awakened Earth",
"Blue Scales - Iskaara Tuskarr Renown (level 19) - 400 Dragon Isles Supplies and one Awakened Frost",
"Bronze Scales - Valdrakken Accord Renown (level 21) - 400 Dragon Isles Supplies and one Awakened Order",
"Green Scales - Maruuk Centaur Renown (level 19) - 400 Dragon Isles Supplies and one Awakened Air",
},},

{
type = "Skin Scale Type",
data = {
"Skin Scale Type - Source - Cost",
"Standard - Default - Free",
"Eclipse - Quest reward - Free",
},},

{
type = "Legs",
data = {
"Legs - Source - Cost",
"Bare - Default - Free",
"Spikes - Quest reward - Free",
},},

{
type = "Tail",
data = {
"Tail - Source - Cost",
"Bare - Default - Free",
"Spikes - Drop from Dragonhunter Igordan - Free",
"Barb - Quest reward - Free",
"Large Spikes - World quests - Free",
"Fin - Cobalt Assembly Reputation High - 400 Dragon Isles Supplies",
"Blunt Spiked - Drop from Dragonhunter Igordan - Free",
"Spear - Valdrakken Accord Renown (level 15) - 100 Dragon Isles Supplies",
},},
{
type = "Horn Color",
data = {
"Horn Color - Source - Cost",
"Dark - World drop - Free",
"Light - Default - Free",
"Horn Style",
"Horn Style - Source - Cost",
"Light - Default - Free",
"Heavy - Drop from Ancient Hornswog - Free",
},},
{
type = "Back",
data = {
"Back - Source - Cost",
"Bare - Default - Free",
"Hair - Default - Free",
"Spikes - World drop - Free",
},},
{
type = "Pattern",
data = {
"Pattern - Source - Cost",
"Wide Stripes - Drop from Primal Tsunami - Free",
"Narrow Stripes - World drop - Free",
"Scaled - Valdrakken Accord Renown (level 15) - 100 Dragon Isles Supplies",
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
"Silver and Blue - Inscription - Free",
"Gold and Black - Friend with Wrathion and Sabellian - 750 Dragon Isles Supplies, 20 Draconium Ore, and six Primal Bear Spine",
"Silver and Purple - Valdrakken Accord Renown (level 26) - 750 Dragon Isles Supplies, 20 Draconium Ore, and 10 Tallstrider Sinew",
"Gold and Orange - Thaldraszus: Gold - Free",
"Steel and Yellow - Fishing - Free",
},},
{
type = "Brow",
data = {
"Brow - Source - Cost",
"Spikes - World quest - Free",
"Plates - Valdrakken Accord Renown (level nine) - 25 Dragon Isles Supplies",
},},
{
type = "Chin",
data = {
"Chin - Source - Cost",
"Dual Horn - World drop - Free"
},},
{
type = "Nose",
data = {
"Nose - Source - Cost",
"Horn - Drop from Dragonhunter Igordan - Free",
"Ridges - Quest reward - Free",
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
{
type = "Crest",
data = {
"Crest - Source - Cost",
"Fin - Dungeon reward - Free",
"Hair - World drop - Free",
"Plates - Quest reward - Free",
"Spikes - Quest reward - Free",
"Triple Horn - Inscription - Free",
"Conical - Fishin - Free",
},},
{
type = "Ears",
data = {
"Ears - Source - Cost",
"Ears - World drop - Free",
"Hairy - World drop - Free",
"Horn - World drop - Free",
},},
{
type = "Jaw",
data = {
"Jaw - Source - Cost",
"Fin - World drop - Free",
},},
{
type = "Hair Color",
data = {
"Hair Color - Source - Cost",
"Black - World Drop - Free",
"Blonde - Thaldraszus: Gold  - Free",
"Red - Inscription - 25 Dragon Isles Supplies",
"White - Quest reward - Free",
},},
}

addon.Data.CliffsideUnlocks = CliffsideUnlocks