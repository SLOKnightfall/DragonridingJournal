local addonName, addon = ...
addon = LibStub("AceAddon-3.0"):GetAddon(addonName)
--_G[addonName] = {}
addon.Frame = LibStub("AceGUI-3.0")


local L = LibStub("AceLocale-3.0"):GetLocale(addonName)
local DragonFlyingZones = {2022, 2023, 2024, 2025, 2107, 2112}
local DragonFlyingSpells = {368896, 368899, 360954, 368901}
local MaxVigorAvailable = 6
local hasPlayed = {["max"]=true,["empty"]=false}

local Media = LibStub("LibSharedMedia-3.0")
local maxVigorWidget = 4216
local currentVigorWidget = 4217
local vigorRechargeRate = 4220

local textureKitRegions = {
	DecorLeft = "%s_decor",
	DecorRight = "%s_decor",
}

local decorTopPadding = {
	dragonriding_vigor = 8
}

local firstAndLastPadding = {
	dragonriding_vigor = -20
}

local widgetInfo= {
	scriptedAnimationEffectID=0,
	modelSceneLayer=0,
	numFullFrames=6,
	textureKit="dragonriding_vigor",
	tooltipLoc=6,
	fillMax=100,
	shownState=1,
	fillMin=0,
	numTotalFrames=6,
	widgetTag="",
	tooltip="Vigor recharges while grounded, whether mounted or not, and while dragonriding at high speeds.",
	widgetScale=0,
	orderIndex=0,
	layoutDirection=0,
	inAnimType=0,
	fillValue=0,
	hasTimer=false,
	outAnimType=0,
	widgetSizeSetting=0,
	pulseFillingFrame=true,
	displayCount = 6
}


--Derived from Blizzard_UIWidgetTemplateFillUpFrame.lua

DragonJournalVigorBarFrameMixin = {}

function DragonJournalVigorBarFrameMixin:OnDragStart()
	if addon.db.profile.LockSecondary then 
		return 
	else 
		self:StartMoving()
	end
end

function DragonJournalVigorBarFrameMixin:OnDragStop()
	addon:SaveFramePosition(self, "position")
end

function DragonJournalVigorBarFrameMixin:OnEnter()
	self:SetAlpha(1)
end

function DragonJournalVigorBarFrameMixin:OnLeave()
	self:SetAlpha(addon.db.profile.VigorAlpha / 100)
end


local container
function DragonJournalVigorBarFrameMixin:OnLoad()
	self:SetMovable(not addon.db.profile.LockSecondary)
	self:RegisterForDrag("LeftButton")
	self:SetAlpha(0)

	local color =  BLACK_FONT_COLOR
   	local r, g, b = color:GetRGB()
   	self.Counter.desc:SetTextColor(r, g, b, 1)
	local fontName, fontSize, fontFlags = self.Counter.desc:GetFont()
	self.Counter.desc:SetFont(fontName, 25, fontFlags)
	self.Counter:Hide()
	addon:RemoveVigorBorder()
	addon:ResizeVigorFrame()
	addon:LoadFramePosition(self,"position")
end
 
function DragonJournalVigorBarFrameMixin:OnUpdate()
	local mapID = C_Map.GetBestMapForUnit("PLAYER")
	if (tContains(DragonFlyingZones, mapID) or addon:AuraScan()) then
		if (not self.Ticker) then
			self:SetAlpha(1)
			self:Setup()
			self.Ticker = C_Timer.NewTicker(1, function() self:Setup() end);
		end
	else
		if (self.Ticker) then
			self.Ticker:Cancel();
			self.Ticker = nil;
			self:SetAlpha(0)
		end
	end
end

local function UpdateWidgetInfo()
	local numTotalFrames = C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo(maxVigorWidget)
	widgetInfo.numTotalFrames = ( numTotalFrames and #numTotalFrames.entries) or 0
	local fillValue = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo(vigorRechargeRate)
	widgetInfo.fillValue = (fillValue and fillValue.barValue) or 0

	widgetInfo.displayCount = widgetInfo.numTotalFrames
	widgetInfo.numFullFrames = DragonJournlVigorContainerFrame:GetNumFullFrames()
	widgetInfo.lastfillValue = widgetInfo.fillValue
	widgetInfo.pulseFillingFrame = not (widgetInfo.lastfillValue == widgetInfo.fillValue)
end

function DragonJournalVigorBarFrameMixin:Setup()
	self:SetShown(not addon.db.profile.HideSecondaryVigor)

	self.widgets.Setup(self.widgets, widgetInfo, self.widgets)

	local textureKit = "dragonriding_vigor"
	SetupTextureKitOnRegions("dragonriding_vigor", self.widgets, textureKitRegions, TextureKitConstants.SetVisibility, TextureKitConstants.UseAtlasSize)
	
	self.widgets.DecorLeft.topPadding = decorTopPadding[textureKit]
	self.widgets.DecorLeft:SetShown(not (addon.db.profile.SecondaryCompact or  addon.db.profile.HideBorder ) )
	self.widgets.DecorRight.topPadding = decorTopPadding[textureKit]
	self.widgets.DecorRight:SetShown(not (addon.db.profile.SecondaryCompact or  addon.db.profile.HideBorder) )

	self.widgets.fillUpFramePool:ReleaseAll()
	UpdateWidgetInfo()

	if addon.db.profile.SecondaryCompact then
		widgetInfo.displayCount = 1
		self:SetSize(50, 50)
		self.widgets:ClearAllPoints()
		self.widgets:SetPoint("CENTER")
		self.Counter:Show()

	else
		self:SetSize(300, 50)
		self.widgets:ClearAllPoints()
		self.widgets:SetAllPoints()
		self.Counter:Hide()
	end

	if not self.widgets.lastNumFullFrames then
		self.widgets.lastNumFullFrames = widgetInfo.numFullFrames
	end

	if not addon:AuraScan() then 
		if widgetInfo.fillValue == 0 then 
			if widgetInfo.numFullFrames < widgetInfo.numTotalFrames then 
				widgetInfo.numFullFrames = widgetInfo.numFullFrames + 1
			end

			self.widgets.lastNumFullFrames = widgetInfo.numFullFrames
		end

		if widgetInfo.numFullFrames == widgetInfo.numTotalFrames and addon.db.profile.HideWhenFull then 
			self:Hide()
		end
	end

	for index = 1, widgetInfo.displayCount do
		local fillUpFrame = self.widgets.fillUpFramePool:Acquire()

		local isFull = (index <= widgetInfo.numFullFrames)
		local isFilling = (index == (widgetInfo.numFullFrames + 1))
		local flashFrame = isFull and (widgetInfo.numFullFrames > self.widgets.lastNumFullFrames) and (index > self.widgets.lastNumFullFrames)
		local pulseFrame = isFilling and widgetInfo.pulseFillingFrame and (widgetInfo.fillValue < widgetInfo.fillMax)

		if addon.db.profile.SecondaryCompact then
			isFull = widgetInfo.numFullFrames == widgetInfo.numTotalFrames
			isFilling = widgetInfo.numFullFrames ~= widgetInfo.numTota
		end

		fillUpFrame:SetPoint("TOPLEFT", self.widgets, "TOPLEFT")
		fillUpFrame:Setup(self.widgets, widgetInfo.textureKit, isFull, isFilling, flashFrame, pulseFrame, widgetInfo.fillMin, widgetInfo.fillMax, widgetInfo.fillValue)
		fillUpFrame.layoutIndex = index

		if index == 1 then 
			self.Counter.desc:SetText(widgetInfo.numFullFrames )
		end

		if isFull then
			self.widgets:ApplyEffectToFrame(widgetInfo, self.widgets, fillUpFrame)

		else
			if fillUpFrame.effectController then
				fillUpFrame.effectController:CancelEffect()
				fillUpFrame.effectController = nil
			end
		end

		if index == 1 then
			fillUpFrame.leftPadding = firstAndLastPadding[widgetInfo.textureKit]

		elseif index == widgetInfo.numTotalFrames then
			fillUpFrame.rightPadding = firstAndLastPadding[widgetInfo.textureKit]
		end
	end

	self.widgets.lastNumFullFrames = widgetInfo.numFullFrames

	self.widgets:Layout()
	self:SetScale(addon.db.profile.VigorScale / 100)

	if addon:AuraScan() == true then
		self:SetAlpha(addon.db.profile.FlyingVigorAlpha / 100)

	else
		self:SetAlpha(addon.db.profile.VigorAlpha / 100)
	end

	addon.DataBroker:Update( widgetInfo.numFullFrames )
end

function addon:RemoveVigorBorder()
	local vigorBar = UIWidgetPowerBarContainerFrame:GetLayoutChildren()[1]

	if vigorBar and vigorBar.DecorLeft and vigorBar.DecorRight then
		if addon.db.profile.HideBorder == true then
			vigorBar.DecorLeft:SetAlpha(0)
			vigorBar.DecorRight:SetAlpha(0)
		else
			vigorBar.DecorLeft:SetAlpha(1)
			vigorBar.DecorRight:SetAlpha(1)
		end
	end
end

function addon:ResizeVigorFrame()
	UIWidgetPowerBarContainerFrame:SetScale(addon.db.profile.BlizzardVigorScale / 100)
	UIWidgetPowerBarContainerFrame:SetAlpha(addon.db.profile.BlizzardVigorAlpha / 100)
end



local hasPlayedAlert = false
function DragonJournalVigorBarFrameMixin:GetNumFullFrames()
	local info
	if not addon:AuraScan() then 
		return self.widgets.lastNumFullFrames
	else 
		info = #C_UIWidgetManager.GetTextureAndTextRowVisualizationInfo(currentVigorWidget).entries
	end

	local sound = Media:Fetch('font',addon.db.profile.Font_Type)

	if not info then return 0 end

	if info <= 1 and not hasPlayedAlert then
		if addon.db.profile.lowVigorAlert then 
			RaidNotice_AddMessage(RaidWarningFrame, L["LOW VIGOR"] , ChatTypeInfo["RAID_WARNING"])
		end

		if addon.db.profile.lowVigorAudioAlert then 
			PlaySoundFile(Media:Fetch("sound", addon.db.profile.lowVigorAlertSound))
		end
		hasPlayedAlert = true

	elseif info > 1 then 
		hasPlayedAlert = false
	end

	return info
end
