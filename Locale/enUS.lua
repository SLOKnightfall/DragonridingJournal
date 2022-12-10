local addonName, addon = ...
local L = _G.LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true, true)

_G["BINDING_NAME_TOGGLE_DRAGONTRAININGMANUAL"] = addonName.." - Toggle Guide"
_G["BINDING_HEADER_DRAGONTRAININGMANUAL"] = addonName

if not L then return end

L["Options"] = true
L["Settings"] = true
L["General Options"] = true
L["Options Profiles"] = true
L["Hide when at full vigor"]  = true
L["Hide Vigor Border Graphics"]  = true
L["Scale"]  = true
L["Alpha"] = true
L["Show Rostum of Transformation on Map"] = true
L["Map Options"] = true
L["RP Options"] = true
L["Use RP Emotes"] = true
L["Empty Vigor"] = true
L["Show Collected Glyphs"] = true
L["Show Glyphs on Map"] = true

L["Cliffside Wylderdrake"] = true
L["Highland Drake"] = true
L["Windborne Velocidrake"]  = true
L["Renewed Proto Drake"] = true
L["Rostrum of Transformation Locations"] = true
L["Dragon Unlocks"] = true

L["STATS"] = true
L["Dragon Info:"] = true

L["Name: "] = true
L["Title: "] = true
L["Favorite Color: "] = true
L["Favorite Food: "] = true
L["Likes: "]= true
L["Dislikes: "]= true
L["Age: "]= true
L["Opinion of You: "] = true
L["Favorite Quote: "] = true
L["Current Mood: "] = true
