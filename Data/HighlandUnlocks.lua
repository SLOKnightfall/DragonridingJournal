local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local HighlandUnlocks = {
{ 
type ="Skin Color customizations",
data = {
"Color - Source - Cost",
"Black Scales - True Friend with Wrathion and Sabellian (Reputation with  - 400 Dragon Isles Supplies and one Awakened Earth",
"Blue Scales - Default - Free",
"White Scales - Unknown - Unknown",
"Green Scales - Maruuk Centaur Renown (level 19) - 400 Dragon Isles Supplies and one Awakened Air",
"Bronze Scales - Valdrakken Accord Renown (level 21) - 400 Dragon Isles Supplies and one Awakened Order",
"Skin Scale Type customizations",
"Skin Scale Type - Source - Cost",
"Heavy - Drop from Echo of Doragosa in Algeth’ar Academy (any difficulty)  - Free",
"Light - Default - Free",
},},

{
type = "Pattern",
data = {
"Pattern - Source - Cost",
"Stripped  - World drops - Free",
"Large Spotted - Iskaara Tuskarr Renown - 100 Dragon Isles Supplies",
"Small Spotted - Drop from Umbrelskul in the Azure Archives dungeon - Free",
"Scaled - Quest reward for Glowing Arcane Jewel - Free",
},},

{
type = "Horns",
data = {
"Grand Thorn - Unknown - Unknown",
"Curled Black Horns - Rare drop from Dragon Racer’s Purse - Free",
"Thorn - Iskaara Tuskarr Renown (level 13) - 100 Dragon Isles Supplies",
"Heavy  - Quest reward for Cache and Release - Free",
"Coiled - World drop - Free",
"Stag - World drop - Free",
"Tan - Unknown - Unknown",
"Sleek - Unknown - Unknown",
"Swept - World drop - Free",
"Hooked - Quest reward - Free",
},},

{
type = "Tail",
data = {
"Tail - Source - Cost",
"Bladed - Iskaara Tuskarr Renown (level 13) - 100 Dragon Isles Supplies",
"Hooked - Rare drop from Dragon Racer’s Purse - Free",
"Vertical Finned - Cobalt Assembly Renown High  - 400 Dragon Isles Supplies",
"Spiked Club - World drop - Free",
"Club - World drop - Free",
"Maned - Quest Reward Covering Their Tails - Free",
"Spiked - Quest reward - Free",
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
type = "Back",
data = {
"Back - Source - Cost",
"Curled Back Horns - Rare drop from Dragon Racer’s Purse - Free",
"Fin - Drop from Vakril - Free",
"Spine - Quest rewrd for What Once Was Ours - Free",
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
"Gold and Black - Friend with Wrathion and Sabellian - 750 Dragon Isles Supplies20 Draconium Ore and six Primal Bear Spine",
"Silver and Blue - Inscription - Inscription materials",
"Green and Bronze - Default - Free",
"Silver and Purple - Valdrakken Accord Renown (level 26) - 750 Dragon Isles Supplies20 Draconium Ore and 10 Tallstrider Sinew",
"Gold and Red - Waking Shores: Gold  - Free",
"Steel and Yellow - Fishing - Free",
},},


{
type = "Crest",
data = {
"Crest - Source - Cost",
"None - Default - Free",
"Fin - World drop - Free",
"Triple Fin - Cobalt Assembly reputation Medium - 200 Dragon Isles Supplies",
"Spines - Cobalt Assembly reputation High - 25 Dragon Isles Supplies",
"Plates - Quest reward for Vengeance, Served Hot - Free",
"Hair - World drop - Free",
"Single Horn - Dungeon reward - Free",
"Swept Spiked - World quest - Free",
"Multi-Horned - Iskaar Tuskarr Renown (level seven) - 50 Dragon Isles Supplies",
"Horned - Quest reward - Free",
},},

{
type = "Hair Color",
data = {
"Hair Color - Source - Cost",
"Black - Inscription - Inscription materials",
"Brown - Azure Span: Gold  - Free",
"White - Default - Free",
},},
{
type = "Mouth",
data = {
"Mouth - Source - Cost",
"Closed - Default - Free",
"Toothy - World Drop - Free",
},},
{
type = "Nose",
data = {
"Nose - Source - Cost",
"Bare - Default - Free",
"Horn - Quest reward - Free",
},},
{
type = "Chin",
data = {
"Chin - Source - Cost",
"Bare - Default - Free",
"Spikes - Quest reward - Free",
"Hair - Quest reward - Free",
"Spines - World drop - Free",
},},
{
type = "Jaw",
data = {
"Jaw - Source - Cost",
"Bare - Default - Free",
"Hair - World drop - Free",
"Fin - Quest reward - Free",
"Spines - Quest reward - Free",
},},
{
type = "Brow",
data = {
"Brow - Source - Cost",
"Bare - Default - Free",
"Crest - World drop - Free",
"Plates - Quest reward - Free",
"Bushy - IskaaraTuskarr Renown (level seven) - 50 Dragon Isles Supplies",
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
type = "Ears",
data = {
"Ears - Source - Cost",
"Fin - Default - Free",
"Thorns - World drop - Free",
"Horn - Quest reward - Free",
"Ears - World Drop - Free",
},},
}

addon.Data.HighlandUnlocks = HighlandUnlocks