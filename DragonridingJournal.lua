--  ///////////////////////////////////////////////////////////////////////////////////////////
--
--  Dragonriding Journal
--  Author: SLOKnightfall
--  
--
--
--  ///////////////////////////////////////////////////////////////////////////////////////////

local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0")
addon.Frame = LibStub("AceGUI-3.0")
addon.Data = {}
addon.currentDragon = nil

local LSM = LibStub("LibSharedMedia-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)

local playerInv_DB
local Profile
local playerNme
local realmName
local playerClass, classID,_
local keybindOverritten
local launchSpells = {386451, 372610, 383363}
local DragonFlyingSpells = {368896, 368899, 360954, 368901}
local DragonFlyingZones = {2022, 2023, 2024, 2025, 2107, 2112}
local combatDelay = false

local MinimapIcon = LibStub("LibDBIcon-1.0")

--Registers for LDB addons
	addon.DataBroker = LibStub("LibDataBroker-1.1"):NewDataObject("DragonGuideVigor", {
	type = "data source",
	text = "",
	icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor0",
	OnClick = function(self, button, down) 
		if (button == "RightButton") then
			LibStub("AceConfigDialog-3.0"):Open("DragonridingJournal")

		elseif (button == "LeftButton") then
			DragonridingJournalFrame_Toggle()
		end
	end,})

--Minimap/LDB Tooltip Creation
function addon.DataBroker:OnTooltipShow()
end

function addon.DataBroker:OnEnter()
	--GameTooltip:SetOwner(self, "ANCHOR_NONE")
	--GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	--GameTooltip:ClearLines()
	--GameTooltip:Show()
end

function addon.DataBroker:OnLeave()
	GameTooltip:Hide()
end

function addon.DataBroker:Toggle(value)
	local Profile = addon.db.profile
		if value then
			MinimapIcon:Show("DragonGuideVigor")
			Profile.MMDB.hide = false
			Profile.showMinimap = true

		else
			MinimapIcon:Hide("DragonGuideVigor")
			Profile.MMDB.hide = true
			Profile.showMinimap = false
	end
end	

function addon.DataBroker:CheckZone()
	if not tContains(DragonFlyingZones, CurrentZone) then
		--MinimapIcon:Hide("DragonGuideVigor")
	else
		if addon.db.profile.showMinimap then
		--	MinimapIcon:Show("DragonGuideVigor")
		end
	end
end

function addon.DataBroker:Update(text)
	--addon.DataBroker.text = text
	addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor0"

	if text == 0 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor0"

	elseif text == 1 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor1"

	elseif text == 2 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor2"

	elseif text == 3 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor3"

	elseif text == 4 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor4"

	elseif text == 5 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor5"

	elseif text == 6 then
		addon.DataBroker.icon = "Interface\\Addons\\DragonridingJournal\\Images\\Vigor6"
	end
end

--ACE3 Option Handlers
local optionHandler = {}
function optionHandler:Setter(info, value)
	addon.db.profile[info[#info]] = value

	if info.arg == "updateSize" then
		addon:ResizeVigorFrame()

	elseif info.arg == "HideBorder" then
		addon:RemoveVigorBorder()

	elseif info.arg == "HideBlizzardVigor" then
		UIWidgetPowerBarContainerFrame:SetShown(not value)

	elseif info.arg == "minimap" then
		addon.DataBroker:Toggle(value)

	elseif info.arg == "HideSecondaryVigor" then 
		--DragonJournlVigorContainerFrameTempl:OnUpdate()

	elseif info.arg == "LockSecondary" then
		DragonJournlVigorContainerFrameTempl:SetMovable(not value)

	elseif info.arg == "unlockTimer" then
		DragonJournalRaceTimer:SetPositionLock(not value)
	end
end

function optionHandler:Getter(info)
	return addon.db.profile[info[#info]]

end

function optionHandler:DragonGetter(info)
	local dragon = addon.db.char.dragons[info.arg]
	return dragon[info[#info]]
end

function optionHandler:DragonSetter(info, value)
	local dragon = addon.db.char.dragons[info.arg]
	dragon[info[#info]] = value
end

local options = {
	name = " ",
	handler = optionHandler,
	get = "Getter",
	set = "Setter",
	type = 'group',
	childGroups = "tab",
	inline = true,
	args = {
		settings={
			name = L["Options"],
			type = "group",
			childGroups = "tab",
			inline = false,
			order = 0,
			args={
				general_settings={
					name = L["Settings"],
					type = "group",
						childGroups = "tree",
					inline = false,
					order = 1,
					args={
						alert_settings={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Alerts Options"],
									type = "header",
									width = "full",
								},
									lowVigorAlert = {
									order = 1,
									name = L["Show On Screen Low Vigor Alert"],
									type = "toggle",
									width = "full",--1.3,
									arg = "minimap",
								},
									lowVigorAudioAlert = {
									order = 2,
									name = L["Play Alert Sound On Low Vigor"],
									type = "toggle",
									width = "full",--1.3,
									arg = "minimap",
								},									
								lowVigorAlertSound = {
									order = 3,
									type = 'select',
									dialogControl = 'LSM30_Sound',
									name = L["Alert Sound"],
									values = LSM:HashTable("sound"),
								}
							},
						},
						timer_settings={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Race Timer Options"],
									type = "header",
									width = "full",
								},
								raceTimer = {
									order = 1,
									name = L["Show Race Timer When Racing"],
									type = "toggle",
									width = "full",--1.3,
								},
								lockTimer = {
									order = 2,
									name = L["Lock Race Timer"],
									desc = "Unlocking will show timer and allow it to be posotioned",
									type = "toggle",
									width = "full",--1.3,
									arg = "unlockTimer",
								},	
								resetTimer = {
									order = 2,
									name = L["Reset Position"],
									type = "execute",
									width = "full",--1.3,
									arg = "resetTimer",
									func = function() addon.db.profile.timerPosition = true; DragonJournalRaceTimer:LoadPosition() end

								},									
							},
						},
						vigor_settings={
							name = " ",
							type = "group",
							inline = true,
							order = 2,
							args={
								Options_Header = {
									order = 1,
									name = L["Vigor Bar Options"],
									type = "header",
									width = "full",
								},
								HideBlizzardVigor = {
									order = 1.2,
									name = L["Hide Blizzard Vigor Bar"],
									type = "toggle",
									width = "full",--1.3,
									arg = "HideBlizzardVigor",
								},
								HideSecondaryVigor = {
									order = 1.2,
									name = L["Hide the Secondary Vigor Bar"],
									type = "toggle",
									width = "full",--1.3,
									arg = "HideSecondaryVigor",
								},
								LockSecondary = {
									order = 1.2,
									name = L["Lock Secondary Bar"],
									type = "toggle",
									width = "full",--1.3,
									arg = "LockSecondary",
								},
								SecondaryCompact = {
									order = 1.2,
									name = L["Compact Secondary Bar"],
									type = "toggle",
									width = "full",--1.3,
								},
								HideWhenFull = {
									order = 1.4,
									name = L["Hide when at full vigor"],
									type = "toggle",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								HideBorder = {
									order = 1.3,
									name = L["Hide Vigor Border Graphics"],
									type = "toggle",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								VigorScale = {
										type = "range",
										order = 1.5,
										name = L["Vigor Scale"],
										step = 1,
										min = 50,
										max = 200,
										arg = "updateSize",
										width = 1,
									},
								VigorAlpha = {
										type = "range",
										order = 1.6,
										name = L["Vigor Alpha"],
										step = 1,
										min = 25,
										max = 100,
										arg = "updateSize",
										width = 1,
									},
								FlyingVigorAlpha = {
										type = "range",
										order = 1.7,
										name = L["Alpha When Flying"],
										step = 1,
										min = 25,
										max = 100,
										arg = "updateSize",
										width = 1,
									},				
								BlizzardVigorScale = {
										type = "range",
										order = 1.8,
										name = L["Blizzard Vigor Scale"],
										step = 1,
										min = 50,
										max = 200,
										arg = "updateSize",
										width = 1,
									},
								BlizzardVigorAlpha = {
										type = "range",
										order = 1.9,
										name = L["BlizzardVigor Alpha"],
										step = 1,
										min = 25,
										max = 100,
										arg = "updateSize",
										width = 1,
									},
								BlizzardFlyingVigorAlpha = {
										type = "range",
										order = 1.91,
										name = L["Blizzard Alpha When Flying"],
										step = 1,
										min = 25,
										max = 100,
										arg = "updateSize",
										width = 1,
									},
								showMinimap = {
									order = 1.8,
									name = L["Show Minimap Button"],
									desc = L["Access the Journal and tracks Vigor"],
									type = "toggle",
									type = "toggle",
									width = "full",--1.3,
									arg = "minimap",
								},
							},
						},


						map_settings={
							name = " ",
							type = "group",
							inline = true,
							order = 3,
							args={
								Options_Header = {
									order = 1,
									name = L["Map Options"],
									type = "header",
									width = "full",
								},
								ShowCompleted = {
									order = 2.1,
									name = L["Show Collected Glyphs"],
									type = "toggle",
									width = 1.3,
								},

								ShowGlyphs = {
									order = 2,
									name = L["Show Glyphs on Map"],
									type = "toggle",
									width = 1.3,
								},
								glyphScale = {
									type = "range",
									order = 2.3,
									name = L["Scale"],
									step = 2.2,
									min = 50,
									max = 200,
									--arg = "updateSize",
									width = 1,
									hidden = true,
								},
								glyphAlpha = {
									type = "range",
									order = 2.4,
									name = L["Alpha"],
									step = 1,
									min = 25,
									max = 100,
									--arg = "updateSize",
									width = 1,
								},
								showRostum = {
									order = 3,
									name = L["Show Rostum of Transformation on Map"],
									type = "toggle",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								rostrumScale = {
									type = "range",
									order = 3.1,
									name = L["Scale"],
									step = 1,
									min = 50,
									max = 200,
									--arg = "updateSize",
									width = 1,
									hidden = true,
								},
								rostrumAlpha = {
									type = "range",
									order = 3.2,
									name = L["Alpha"],
									step = 1,
									min = 25,
									max = 100,
									--arg = "updateSize",
									width = 1,
								},

								showRaces = {
									order = 4,
									name = L["Show Races on Map"],
									type = "toggle",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								raceScale = {
									type = "range",
									order = 4.1,
									name = L["Scale"],
									step = 1,
									min = 50,
									max = 200,
									--arg = "updateSize",
									width = 1,
									hidden = true,
								},
								raceAlpha = {
									type = "range",
									order = 4.2,
									name = L["Alpha"],
									step = 1,
									min = 25,
									max = 100,
									--arg = "updateSize",
									width = 1,
								},
							},
						},
						keybind_settings={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Keybind Options"],
									type = "header",
									width = "full",
								},

								overrideBindings= {
									order = 1,
									name = L["Override Movement Keys When Flying"],
									desc = L["Temp Override MOVEFORWARD, MOVEBACKWARD, STRAFELEFT, STRAFERIGHT with PITCHUP, PITCHDOWN, TURNLEFT, TURNRIGHT"  ],
									type = "toggle",
									width = "full",--1.3,
									arg = "minimap",
								},
								pitchSensitivity = {
									order = 2,
									type = "range",
									name = L["Change Pitch Sensitivity"],
									step = .1,
									min = 1,
									max = 10,
									--arg = "updateSize",
									width = 1,
									get = function(self) return tonumber(GetCVar("dragonRidingPitchSensitivity")) end,
									set = function(self, value) SetCVar( "dragonRidingPitchSensitivity", tonumber(value) ) end,
								},									
							},
						},					
					},
				},

			},
		},
		RP_settings={
			name = L["RP Options"],
			type = "group",
			childGroups = "tab",
			inline = false,
			order = 3,
			args={
				general_settings={
					name = L["Settings"],
					type = "group",
					childGroups = "tree",
					inline = false,
					order = 1,
					args={
						rp_settings={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["RP Options"],
									type = "header",
									width = "full",
								},
								use_emotes = {
									order = 1.2,
									name = L["Use RP Emotes"],
									type = "toggle",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								emote_throttle = {
									order = 1.2,
									name = L["Use RP Emotes"],
									type = "toggle",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								empty_vigor = {
									order = 1.3,
									name = L["On Empty Vigor"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								full_vigor = {
									order = 1.4,
									name = L["On Full Vigor"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								summon_start = {
									order = 1.5,
									name = L["On Mount Summon Start"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								summon_end = {
									order = 1.5,
									name = L["On Mount Summon End"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								use_surge = {
									order = 1.6,
									name = L["Using Surge Forward"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								use_ascend = {
									order = 1.7,
									name = L["Using Skyward Ascend"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								gain_thrill = {
									order = 1.8,
									name = L["After Gaining Thrill of the Skies"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								lose_thrill = {
									order = 1.9,
									name = L["After Losing Thrill of the Skies"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},								
								use_winds = {
									order = 1.91,
									name = L["After Using Winds of the Isles"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								use_whirl = {
									order = 1.92,
									name = L["After Using Whirling Surge"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},
								use_Timelock = {
									order = 1.93,
									name = L["After Using Bronze Timelock"],
									type = "input",
									width = "full",--1.3,
									--arg = "IgnoreClassRestrictions",
								},

							},
						},
					},
				},
			},
		},
		dragon_settings={
			name = L["Dragon Options"],
			type = "group",
			childGroups = "tab",
			inline = false,
			order = 3,
			get = "DragonGetter",
			set = "DragonSetter",

			args={
				dragon1={
					name = L["Renewed Proto Drake"],
					type = "group",
					childGroups = "tree",
					inline = false,
					order = 1,
					args={
						dragon_bio={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Bio Details"],
									type = "header",
									width = "full",
								},

								name = {
									order = 1.2,
									name = L["Name"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},
								title = {
									order = 1.3,
									name = L["Tile"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},
								color = {
									order = 1.4,
									name = L["Favorite Color"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},
								likes = {
									order = 1.5,
									name = L["Likes"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},
								dislikes = {
									order = 1.6,
									name = L["Dislikes"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},
								age = {
									order = 1.7,
									name = L["Age"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},							
								mood = {
									order = 1.8,
									name = L["Current Mood"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},								
								quote = {
									order = 1.9,
									name = L["Favorite Quote"],
									type = "input",
									width = "full",--1.3,
									arg = 1,
								},

							},
						},	
					},
				},
				dragon2={
					name = L["Windborne Velocidrake"],
					type = "group",
					childGroups = "tree",
					inline = false,
					order = 2,
					args={
						dragon_bio={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Bio Details"],
									type = "header",
									width = "full",
								},

								name = {
									order = 1.2,
									name = L["Name"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},
								title = {
									order = 1.3,
									name = L["Tile"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},
								color = {
									order = 1.4,
									name = L["Favorite Color"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},
								likes = {
									order = 1.5,
									name = L["Likes"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},
								dislikes = {
									order = 1.6,
									name = L["Dislikes"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},
								age = {
									order = 1.7,
									name = L["Age"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},							
								mood = {
									order = 1.8,
									name = L["Current Mood"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},								
								quote = {
									order = 1.9,
									name = L["Favorite Quote"],
									type = "input",
									width = "full",--1.3,
									arg = 2,
								},

							},
						},	
					},
				},
				dragon3={
					name = L["Cliffside Wylderdrake"],
					type = "group",
					childGroups = "tree",
					inline = false,
					order = 3,
					args={
						dragon_bio={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Bio Details"],
									type = "header",
									width = "full",
								},

								name = {
									order = 1.2,
									name = L["Name"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},
								title = {
									order = 1.3,
									name = L["Tile"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},
								color = {
									order = 1.4,
									name = L["Favorite Color"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},
								likes = {
									order = 1.5,
									name = L["Likes"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},
								dislikes = {
									order = 1.6,
									name = L["Dislikes"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},
								age = {
									order = 1.7,
									name = L["Age"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},							
								mood = {
									order = 1.8,
									name = L["Current Mood"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},								
								quote = {
									order = 1.9,
									name = L["Favorite Quote"],
									type = "input",
									width = "full",--1.3,
									arg = 3,
								},

							},
						},	
					},
				},
				dragon4={
					name = L["Highland Drake"],
					type = "group",
					childGroups = "tree",
					inline = false,
					order = 4,
					args={
						dragon_bio={
							name = " ",
							type = "group",
							inline = true,
							order = 1,
							args={
								Options_Header = {
									order = 1,
									name = L["Bio Details"],
									type = "header",
									width = "full",
								},

								name = {
									order = 1.2,
									name = L["Name"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},
								title = {
									order = 1.3,
									name = L["Tile"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},
								color = {
									order = 1.4,
									name = L["Favorite Color"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},
								likes = {
									order = 1.5,
									name = L["Likes"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},
								dislikes = {
									order = 1.6,
									name = L["Dislikes"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},
								age = {
									order = 1.7,
									name = L["Age"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},							
								mood = {
									order = 1.8,
									name = L["Current Mood"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},								
								quote = {
									order = 1.9,
									name = L["Favorite Quote"],
									type = "input",
									width = "full",--1.3,
									arg = 4,
								},

							},
						},	
					},
				},
			},
		},
	},
}

local defaults = {
	profile = {
		['*'] = true,
		VigorScale = 100,
		VigorAlpha = 100,
		FlyingVigorAlpha = 100,
		BlizzardVigorScale = 100,
		BlizzardVigorAlpha = 100,
		BlizzardFlyingVigorAlpha = 100,
		glyphScale = 100,
		glyphAlpha = 100,
		raceScale = 100,
		raceAlpha = 100,
		rostrumScale = 100,
		rostrumAlpha = 100,
		emote_throttle = 5,
		HideBlizzardVigor = false,
		HideSecondaryVigor = true,
		SecondaryCompact = false,

		lowVigorAudioAlert = false,
		lowVigorAlert = false,
		lowVigorAlertSound = "Default",
		overrideBindings = false,

		empty_vigor = "{} tires as his vigor depleats.",
		full_vigor = "{} is fully invigorated.",
		summon_start = "You yell into the sky for {}.",
		summon_end = "{} swoops down and you leap aboard.",
		use_surge = "You urge {} to surge forward.",
		use_ascend = "You urge {} to fly higher.",
		gain_thrill = "{} growls in contentment as you pick up speed.",
		lose_thrill = "The wind lessens as you start to slow.",
		use_winds = "",
		use_whirl = "You hold on as {} spirals forwards.",
		use_Timelock = "The sands of time return you to where you were.",
		MMDB = { hide = false,
				--minimap = {},
		},
	},
	char = {
		dragons = {},
		races = {}
	}
}

function addon:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("DragonridingJournalConfig", defaults, true)
	options.args.settings.args.options = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	options.args.settings.args.options.name = L["Options Profiles"]
	options.args.settings.args.options.order = 2

	LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
	LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options)

	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("DragonridingJournal", "Dragon Training Manual")
	self.db.RegisterCallback(addon, "OnProfileChanged", "RefreshConfig")
	self.db.RegisterCallback(addon, "OnProfileCopied", "RefreshConfig")

	MinimapIcon:Register("DragonGuideVigor", addon.DataBroker, self.db.profile.MMDB)

end
function addon:RefreshConfig()
	-- would do some stuff here
end

function addon:OnEnable()
	if IsAddOnLoaded("Blizzard_WorldMap") then
		addon:AddDataProvider()
	end

	LSM:Register("SOUND", "Default","Interface\\AddOns\\"..addonName.."\\Media\\dingding.mp3")

	addon:RegisterEvent("PLAYER_ENTERING_WORLD", "EventHandler")
	addon:RegisterEvent("UPDATE_UI_WIDGET", "EventHandler")
	addon:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", "EventHandler")
	addon:RegisterEvent("SPELL_UPDATE_COOLDOWN", "EventHandler")
	addon:RegisterEvent("UNIT_SPELLCAST_START", "EventHandler")
	addon:RegisterEvent("UNIT_AURA", "EventHandler")

	addon:SecureHookScript(EventToastManagerFrame, "OnShow", function(...) addon:GetRaceTime(EventToastManagerFrame.currentDisplayingToast.toastInfo) end, true)
	local dragons = self.db.char.dragons
	for i=1, 4 do
		if not dragons[i] then
			dragons[i] = addon:BuildDragon()
		end

		dragons[i].mood = addon:GetMood()
	end

	DragonJournlVigorContainerFrameTempl:OnLoad()
	addon.initTourGuide()
	if self.db.profile.HideBlizzardVigor then
		UIWidgetPowerBarContainerFrame:Hide()
	end
end

local currentDragon
local emoteThrottle
function addon:PrintEmote(emoteText, throttle)
	if not addon.db.profile.use_emotes then return end
	local name = ""
	currentDragon = addon:GetCurrentDragon() or currentDragon

	if currentDragon == 368896 then
		name = addon.db.char.dragons[1].name
	elseif currentDragon == 368899 then
		name = addon.db.char.dragons[2].name
	elseif currentDragon == 368901 then
		name = addon.db.char.dragons[3].name
	elseif currentDragon == 360954 then
		name = addon.db.char.dragons[4].name
	end

	if (throttle and not emoteThrottle) or not throttle then 
		emoteThrottle = true
		C_Timer.After(self.db.profile.emote_throttle, function() emoteThrottle = false end)

		emoteText= string.gsub(emoteText, "{}", name) 
		print(emoteText)
	end
end


function ClearKeybinds()
	if keybindOverritten == true then 
		print("def Key")

		keybindOverritten = false
		ClearOverrideBindings(btn)
	end
end

local thrillGained = false
function addon:AuraScan()
	local profile = addon.db.profile
	local thrillFound = false
	local onDragon = false
	for i = 1, 40 do

		name =  select(1, UnitBuff("PLAYER", i))
		spellID =  select(10, UnitBuff("PLAYER", i))


		if spellID == 377234 then 
			if not thrillGained then
				addon:PrintEmote(profile.gain_thrill,true)
			end 
			thrillGained = true
			thrillFound = true 
		end

		if tContains(DragonFlyingSpells, spellID) then
			addon.currentDragon = spellID
			onDragon = true
			return true
		end

		if spellID == nil then
			if thrillGained and not thrillFound  then
				thrillGained = false
				addon:PrintEmote(profile.lose_thrill,true)
				addon.currentDragon = nil
			end 
			ClearKeybinds()
			return false
		end
	end
	ClearKeybinds()
	return false
end
--377234
--3-74990/bronze-timelock


--374994/bronze-rewind

	function addon:SaveFramePosition(frame, variable)
		local _, _, _, x, y = frame:GetPoint()
		addon.db.profile[variable] = {x = x, y = y}
		frame:StopMovingOrSizing()
	end

	function addon:LoadFramePosition(frame, variable)
		local frameSetting = addon.db.profile[variable]
		frame:ClearAllPoints()

		if not frameSetting or frameSetting == true  or not frameSetting.x  then 
			frame:SetPoint("CENTER", 0, 0)

		else 
			frame:SetPoint("TOPLEFT", nil, "TOPLEFT", frameSetting.x, frameSetting.y)
		end
	end

	local keybinds = {
	"MOVEFORWARD", "MOVEBACKWARD", "STRAFELEFT", "STRAFERIGHT"}
		local flyingbinds = {"PITCHUP", "PITCHDOWN", "TURNLEFT","TURNRIGHT"}


local savedKeybinds = {}
local function GetKeybinds()
	for i, keybind in ipairs(keybinds) do
		
		local key1, key2 = GetBindingKey(keybind)  --GetBindingKey(keybind)
		savedKeybinds[i] = {key1, key2}
	end
end

local btn = CreateFrame("frame", nil, UIParent)

--TODO COMbat delay
function SetKeybind()
	if true then return end
	if not addon:AuraScan() then return end
		print("setkey")
	keybindOverritten = true
	for i, keybind in ipairs(flyingbinds) do
		for k = 1, 2 do
			if savedKeybinds[i][k] then 
				keybindOverritten = true
				SetOverrideBinding(btn, true, savedKeybinds[i][k] , keybind)
			end
		end
	end
end

function addon:GetCurrentDragon()
	return addon.currentDragon
end

function addon:EventHandler(event, ...)
	local profile = self.db.profile
	if event == "PLAYER_ENTERING_WORLD" then

		C_Timer.After(1.5, function() 
			DragonJournlVigorContainerFrameTempl:OnUpdate()
			DragonJournalRaceTimer:OnLoad()
			--SetKeybind()
		 end)
				
	elseif event == "SPELL_UPDATE_COOLDOWN" then
		--print(...)

	elseif event == "ADDON_LOADED" then
		local addon = ...
		if addon == "Blizzard_WorldMap" then
			addon:AddDataProvider()
		end

	elseif event == "UNIT_AURA" then
		local unit = ...
		if unit == "player" then
			addon:AuraScan()
		end

	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		local unit, _, spellID = ...
		if unit ~= "player" then return end
		if tContains(launchSpells, spellID) then
			addon:PrintEmote(profile.use_ascend, true)

		elseif spellID == 372608  then
			addon:PrintEmote(profile.use_surge, true)

		elseif tContains(DragonFlyingSpells, spellID) then
			addon:PrintEmote(profile.summon_end)
			self.db.char.mounted = self.db.char.mounted or {}
			self.db.char.mounted[addon:GetCurrentDragon()] = self.db.char.mounted[addon:GetCurrentDragon()] or 0
			print(self.db.char.mounted[addon:GetCurrentDragon()] )
			self.db.char.mounted[addon:GetCurrentDragon()] = self.db.char.mounted[addon:GetCurrentDragon()] + 1
			--GetKeybinds()
			--SetKeybind()

		elseif spellID == 376359 then
			addon:PrintEmote(profile.use_whirl, true)
		end

	elseif event == "UNIT_SPELLCAST_START" then
		local unit, _, spellID = ...
		if unit == "player" and tContains(DragonFlyingSpells, spellID) then
			currentDragon = spellID
			addon:PrintEmote(profile.summon_start)
		 end

	elseif event == "PLAYER_REGEN_ENABLED" then
		if combatDelay then
			combatDelay = false
		end

	elseif event == "PLAYER_REGEN_DISABLED" then
		combatDelay = true
	end
end