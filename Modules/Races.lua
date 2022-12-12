local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
--_G[addonName] = {}
addon.Frame = LibStub("AceGUI-3.0")

local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
-- speed optimizations (mostly so update functions are faster)
local _G = getfenv(0)
local date = _G.date
local abs = _G.abs
local min = _G.min
local max = _G.max
local floor = _G.floor
local mod = _G.mod
local tonumber = _G.tonumber
local gsub = _G.gsub
local raceQuestID
local RESET_RACE = 370007
local goalTime = 00
local goalMedal = "gold"
local raceData
local GOLD	= "|c00FFD200"
local WHITE =  "|cffFFFFFF";
local DRAGON_ZONES = {2022, 2023, 2024, 2025, 2107, 2112}

local f = CreateFrame("Frame")
f:RegisterEvent("START_TIMER")
f:RegisterEvent("QUEST_ACCEPTED")
f:SetScript("OnEvent", function(...) f:OnEvent(...) end)

function addon:GetRaceID()
	local map = C_Map.GetBestMapForUnit("player")
	if not map  or not tContains(DRAGON_ZONES, map) then return end
	local position = C_Map.GetPlayerMapPosition(map, "player")
	local raceData = addon.Data.races
	local zonedata = raceData[map]

	if not position or not zonedata then return false end

	local posX, posY = position:GetXY()
	for i, data in ipairs(zonedata) do
		if (posX >= (data.x - .02) and posX <= (data.x + .02)) and (posY >= (data.y - .02) and posY <= (data.y + .02)) then
			raceData = data
			return data
		end
	end

	raceData = nil
	return false
end

--", quest = 66885, av_quest = 0, achievementID
function addon:GetRaceTime(toastInfo)
	if not toastInfo or (toastinfo and toastInfo.uiTextureKit ~= "dragonflight-score") then return end

	DragonJournalRaceTimer:Stop() 
	local data = raceData

	if not data then return end

	local raceID = data.achievementID.gold
	local raceName = data.name
	local advQuestID = tonumber(data.av_quest)

	if not raceID then return end

	self.db.char.races[raceID] = self.db.char.races[raceID] or {} 
	local times = toastInfo.subtitle

	local run, _, best = string.match(times, "([%d%.]+).-([%d%.]+).-([%d%.]+)")
	if run and best then 
		if tonumber(raceQuestID) == advQuestID then
			self.db.char.races[raceID].advanced = best
			self.db.char.races[raceID].lastAdvanced = run
			print(L["Logged race for Advanced "]..raceName)

		else
			self.db.char.races[raceID].last = run
			self.db.char.races[raceID].best = best
			print(L["Logged race for "]..raceName)
		end
	end
end

function addon:GetRaceMedalTime(medal)
	local data = raceData
	local raceID = data.achievementID.gold
	local advQuestID = tonumber(data.av_quest)
	goalMedal = medal

	if not raceID then 
		raceTime = 00
		return "00" 
	end

	if tonumber(raceQuestID) == advQuestID then
		goalTime = tonumber(data["av_"..medal])
		return data["av_"..medal]
	else
		goalTime =  data[medal]
		return tonumber(data[medal])
	end
end

local ranks = { "gold", "silver", "bronze" }
local advRanks = { "av_gold", "av_silver", "av_bronze",  }

function addon:GetRaceMedal(raceData)
	local completedReg, completedAdv
	for _, rank in ipairs(ranks) do
		local completed = select(13, GetAchievementInfo(raceData[rank]))
		completedReg = (completed and rank) or false
		if completed then break end
	end

	for _, rank in ipairs(advRanks) do
		local completed = select(13, GetAchievementInfo(raceData[rank]))
		completedAdv = (completed and rank) or false
		if completed then break end

	end

	return completedReg, completedAdv
end

DragonridingJournal_TimerMixin = {}
function DragonridingJournal_TimerMixin:OnEnter()
end

function DragonridingJournal_TimerMixin:OnLeave()
	GameTooltip_Hide()
end

local combatTimer = 0
function DragonridingJournal_TimerMixin:OnLoad(isCombat)
	self:RegisterForDrag("LeftButton")
	self:Reset()
	self.isCombat = isCombat
	self:LoadPosition()
	self:SetPositionLock()
end


function DragonridingJournal_TimerMixin:OnHide()
	self:Reset(true)
end

function DragonridingJournal_TimerMixin:Reset(combat)
	if self.isCombat then 
		combatTimer = 0
	end

	self.playing = false
	self.timer = 0
	self:SetScript("OnUpdate", nil)
	self:Update()
	f:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	DragonJournalRaceGoal.GoalTime:SetFormattedText(WHITE.."00")
	goalTime = 00
	goalMedal = "gold"
end

function DragonridingJournal_TimerMixin:Start(data)
	self.playing = true
	self.paused = false
	self:SetScript("OnUpdate", 	self.OnUpdate  )
	self:SetMedalTime()
	f:RegisterEvent("UNIT_SPELLCAST_SENT")
end

function DragonridingJournal_TimerMixin:SetMedalTime()
	DragonJournalRaceGoal.GoalTime:SetFormattedText( GOLD..addon:GetRaceMedalTime("gold"))
end


function DragonridingJournal_TimerMixin:ScorePause()
	self.paused = true
	self.playing = false
end


function DragonridingJournal_TimerMixin:Stop()
	self.playing = false
	raceData = nil
	self:SetScript("OnUpdate", nil)

	f:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
end

function DragonridingJournal_TimerMixin:Update()
	local timer
	if self.timer <= 1 then 
		timer = self.timer
	else
		timer = self.timer-1
	end
	 
	local second = floor(timer) 
	local millisecond = (timer - floor(timer)) * 1000
	self.StopwatchTickerSecond:SetFormattedText(STOPWATCH_TIME_UNIT, second)
	self.StopwatchTickerMillisecond:SetFormattedText("%03d", millisecond)

	if tonumber(timer) > tonumber(goalTime)  and goalMedal == "gold" then
		DragonJournalRaceGoal.GoalTime:SetFormattedText(WHITE..addon:GetRaceMedalTime("silver"))
	end
end

function DragonridingJournal_TimerMixin:OnUpdate(elapsed)
	self.timer = self.timer + elapsed
	self:Update()
end

function DragonridingJournal_TimerMixin:IsPlaying()
	return self.playing
end

function DragonridingJournal_TimerMixin:OnDragStart()
	if addon.db.profile.LockSecondary then 
		return 
	else 
		self:StartMoving()
	end
end

function DragonridingJournal_TimerMixin:SetPositionLock()
	DragonJournalRaceTimer:SetShown(not addon.db.profile.lockTimer)
	DragonJournalRaceTimer:SetMovable(not addon.db.profile.lockTimer)
end

function DragonridingJournal_TimerMixin:LoadPosition()
	if not addon.db.profile.timerPosition or addon.db.profile.timerPosition == true or not addon.db.profile.timerPosition.x then 
		self:ClearAllPoints()
		self:SetPoint("BOTTOM", "UIWidgetPowerBarContainerFrame", "TOP", 0, 25)
	else 
		addon:LoadFramePosition(self,"timerPosition")
	end
end

function DragonridingJournal_TimerMixin:SavePosition()
	addon:SaveFramePosition(self, "timerPosition")
	self:StopMovingOrSizing()
end

function f:OnEvent(self, event, ...)	
	if event == "START_TIMER" then 
		f:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	elseif event == "CHAT_MSG_MONSTER_SAY" then 
		if  addon.db.profile.raceTimer then 
			local chatPlayer = select(5, ...)
			local text =  ...
			local playerName = GetUnitName("player")
			local match = string.find(text, READY)
			raceData =  addon:GetRaceID()
			if raceData and chatPlayer == playerName then
				if string.find(text, READY) then
					DragonJournalRaceTimer:Reset() 	
					DragonJournalRaceTimer:Show()
					DragonJournalRaceTimer:SetMedalTime(raceData)
					if not addon:IsHooked(EventToastManagerFrame, "OnShow") then
						addon:SecureHookScript(EventToastManagerFrame, "OnShow", function(...) addon:GetRaceTime(EventToastManagerFrame.currentDisplayingToast.toastInfo) end, true)
					end
					
				elseif string.find(text, GO) then
					DragonJournalRaceTimer:Reset() 	
					DragonJournalRaceTimer:Show()
					DragonJournalRaceTimer:Start(raceData)  	
				else
					--DragonJournalRaceTimer:Hide()
				end
			end
		else
		end

	elseif event == "QUEST_ACCEPTED" then
		if addon:GetRaceID() then 
			f:RegisterEvent("QUEST_REMOVED")
			raceQuestID = tonumber(...)
		end

	elseif event == "UNIT_SPELLCAST_SENT" then
		local spellID = select(4, ...)
		if spellID == RESET_RACE then
			DragonJournalRaceTimer:Hide()
			DragonJournalRaceTimer:Stop() 
		end

	elseif event == "QUEST_REMOVED" then
		local questID =  ...
		if questID == raceQuestID then
			DragonJournalRaceTimer:Hide()
			DragonJournalRaceTimer:Stop()
			addon:Unhook(EventToastManagerFrame, "OnShow")
		end
	end
end