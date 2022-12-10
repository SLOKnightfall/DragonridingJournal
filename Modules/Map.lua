local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
--_G[addonName] = {}
addon.Frame = LibStub("AceGUI-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local mapID

--Derived from Blizzard's MapCanvas_DataProviderBase.lua & AreaPOIDataProvider.lua
local DragonridingJournalMapDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin)

function addon:AddDataProvider()
	WorldMapFrame:AddDataProvider(CreateFromMixins(DragonridingJournalMapDataProviderMixin))
	if IsAddOnLoaded("OmegaMap") then 
		OmegaMapFrame:AddDataProvider(CreateFromMixins(DragonridingJournalMapDataProviderMixin))
	end
end

function DragonridingJournalMapDataProviderMixin:OnAdded(mapCanvas)
	MapCanvasDataProviderMixin.OnAdded(self, mapCanvas)
end

function DragonridingJournalMapDataProviderMixin:RemoveAllData()
	self:GetMap():RemoveAllPinsByTemplate(self:GetPinTemplate())
end

function DragonridingJournalMapDataProviderMixin:RefreshAllData()
	self:RemoveAllData()
	mapID = self:GetMap():GetMapID()
	local pinList = {"Glyph", "Race", "Rostrum"}
	for _, dataType in ipairs(pinList) do
		local pinSettings = self:GetPinSettings(dataType)
		local areaPOIs = pinSettings.dataBase

		if not pinSettings.dataBase then return end

		if pinSettings.show then
			for _, areaPoiID in ipairs(areaPOIs) do
				local completed
					if type(areaPoiID.achievementID) == "number" then
						completed =  select(13, GetAchievementInfo(areaPoiID.achievementID))
					else
						completed, completedAdv = addon:GetRaceMedal(areaPoiID.achievementID)
					end

				if (not addon.db.profile.ShowCompleted and completed  == false) or addon.db.profile.ShowCompleted then
					local pin = self:GetMap():AcquirePin(self:GetPinTemplate())
					pin:SetPosition(areaPoiID.x, areaPoiID.y)
					pin:SetScale(pinSettings.scale / 100)
					pin.tooltip = areaPoiID.name

					if dataType == "Glyph" then 
						pin.Texture:SetTexture(pinSettings.texture)
						pin.Collected.Icon:SetAtlas("ParagonReputation_Checkmark")
						if completed then
							pin:SetAlpha(.45)
							pin.Collected:Show()
							
						else
							pin:SetAlpha(pinSettings.alpha / 100)
						end
					else
						pin.Collected.Icon:SetAtlas(pinSettings.texture)
						pin.Collected:Hide()
						pin:SetAlpha(pinSettings.alpha / 100)
						if (completedAdv == "av_gold") then
							pin.Texture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Gold")

						elseif (completedAdv == "av_silver") then
							pin.Texture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Silver")

						elseif (completedAdv == "av_bronze") then
							pin.Texture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Bronze")

						elseif (completed == "gold") then
							pin.Texture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Gold")

						elseif (completed == "silver") then
							pin.Texture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Silver")

						elseif (completed == "bronze") then
							pin.Texture:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Bronze")

						else
							pin.Texture:SetAtlas(pinSettings.texture)
							pin.Collected:Hide()
							pin.Texture:Show()
						end

						if (completed or completedAdv) then
							pin.Texture:Show()
							if completedAdv then
							pin.Glow:Show()

							end
						else
							pin.Texture:Hide()
							pin.Glow:Hide()
						end
					end
				end
			end
		end
	end
end

function DragonridingJournalMapDataProviderMixin:GetPinTemplate()
	return "DragonridingJournalMapPinTemplate"
end

function DragonridingJournalMapDataProviderMixin:GetPinSettings(pinType)
	local pinSettings = {
		["Glyph"] = {
			dataBase = addon.Data.glyphs[mapID],
			alpha = addon.db.profile.glyphAlpha,
			scale = addon.db.profile.glyphScale,
			texture = "Interface/ICONS/Ability_DragonRiding_Glyph01",
			show = addon.db.profile.ShowGlyphs,

		},
		["Race"] = {
			dataBase = addon.Data.races[mapID],
			alpha = addon.db.profile.raceAlpha,
			scale = addon.db.profile.raceScale,
			texture = "racing",
			show = addon.db.profile.showRaces,

		},
		["Rostrum"] = {
			dataBase = addon.Data.Rostrum[mapID],
			alpha = addon.db.profile.rostrumAlpha,
			scale = addon.db.profile.rostrumScale,
			texture = "dragon-rostrum",
			show = addon.db.profile.showRostum,
		}
	}
	return pinSettings[pinType]
end


DragonridingJournalMapPinMixin = CreateFromMixins(MapCanvasPinMixin)

function DragonridingJournalMapPinMixin:OnLoad()
	self:SetScaleStyle()
	self:UseFrameLevelType("PIN_FRAME_LEVEL_TOPMOST")
end

function DragonridingJournalMapPinMixin:OnMouseEnter()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip_SetTitle(GameTooltip, self.tooltip, NORMAL_FONT_COLOR, true)
	GameTooltip:Show()
end

function DragonridingJournalMapPinMixin:OnMouseLeave()
	GameTooltip:Hide()
end