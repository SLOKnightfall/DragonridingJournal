
local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
local AceGUI = LibStub("AceGUI-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local frames = {} 
addon.fontStrings = {}

local function SetPin(pin)
	PlaySound(SOUNDKIT.UI_MAP_WAYPOINT_CLICK_TO_PLACE)
	local uiMapPoint = UiMapPoint.CreateFromCoordinates(pin.zone, pin.data.x, pin.data.y)
	C_Map.SetUserWaypoint(uiMapPoint)
end

local f1={}
local zonenames = {[2025] = L["Thaldraszus"], [2024] = L["Azure Span"],[2023] = L["Ohn'Ahran Plains"], [2022] = L["The Waking Shores"]}
local function CreateUpgradeFrame(parent, zone, data, index, mapid)
	local infoHeader
	if not f1[index] then
		infoHeader = CreateFrame("FRAME", "DJ_Upgrades"..zone..index, parent, "DragonridingJournalInfoTemplate")
	else
		infoHeader = f1[index]
		infoHeader:Show()
	end

	infoHeader:SetPoint("TOPLEFT", 25, -50)
	infoHeader:SetPoint("TOPRIGHT", -5, -50)
	infoHeader.button.icon2:Hide()
	infoHeader.button.icon3:Hide()
	infoHeader.button.icon4:Hide() 
	infoHeader.button.icon1:Show()
	

	infoHeader.button.icon1:SetScript("OnMouseDown", function(self) SetPin(infoHeader.button.icon1) end)
	infoHeader.button.icon1.data = data
	infoHeader.button.icon1.zone = mapid

	local textRightAnchor = infoHeader.button.icon2
	--infoHeader.button.title:ClearAllPoints()
	infoHeader.button.title:SetPoint("LEFT", textRightAnchor, "RIGHT", 0, 0)
	infoHeader:Show()
	infoHeader.button.title:Show()
	infoHeader.button.title:SetText(zonenames[zone] or zone)

	infoHeader.button.abilityIcon:Hide()
	local text = ""

	local achievementIDs = data.achievementID
	if type(achievementIDs) == "number" then
		local completed = select(13, GetAchievementInfo(achievementIDs))
		infoHeader.button.title:SetPoint("LEFT", infoHeader.button.icon3, "RIGHT", 0, 0)

		infoHeader.button.icon3:Show()
		infoHeader.button.icon3.icon:SetAtlas("ParagonReputation_Checkmark") 

	else
		local completedReg, completedAdv = addon:GetRaceMedal(achievementIDs)
		infoHeader.button.icon2:Show()
		infoHeader.button.icon3:Show()
		infoHeader.button.icon2.icon:SetTexture("Interface\\Challenges\\challenges-metalglow") 
		infoHeader.button.icon3.icon:SetTexture("Interface\\Challenges\\challenges-metalglow") 

		if completedReg and completedReg == "gold" then
			infoHeader.button.icon3.icon:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Gold")	
		elseif completedReg and completedReg == "silver" then
			infoHeader.button.icon3.icon:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Silver")
		elseif completedReg and completedReg == "bronze" then
			infoHeader.button.icon3.icon:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Bronze")
		end


		if completedAdv and completedAdv == "av_gold" then
			infoHeader.button.icon2.icon:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Gold")
			infoHeader.button.icon4:Show() 
 
		elseif completedAdv and completedAdv == "av_silver" then
			infoHeader.button.icon2.icon:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Silver") 
			infoHeader.button.icon4:Show() 

		elseif completedAdv and completedAdv == "av_bronze" then
			infoHeader.button.icon2.icon:SetTexture("Interface\\Challenges\\ChallengeMode_Medal_Bronze") 
			infoHeader.button.icon4:Show() 

		elseif not completedAdv then

		end	
	end

	if data.silver then 
		local raceID = data.achievementID.gold
		local raceData = addon.db.char.races[raceID]
		local LastRace = (raceData and raceData.last) or "--"
		local BestRace = (raceData and raceData.best) or "--"
		local LastAdvancedRace = (raceData and raceData.lastAdvanced) or "--"
		local BestAdvancedRace = (raceData and raceData.advanced) or "--"
		text = text..L["Location: "]..(data.x * 100)..",  "..(data.y * 100).."\n\n"

		text = text..L["Standard Run Times: "].."\n"
		text = text..L["Last Run: "]..LastRace.."\n"
		text = text..L["Best Run: "]..BestRace .."\n\n"
	
		text = text..L["Silver Time: "]..data.silver.."\n"
		text = text..L["Gold Time: "]..data.gold.."\n\n"
		if (data and data.av_gold) then 
			text = text..L["Advanced Run Times: "].."\n"
			text = text..L["Last Run: "]..LastAdvancedRace.."\n"
			text = text..L["Best Run: "]..BestAdvancedRace .."\n\n"

			text = text..L["Silver Time: "]..((data and data.av_silver) or "--").."\n"
			text = text..L["Gold Time: "]..((data and data.av_gold) or "--").."\n"
		else
			infoHeader.button.icon3.icon:Hide()
		end
	else
		text = text..data.name..": "..(data.x * 100)..",  "..(data.y * 100).."\n"
	end

	infoHeader.description:SetText(text)
	infoHeader.description:SetWidth(infoHeader:GetWidth() - 30)
	infoHeader:SetHeight(infoHeader.description:GetHeight() + 55)
	infoHeader:Show()
 	f1[index] = infoHeader	
	return infoHeader
end

local function CreateRostrumFrame(parent, data, index)
	local infoHeader = CreateFrame("FRAME", "DJ_Upgrades"..index, parent, "DragonridingJournalInfoTemplate")
	--local color = addon.db.profile.Font_Color

	infoHeader:SetPoint("TOPLEFT", 25, -50)
	infoHeader:SetPoint("TOPRIGHT", 25, -50)

	infoHeader.button.icon1:Hide()
	infoHeader.button.icon2:Hide()
	infoHeader.button.icon3:Hide()
	infoHeader.button.icon4:Hide() 

	
	local textRightAnchor = infoHeader.button.icon1
	infoHeader.button.title:SetPoint("RIGHT", textRightAnchor, "LEFT", -5, 0)
	infoHeader:Show()
	infoHeader.button.title:Show()
	infoHeader.button.title:SetText(L["Rostrum of Transformation"])

		local known = true
		if known then
			--infoHeader.button.title:SetTextColor(0,1,0)
		else
			--infoHeader.button.title:SetTextColor(1,0,0)

		end
		--infoHeader.button.abilityIcon:SetTexture(icon)
		infoHeader.button.abilityIcon:Hide()
		local text = ""
		for zone, zonedata in pairs(data) do
			text = text..zonenames[zone]..": "..(zonedata[1].x * 100)..","..(zonedata[1].y * 100).."\n"
		end
		infoHeader.description:SetText(text)
		infoHeader.description:SetWidth(infoHeader:GetWidth() - 30)
		infoHeader:SetHeight(infoHeader.description:GetHeight() + 55)
	infoHeader:Show()
	return infoHeader
end

local f3 = {}
local function CreateUpgradeFrame3(parent, data, index)
	local infoHeader
	if not f3[index] then
		infoHeader = CreateFrame("FRAME", "DJ_UpgradesX"..index, parent, "DragonridingJournalInfoTemplate")
	else
		infoHeader = f3[index]
	end
	--local color = addon.db.profile.Font_Color

	infoHeader:SetPoint("TOPLEFT", 25, -50)
	infoHeader:SetPoint("TOPRIGHT", 25, -50)

	infoHeader.button.icon1:Hide()
	infoHeader.button.icon2:Hide()
	infoHeader.button.icon3:Hide()
	infoHeader.button.icon4:Hide() 

	local textRightAnchor = infoHeader.button.icon1
	infoHeader.button.title:SetPoint("RIGHT", textRightAnchor, "LEFT", -5, 0)
	infoHeader:Show()
	infoHeader.button.title:Show()
	infoHeader.button.title:SetText(data.type)

		local known = true
		if known then
			--infoHeader.button.title:SetTextColor(0,1,0)
		else
			--infoHeader.button.title:SetTextColor(1,0,0)

		end
		--infoHeader.button.abilityIcon:SetTexture(icon)
		infoHeader.button.abilityIcon:Hide()
		local text = "*"
		for i, zonedata in ipairs(data.data) do
			text = text..zonedata.."\n*"
		end
		infoHeader.description:SetText(text)
		infoHeader.description:SetWidth(infoHeader:GetWidth() - 30)
		infoHeader:SetHeight(infoHeader.description:GetHeight() + 55)
	infoHeader:Show()
	 f3[index] = infoHeader	
	return infoHeader
end

local function CreateStatsFrame(parent)
	local f = CreateFrame("Frame", nil, frames.tg.info.statsScroll.child) 
	local color = 0,0,0 --addon.db.profile.Font_Color
	local dragonInfo = addon.db.char.dragons[1]

	frames.tg.info.stats = f
	--addon.Stats.Frame = f
	f:SetPoint("TOPLEFT")
	f:SetPoint("BOTTOMRIGHT")
	f:Show()

	f.banner = f:CreateTexture(nil, "OVERLAY")
	f.banner:SetAtlas("bonusobjectives-title-bg")
	f.banner:SetPoint("TOPLEFT", 25, -3)
	f.banner:SetPoint("TOPRIGHT", 25, 3)
	f.banner:SetHeight(30)

	f.desc = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	f.desc:SetText(dragonInfo.name)
	f.desc:SetPoint("CENTER", f.banner, 0, 3)
	f.desc:SetJustifyH("CENTER")

	f.currentBG = CreateFrame("FRAME", "TDJ_CurrentStats", frames.tg.info.statsScroll.child, "DragonridingJournalInfoTemplate")
	f.currentBG:ClearAllPoints()
	f.currentBG:SetPoint("TOPLEFT", 25, -50)
	f.currentBG:SetPoint("TOPRIGHT", 25, -50)

	f.currentBG.button.icon1:Hide()
	f.currentBG.button.icon2:Hide()
	f.currentBG.button.icon3:Hide()
	f.currentBG.button.icon4:Hide()
	local textRightAnchor = f.currentBG.button.icon1

	f.currentBG.button.title:SetPoint("LEFT", 15, 0)
	f.currentBG.button.title:SetPoint("RIGHT", textRightAnchor, "LEFT", -5, 0)
	f.currentBG.button.title:SetText(L["Dragon Info:"])
	f.currentBG.description:SetPoint("TOPRIGHT", -15, 0)
	f.currentBG.description:SetPoint("BOTTOMLEFT", -5, 0)

	f.dragonName = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonName)
	f.dragonName:SetPoint("TOPLEFT", 45, -78)
	f.dragonName:SetJustifyH("CENTER")
	f.dragonName:SetText(L["Name: "]..dragonInfo.name)

	f.dragonTitle = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonTitle)
	f.dragonTitle:SetPoint("TOPLEFT", f.dragonName, "BOTTOMLEFT", 0, -5)
	f.dragonTitle:SetJustifyH("CENTER")
	f.dragonTitle:SetText(L["Title: "]..dragonInfo.title)

	f.dragonAge = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonAge)
	f.dragonAge:SetPoint("TOPLEFT", f.dragonTitle, "BOTTOMLEFT", 0, -5)
	f.dragonAge:SetJustifyH("CENTER")
	f.dragonAge:SetText(L["Age: "]..dragonInfo.age)

	f.dragonColor = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonColor)
	f.dragonColor:SetPoint("TOPLEFT", f.dragonAge, "BOTTOMLEFT", 0, -5)
	f.dragonColor:SetJustifyH("CENTER")
	f.dragonColor:SetText(L["Favorite Color: "]..dragonInfo.color)

	f.dragonFood = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonFood)
	f.dragonFood:SetPoint("TOPLEFT", f.dragonColor, "BOTTOMLEFT", 0, -5)
	f.dragonFood:SetJustifyH("CENTER")
	--f.dragonFood:SetText(L["Favorite Food: "]..dragonInfo.food)

	f.dragonLikes = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonLikes)
	f.dragonLikes:SetPoint("TOPLEFT", f.dragonFood, "BOTTOMLEFT", 0, -5)
	f.dragonLikes:SetJustifyH("CENTER")
	f.dragonLikes:SetText(L["Likes: "]..dragonInfo.likes)

	f.dragonDislikes = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonDislikes)
	f.dragonDislikes:SetPoint("TOPLEFT", f.dragonLikes, "BOTTOMLEFT", 0, -5)
	f.dragonDislikes:SetJustifyH("CENTER")
	f.dragonDislikes:SetText(L["Dislikes: "]..dragonInfo.dislikes)

	f.dragonMood = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonMood)
	f.dragonMood:SetPoint("TOPLEFT", f.dragonDislikes, "BOTTOMLEFT", 0, -5)
	f.dragonMood:SetJustifyH("CENTER")
	f.dragonMood:SetText(L["Current Mood: "]..dragonInfo.mood)

	f.dragonQuote = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.dragonQuote)
	f.dragonQuote:SetPoint("TOPLEFT", f.dragonMood, "BOTTOMLEFT", 0, -5)
	f.dragonQuote:SetJustifyH("CENTER")
	f.dragonQuote:SetText(L["Favorite Quote: "]..dragonInfo.quote)


	f.currentBG:SetPoint("BOTTOMLEFT", f.dragonQuote,"BOTTOMLEFT",  25, 0)
	f.currentBG:SetPoint("BOTTOMRIGHT", f.dragonQuote,"BOTTOMRIGHT",  25, 0)

	f.totalsBG = CreateFrame("FRAME", "TDJ_TotalStats", frames.tg.info.statsScroll.child, "DragonridingJournalInfoTemplate")
	f.totalsBG:ClearAllPoints()
	f.totalsBG:SetPoint("TOPLEFT", f.currentBG, "BOTTOMLEFT", 0 ,-25)
	f.totalsBG:SetPoint("TOPRIGHT", f.currentBG, "BOTTOMRIGHT", 0 ,-25)

	f.totalsBG.button.icon1:Hide()
	f.totalsBG.button.icon2:Hide()
	f.totalsBG.button.icon3:Hide()
	f.totalsBG.button.icon4:Hide()

	local textRightAnchor = f.totalsBG.button.icon1
	f.totalsBG.button.title:SetPoint("LEFT", 15, 0)
	f.totalsBG.button.title:SetPoint("RIGHT", textRightAnchor, "LEFT", -5, 0)

	f.totalsBG.button.title:SetText(L["STATS:"])
	f.totalsBG.description:SetPoint("TOPRIGHT", -15, 0)
	f.totalsBG.description:SetPoint("BOTTOMLEFT", -5, 0)

	f.totalMounted = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, (dragonInfo.mounted or 0))
	f.totalMounted:SetPoint("TOPLEFT", f.currentBG, "BOTTOMLEFT", 20, -55)
	f.totalMounted:SetJustifyH("CENTER")
	local mounted = 0 --addon.db.char.mounted[addon:GetCurrentDragon()] or 0
	f.totalMounted:SetText(L["Times Mounted: "]..mounted)

	f.totalpotsCount = f:CreateFontString(nil, "OVERLAY", "GameFontBlackMedium")
	tinsert(addon.fontStrings, f.totalpotsCount)
	f.totalpotsCount:SetPoint("TOPLEFT", f.totalMounted, "BOTTOMLEFT", 0, -5)
	f.totalpotsCount:SetJustifyH("CENTER")

	f.totalsBG:SetPoint("BOTTOMLEFT", f.totalpotsCount,"BOTTOMLEFT",  25, 0)
	f.totalsBG:SetPoint("BOTTOMRIGHT", f.totalpotsCount,"BOTTOMRIGHT",  25, 0)
	--addon.Stats:UpdateStats()
end 

local listFrame
local function CreateListFrame(parent, scrollchild, frameData, title)
	local f
	if not listFrame then
		f = CreateFrame("Frame", nil, scrollchild) 
		f.banner = f:CreateTexture(nil, "OVERLAY")
		f.desc = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	else 
		f =	listFrame
	end

	f.zonetitle = f.zonetitle or {}

	for i=1, #f do
		f[i]:Hide()
	end

	for i=1, #f.zonetitle do
		f.zonetitle[i]:Hide()
	end

	f:SetPoint("TOPLEFT")
	f:SetPoint("BOTTOMRIGHT")
	f:Show()

	f.banner:SetAtlas("bonusobjectives-title-bg")
	f.banner:SetPoint("TOPLEFT", 25, -3)
	f.banner:SetPoint("TOPRIGHT", 25, 3)
	f.banner:SetHeight(30)

	f.desc:SetText(title)
	f.desc:SetPoint("CENTER", f.banner, 0, 3)
	f.desc:SetJustifyH("CENTER")


	local index = 1
	local raceIndex = 1

	for zone, data in pairs(frameData) do
		if not f.zonetitle[index] then
			f.zonetitle[index] = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
		end

		f.zonetitle[index]:Show()
		f.zonetitle[index]:SetText(zonenames[zone] or zone)

		if index == 1 then 
			f.zonetitle[index]:SetPoint("TOP", f.banner,"BOTTOM", 0, -15)
		else
			f.zonetitle[index]:SetPoint("TOP", f[raceIndex-1],"BOTTOM", 0, -15)
		end

		local first = true
		for race, racedata in ipairs(data) do
			f[raceIndex] = CreateUpgradeFrame(f, racedata.name, racedata, raceIndex, zone)

			if first then 
				f[raceIndex]:SetPoint("TOPLEFT", f.zonetitle[index],"BOTTOM",-150, -15)
				f[raceIndex]:SetPoint("TOPRIGHT", f.zonetitle[index],"BOTTOM", 140, 15)
				first = false
			else
				f[raceIndex]:SetPoint("TOPLEFT", f[raceIndex - 1], "BOTTOMLEFT",0,-15 )
				f[raceIndex]:SetPoint("TOPRIGHT", f[raceIndex - 1], "BOTTOMRIGHT",0,-15  )
			end

			raceIndex = raceIndex + 1
		end

		index = index + 1
	end

	listFrame = f

end

local function CreateListFrame2(parent, scrollchild, frameData)
	local f = CreateFrame("Frame", nil, scrollchild) 

	f:SetPoint("TOPLEFT")
	f:SetPoint("BOTTOMRIGHT")
	f:Show()

	f.banner = f:CreateTexture(nil, "OVERLAY")
	f.banner:SetAtlas("bonusobjectives-title-bg")
	f.banner:SetPoint("TOPLEFT", 25, -3)
	f.banner:SetPoint("TOPRIGHT", 25, 3)
	f.banner:SetHeight(30)

	f.desc = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	f.desc:SetText(L["Rostrum Locations"])
	f.desc:SetPoint("CENTER", f.banner, 0, 3)
	f.desc:SetJustifyH("CENTER")

	local index = 1
	f[index] = CreateRostrumFrame(f,  frameData, index)
	f[index]:SetPoint("TOPLEFT", 25, -45)
	f[index]:SetPoint("TOPRIGHT", 25, -45)

end

local upgradepool
local function CreateListFrame3(parent, scrollchild, frameData)
	local f
	if not upgradepool then
		f = CreateFrame("Frame", nil, scrollchild) 
	f.banner = f:CreateTexture(nil, "OVERLAY")
	f.desc = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	else 
	f =	upgradepool
	end
	
	f:SetPoint("TOPLEFT")
	f:SetPoint("BOTTOMRIGHT")
	f:Show()

	f.banner:SetAtlas("bonusobjectives-title-bg")
	f.banner:SetPoint("TOPLEFT", 25, -3)
	f.banner:SetPoint("TOPRIGHT", 25, 3)
	f.banner:SetHeight(30)

	f.desc:SetText(L["Upgrades"])
	f.desc:SetPoint("CENTER", f.banner, 0, 3)
	f.desc:SetJustifyH("CENTER")

	local index = 1
	for _, data in ipairs(frameData) do
		--for _, data in ipairs(data)do
		f[index] = CreateUpgradeFrame3(f, data, index)

		if index == 1 then 
			f[index]:SetPoint("TOPLEFT", 25, -45)
			f[index]:SetPoint("TOPRIGHT", 25, -45)
		else
			f[index]:SetPoint("TOPLEFT", f[index - 1], "BOTTOMLEFT" )
			f[index]:SetPoint("TOPRIGHT", f[index - 1], "BOTTOMRIGHT" )
		end
		index = index + 1
	end
upgradepool = f
end		
DragonridingJournalTabMixin = {}

function DragonridingJournalTabMixin:OnLoad()
	local tab = self:GetID()

	if tab == 1 then 
		self.tooltip = L["Renewed Proto Drake"]
	elseif tab == 2 then 
		self.tooltip = L["Windborne Velocidrake"]
	elseif tab == 3 then 
		self.tooltip = L["Cliffside Wylderdrake"]
	elseif tab == 4 then 
		self.tooltip = L["Highland Drake"]
	elseif tab == 5 then 
		self.tooltip = L["Rostrum of Transformation Locations"]
	elseif tab == 6 then 
		self.tooltip = L["Glyph Locations"]
	elseif tab == 11 then 
		self.tooltip = L["Races"]
	else
		self.tooltip = L["Upgrades"]
	end
end


function DragonridingJournalTabMixin:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_CURSOR_RIGHT")
	GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true)
end


local function DragonridingJournalFrame_TabClicked(self, button)
	local tabType = self:GetID()
	addon.SetTab(tabType)
	PlaySound(SOUNDKIT.IG_ABILITY_PAGE_TURN)
end


function DragonridingJournalTabMixin:OnClick()
	DragonridingJournalFrame_TabClicked(self, button)
end


DragonridingJournalScrollBarMixin = {}
function DragonridingJournalScrollBarMixin:OnLoad()
	self.trackBG:SetVertexColor(ENCOUNTER_JOURNAL_SCROLL_BAR_BACKGROUND_COLOR:GetRGBA())
end


function addon.initTourGuide()
	local f = DragonridingJournalFrame --CreateFrame("Frame", "DragonridingJournalFrame", UIParent, "DragonridingJournalFrameTemplate")
	frames.tg = f
	tinsert(UISpecialFrames,"DragonridingJournalFrame")

	CreateStatsFrame(f, 1)
	CreateListFrame(f,frames.tg.info.glyphScroll.child, addon.Data.glyphs, L["Glyphs"])
	CreateListFrame2(f,frames.tg.info.rostrumScroll.child, addon.Data.Rostrum)
	CreateListFrame3(f,frames.tg.info.ProtoUpgradeScrollFrame.child, addon.Data.ProtoUnlock)
	CreateListFrame(f,frames.tg.info.glyphScroll.child, addon.Data.races)
	addon.SetTab(1)

	f:SetScript("OnShow", function()
	end)
end
	

--PlayerChoiceFrame.Option1
--CONFIRM_PURCHASE_NONREFUNDABLE_ITEM

local DJ_Tabs = {}
DJ_Tabs[1] = {frame = "statsScroll", button = "protoTab"}
DJ_Tabs[2] = {frame = "statsScroll", button = "VelocidrakeTab"}
DJ_Tabs[3] = {frame = "statsScroll", button = "CliffsideTab"}
DJ_Tabs[4] = {frame = "statsScroll", button = "HighlandTab"}
DJ_Tabs[5] = {frame = "rostrumScroll", button = "RostrumTab"}
DJ_Tabs[6] = {frame = "glyphScroll", button = "GlyphTab"}
DJ_Tabs[7] = {frame = "ProtoUpgradeScrollFrame", button = "protoUpgradeTab"}
DJ_Tabs[8] = {frame = "statsScroll", button = "VelocidrakeUpgradeTab"}
DJ_Tabs[9] = {frame = "statsScroll", button = "CliffsideUpgradeTab"}
DJ_Tabs[10] = {frame = "statsScroll", button = "HighlandUpgradeTab"}
DJ_Tabs[11] = {frame = "glyphScroll", button = "RaceTab"}
local creatureDisplayID
local rareCreatureDisplayID
local function SetDefaultModel(tabType)
	if tabType == 1 or tabType == 7 then 
		addon.DisplayCreature(194034)
	elseif tabType == 2 or tabType == 8 then 
		addon.DisplayCreature(194549)
		elseif tabType == 3 or tabType == 9 then 
		addon.DisplayCreature(194521)
		elseif tabType == 4 or tabType == 10  then 
		addon.DisplayCreature(194705)
		--addon.DisplayCreature(rareCreatureDisplayID.encounterID)
	else
		--addon.DisplayCreature(creatureDisplayID.encounterID)

	end
end

function addon.SetTab(tabType)
	local info = frames.tg.info
	local dragonindex = tabType
	if tabType > 4 then
		dragonindex = dragonindex - 6
	end

	for key, data in pairs(DJ_Tabs) do
		if key == tabType then
			info[data.frame]:Show()
			info[data.button].selected:Show()
			info[data.button].unselected:Hide()
			info[data.button]:LockHighlight()
		else
			info[data.frame]:Hide()
			info[data.button].selected:Hide()
			info[data.button].unselected:Show()
			info[data.button]:UnlockHighlight()
		end
	end

	if tabType == 1  or tabType == 2 or tabType == 3 or tabType == 4 then 
		info.statsScroll:Show()
		info.model:Show()
		addon:UpdateStatsWindow(dragonindex)
		info.ProtoUpgradeScrollFrame:Hide()
	elseif tabType == 8  or tabType == 9 or tabType == 10 or tabType == 7 then
		info.statsScroll:Hide()
		info.ProtoUpgradeScrollFrame:Show()
		--DJ_OrderHallTalentFrame:Hide()
	end
	if tabType == 8  then
		CreateListFrame3(f,frames.tg.info.ProtoUpgradeScrollFrame.child, addon.Data.WindborneUnlocks)
elseif tabType == 9  then
			CreateListFrame3(f,frames.tg.info.ProtoUpgradeScrollFrame.child, addon.Data.CliffsideUnlocks)

elseif tabType == 10  then
			CreateListFrame3(f,frames.tg.info.ProtoUpgradeScrollFrame.child, addon.Data.HighlandUnlocks)

elseif tabType == 7 then
		CreateListFrame3(f,frames.tg.info.ProtoUpgradeScrollFrame.child, addon.Data.ProtoUnlock)

elseif tabType == 6 then
	CreateListFrame(f,frames.tg.info.glyphScroll.child, addon.Data.glyphs, L["Glyphs"])
	info.glyphScroll:Show()
elseif tabType == 11 then
	CreateListFrame(f,frames.tg.info.glyphScroll.child, addon.Data.races, L["Races"])
	info.glyphScroll:Show()
	end

	SetDefaultModel(tabType)
end


local defaultsDisplay = {
	[95004] = {95004, {}, 362} ,
	[152253] = {99060, {}, 65} ,
}
 
function addon.DisplayCreature(linkID)
	local modelScene = frames.tg.info.model
	local mountID = C_MountJournal.GetMountFromItem(tonumber(linkID))
	if not mountID then return end
	local creatureDisplayID, _, _, isSelfMount, _, modelSceneID, animID, spellVisualKitID, disablePlayerMountPreview = C_MountJournal.GetMountInfoExtraByID(mountID)
	
	modelScene:ClearScene()
	modelScene:SetViewInsets(0, 0, 0, 0)
	
	local forceEvenIfSame = true
	modelScene:TransitionToModelSceneID(modelSceneID, CAMERA_TRANSITION_TYPE_IMMEDIATE, CAMERA_MODIFICATION_TYPE_MAINTAIN, forceEvenIfSame)
	
	local mountActor = modelScene:GetActorByTag("unwrapped")
	if mountActor then
		mountActor:SetModelByCreatureDisplayID(creatureDisplayID)
	end
	--modelScene.imageTitle:SetText(L[tostring(UnitID)])
end


function addon.ToggleGuide()
	if DragonridingJournalFrame:IsShown() then
		DragonridingJournalFrame:Hide()
	else
		DragonridingJournalFrame:Show()
	end
end


function DragonridingJournalFrame_Toggle()
	addon.ToggleGuide()
end


local LISTWINDOW
function addon.ToggleLinkWindow()
	if LISTWINDOW then LISTWINDOW:Hide() end
	local f = AceGUI:Create("Window")
	f:SetCallback("OnClose",function(widget) AceGUI:Release(widget) end)
	f:SetLayout("Fill")
	f:EnableResize(false)
	f:SetHeight(150)
	f:SetWidth(350)
	LISTWINDOW = f

	_G["DJ_LinkWindow"] = f.frame
	tinsert(UISpecialFrames, "DJ_LinkWindow")

	local MultiLineEditBox = AceGUI:Create("MultiLineEditBox")
	MultiLineEditBox:SetFullHeight(true)
	MultiLineEditBox:SetFullWidth(true)
	MultiLineEditBox:SetLabel("")
	MultiLineEditBox:DisableButton(button)
	MultiLineEditBox.button:Hide()
	MultiLineEditBox:SetText((L["BOSSLINK"]):format(creatureDisplayID.encounterID).."\n"..L["GUIDELINK"])
	f:AddChild(MultiLineEditBox)
end


local DragonFlyingSpells = {368896, 368899, 360954, 368901}

function addon:UpdateStatsWindow(dragonID)
	local f = frames.tg.info.stats
	local dragonInfo = addon.db.char.dragons[dragonID]

	f.desc:SetText(dragonInfo.name)
	f.dragonName:SetText(L["Name: "]..dragonInfo.name)
	f.dragonTitle:SetText(L["Title: "]..dragonInfo.title)
	f.dragonAge:SetText(L["Age: "]..dragonInfo.age)
	f.dragonColor:SetText(L["Favorite Color: "]..dragonInfo.color)
	f.dragonFood:SetText(L["Favorite Food: "].."Gnomes")
	f.dragonLikes:SetText(L["Likes: "]..dragonInfo.likes)
	f.dragonDislikes:SetText(L["Dislikes: "]..dragonInfo.dislikes)
	f.dragonMood:SetText(L["Current Mood: "]..dragonInfo.mood)
	--print(addon.db.char.mounted[DragonFlyingSpells[dragonID]])
	--f.totalMounted = addon.db.char.mounted[DragonFlyingSpells[dragonID]]
	--f.dragonQuote:SetText(L["Favorite Quote: "]..dragonInfo.quote)
	--f.totalMounted:SetText(L["Times Mounted: "]..dragonInfo.mounted)
end

local Media = LibStub("LibSharedMedia-3.0")
function addon:UpdateFonts()
	local fontStrings = addon.fontStrings
	local color = addon.db.profile.Font_Color
	local font = Media:Fetch('font',addon.db.profile.Font_Type)
	local Font_Size = addon.db.profile.Font_Size

	for i, f in ipairs(fontStrings) do
		f:SetTextColor(color.r,color.g, color.b )
		local fon
   		f:SetFont(font, Font_Size)
   		--print(f:GetFont())
    end
end

local pindata = {}
DragonridingJournalSectionIconMixin = {}

function DragonridingJournalSectionIconMixin:OnLoad()
	self.data = {}
end