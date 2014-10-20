local addon, ns = ...

local O3 = O3
local tableInsert = table.insert
local stringGsub = string.gsub
local GetTime = GetTime




local handler = O3:module({
	name = 'Action',
	weight = 99,
	readable = 'Action Bars',
	bars = {},
	barDict = {},
	events = {
		ACTIONBAR_UPDATE_COOLDOWN = true,
		ACTIONBAR_UPDATE_USABLE = true,
		SPELL_UPDATE_USABLE = true,
		ACTIONBAR_UPDATE_STATE = true,
		SPELL_UPDATE_CHARGES = true,
		SPELL_UPDATE_COOLDOWN = true,
		UPDATE_VEHICLE_ACTIONBAR = true,
		ACTIONBAR_SLOT_CHANGED = true,
		UPDATE_BONUS_ACTIONBAR = true,
		UPDATE_SHAPESHIFT_FORM = true,
		UPDATE_SHAPESHIFT_FORMS = true,
		UPDATE_SHAPESHIFT_USABLE = true,
		ACTIONBAR_PAGE_CHANGED = true,
		PLAYER_ENTERING_WORLD = true,
		UPDATE_EXTRA_ACTION_BAR = true,
		UNIT_TARGET = true,
		ACTIONBAR_SHOWGRID = true,
		ACTIONBAR_HIDEGRID = true,
		PET_BAR_UPDATE_COOLDOWN = true,
		PET_BAR_UPDATE = true,
		PET_BAR_UPDATE_USABLE = true,
		UNIT_PET = true,
	},
	barDropdown = {
		{ label = 'Screen', value = 'Screen'},
	},
	anchorLookup = {
		Screen = UIParent
	},
	config = {
		enabled = true,
	},
	settings = {

	},
	addOptions = function (self)
		self:addOption('_1', {
			type = 'Title',
			label = 'General',
		})
	end,
	anchorSet = function (self, token, value, option)
		O3:safe(function ()
			option.bar:place(self)
		end)
	end,
	setVisible = function (self, token, value, option)
		O3:safe(function ()
			if (value) then
				option.bar:show()
			else
				option.bar:hide()
			end
		end)
	end,
	addBar = function (self, bar)
		tableInsert(self.bars, bar)
		self.anchorLookup[bar.name] = bar.frame
		table.insert(self.barDropdown, { label = bar.name, value = bar.name})
		if (bar.id) then
			self.barDict[bar.id] = bar
		end
	end,
	ACTIONBAR_UPDATE_COOLDOWN = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateCooldown()
			end
		end
	end,
	UNIT_TARGET = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	ACTIONBAR_SHOWGRID = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,	
	ACTIONBAR_HIDEGRID = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	ACTIONBAR_UPDATE_USABLE = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateUsable()
			end
		end
	end,
	PET_BAR_UPDATE_COOLDOWN = function (self)
		if (self.barDict.pet) then
			local bar = self.barDict.pet
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateCooldown()
			end
		end
	end,
	PET_BAR_UPDATE = function (self)
		if (self.barDict.pet) then
			local bar = self.barDict.pet
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	PET_BAR_UPDATE_USABLE = function (self)
		if (self.barDict.pet) then
			local bar = self.barDict.pet
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateUsable()
			end
		end
	end,
	UNIT_PET = function (self)
		if (self.barDict.pet) then
			local bar = self.barDict.pet
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,

	UPDATE_EXTRA_ACTION_BAR = function (self)
		if self.barDict.extra then
			local bar = self.barDict.extra
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	SPELL_UPDATE_USABLE = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateUsable()
			end
		end
	end,
	ACTIONBAR_UPDATE_STATE = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateState()
			end
		end
	end,
	SPELL_UPDATE_CHARGES = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	SPELL_UPDATE_COOLDOWN = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:updateCooldown()
			end
		end
	end,
	UPDATE_VEHICLE_ACTIONBAR = function (self)
		-- TODO : detect mainbar
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	ACTIONBAR_SLOT_CHANGED = function (self, slot)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				local modifiedSlot = button:getSlot()
				if (modifiedSlot == slot) then
					button:update()
				end
			end
		end
	end,
	UPDATE_BONUS_ACTIONBAR = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	UPDATE_SHAPESHIFT_FORM = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	UPDATE_SHAPESHIFT_FORMS = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	UPDATE_SHAPESHIFT_USABLE = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	ACTIONBAR_PAGE_CHANGED = function (self)
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if not bar.frame:IsVisible() then
				return
			end
			for i = 1, #bar.buttons do
				local button = bar.buttons[i]
				button:update()
			end
		end
	end,
	PLAYER_ENTERING_WORLD = function (self)
		self:hideBlizzardCrap()
		self:unregisterEvent('PLAYER_ENTERING_WORLD')
		for i = 1, #self.bars do
			local bar = self.bars[i]
			bar:load(self)
		end
		self:ACTIONBAR_PAGE_CHANGED()
	end,	
	hideBlizzardCrap = function (self)
		-- MainMenuBar:UnregisterAllEvents()
		-- O3:destroy(MainMenuBar)
		-- O3:destroy(ActionBarActionEventsFrame)
		-- O3:destroy(ActionBarButtonEventsFrame)
		-- MainMenuBar:Hide()
		-- -- MainMenuBar:SetScale(0.00001)
		-- MainMenuBar:EnableMouse(false)
		-- OverrideActionBar:SetScale(0.00001)
		-- OverrideActionBar:EnableMouse(false)
		-- PetActionBarFrame:EnableMouse(false)
		-- StanceBarFrame:EnableMouse(false)
		
		local elements = {
			ActionBarController,
			MainMenuBar, MainMenuBarArtFrame, BonusActionBarFrame, OverrideActionBar,
			MultiBarLeft, MultiBarRight, MultiBarBottomLeft, MultiBarBottomRight,
			--PossessBarFrame, PetActionBarFrame, StanceBarFrame,
			ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
		}
		for _, element in pairs(elements) do
			-- if element:GetObjectType() == "Frame" then
			-- 	element:UnregisterAllEvents()
			-- end
			-- element:Hide()
			O3:destroy(element)
			if element.EnableMouse then
				element:EnableMouse(false)
			end
		end
		elements = nil
		
		-- fix main bar keybind not working after a talent switch. :X
		hooksecurefunc('TalentFrame_LoadUI', function()
			PlayerTalentFrame:UnregisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
		end)

		local uiManagedFrames = {
			"MultiBarLeft",
			"MultiBarRight",
			"MultiBarBottomLeft",
			"MultiBarBottomRight",
		}
		for _, frame in pairs(uiManagedFrames) do
			UIPARENT_MANAGED_FRAME_POSITIONS[frame] = nil
		end
		uiManagedFrames = nil
	end,

	setup = function (self)
		self.panel = self.O3.UI.Panel:instance({
			name = self.name
		})
		self.frame = self.panel.frame
		self:initEventHandler()
		
	end,
})
--handler:addBar(test)


ns.Handler = handler