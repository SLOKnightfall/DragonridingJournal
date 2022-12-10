local addonname, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonname)
local L = LibStub("AceLocale-3.0"):GetLocale(addonname)

local WindborneUnlocks = {
{ 
type ="Skin Color customizations",
data = {
"Color - Source - Cost",
"Black Scales - True Friend with Wrathion and Sabellian (Reputation with  - 400 Dragon Isles Supplies and one Awakened Earth",
"Blue Scales - Iskaara Tuskarr Renown (level 19) - 400 Dragon Isles Supplies and one Awakened Frost",
"Bronze Scales - Valdrakken Accord Renown (level 21) - 400 Dragon Isles Supplies and one Awakened Order",
"Green Scales - Default - Free",
"Skin Scale Type customizations",
"Skin Scale Type - Source - Cost",
"Heavy - Drop from Echo of Doragosa in Algeth’ar Academy (any difficulty)  - Free",
"Light - Default - Free",
},},

{
type = "Pattern",
data = {
"Pattern - Source - Cost",
"None - Default - Free",
"Windswept - Fishing - Free",
"Reaver - Drop from Balakar Khan - Free",
},},

{
type = "Horns",
data = {
"Horns - Source - Cost",
"Sleek - Quest reward - Free",
"Wavy - Drop from Kyrakka and Erkhart - Free",
"Cluster - Drop from Char - Free",
"Curved - Quest reward for In Defense of Vakthrosl - Free",
"Curled - Rare drop from Dragon Racer’s Purse - Free",
"Stag - World drop - Free",
"Swept - Quest reward for Mad Mordigan and The Crystal King - Free",
"Split - Quest reward - Free",
},},

{
type = "Horn Color",
data = {
"Horn Color - Source - Cost",
"Brown - Default - Free",
"Gray - World drop - Free",
"White - World drop - Free",
"Yellow - Maruuk Centaur Renown (level six) - 50 Dragon Isles Supplies",
},},
{
type = "Back",
data = {
"Back - Source - Cost",
"Bare - Default - Free",
"Fin - Reputation with Cobalt Assembly Empty - 50 Dragon Isles Supplies",
"Mane - Treasure - Free",
"Plate - Quest reward - Free",
"Spikes - World drop - Free",
"Feathers - Quest reward - Free",
},},
{
type = "Tail",
data = {
"Tail - Source - Cost",
"Bare - Quest reward - Free",
"Fin - Quest reward for Driven Mad - Free",
"Hair - Quest reward - Free",
"Spikes - Maruuk Centaur Renown (level 15) - 100 Dragon Isles Supplies",
"Club - Drop from the Grand Hunt Bosses - Free",
"Feathers - Drops from Balakar Khan - Free",
},},
{
type = "Throat",
data = {
"Throat - Source - Cost",
"Bare - Default - Free",
"Fin - Quest reward  - Free",
"Hair - Quest reward - Free",
"Plate - World drop - Free",
"Feathers - Quest reward - Free",
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
"Brown and yellow - Default - Free",
"Silver and blue - Inscription - Free",
"Steel and orange - Fishing - Free",
"Gold and red - Waking Shores: Gold  - Free",
"Silver and purple - Valdrakken Accord Renown (level 26) - 750 Dragon Isles Supplies, 20 Draconium Ore, and 10 Tallstrider Sinew",
},},
{
type = "Snout",
data = {
"Snout - Source - Cost",
"Horn - Default - Free",
"Long - Maruuk Centaur Renown (level 15) - 100 Dragon Isles Supplies",
"Wolf - Quest reward  - Free",
"Hooked - Rare drop from Dragon Racer’s Purse - Free",
"Beaked - Reputation with Cobalt Assembly Medium - 200 Dragon Isles Supplies",
},},
{
type = "Crest",
data = {
"Crest - Source - Cost",
"None - Default - Free",
"Large Fin - Drop from Skewersnout - Free",
"Small Fin - World drop - Free",
"Hair - Drop from Decatriarch Wratheye - Free",
"Spined - Fishing - Free",
"Feathers - World drops - Free",
},},
{
type = "Jaw",
data = {
"Jaw - Source - Cost",
"Bare - Default - Free",
"Finned ears - World drop - Free",
"Thorns - Quest reward - Free",
"Horned - Maruuk Centaur Renown (level six) - 50 Dragon Isles Supplies",
},},
{
type = "Fur Color",
data = {
"Fur Color - Source - Cost",
"Tan - Quest reward - Free",
"Black - Maruuk Centaur Renown (level six) - 50 Dragon Isles Supplies",
"Gray - Quest reward - Free",
"White - Achievement - Free",
"Red - Default - Free",
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

addon.Data.WindborneUnlocks = WindborneUnlocks