local addon, ns = ...

local O3 = O3
local tableInsert = table.insert
local stringGsub = string.gsub

local handler = O3:module({
	name = 'Action',
	weight = 99,
	readable = 'Action Bars',
	bars = {},
	barDict = {},
	events = {
		PLAYER_ENTERING_WORLD = true,
	},
	barDropdown = {
		{ label = 'Screen', value = 'Screen'},
	},
	anchorLookup = {
		Screen = UIParent
	},
	config = {
		enabled = true,
		preset = nil,
	},
	settings = {
		enabled = true,
	},
	configMode = false,
	addOptions = function (self)
		local presets = {}
		for name, preset in pairs(ns.presets) do
			table.insert(presets, {value = name, label = name})
		end
		self:addOption('enabled', {
			type = 'Toggle',
			label = 'Enabled',
		})		
		self:addOption('_Presets', {
			type = 'Title',
			label = 'Presets',
		})
        self:addOption('preset', {
            type = 'DropDown',
            label = 'Load preset',
            setter = 'loadPreset',
            _values = presets,
        })		
		self:addOption('_Config', {
			type = 'Title',
			label = 'Configuration',
		})
		self:addOption('bind', {
			type = 'Button',
			label = 'Keybind mode',
			onClick = function (option)
				self:toggleBindingMode()
			end,
		})
		self:addOption('config', {
			type = 'Button',
			label = 'Toggle config mode',
			onClick = function (option)
				O3:safe(function () 
					self:toggleConfigMode()
				end)
			end,
		})
	end,
	anchorSet = function (self, token, value, option)
		O3:safe(function ()
			option.bar:place()
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
	setRows = function (self, token, value, option)
		O3:safe(function ()
			local bar = option.bar
			self.settings[option.subModule].columns = math.ceil(bar.maxButtons/self.settings[option.subModule].rows)
			self.settings[option.subModule].rows = math.ceil(bar.maxButtons/self.settings[option.subModule].columns)
			for i = 1, #self.options do
				local option = self.options[i]
				if (option.token == 'rows' or option.token == 'columns') and option.bar == bar then
					option:reset()
				end
			end
			option.bar:anchorButtons()
		end)
	end,
	setButtonSize = function (self, token, value, option)
		O3:safe(function ()
			local bar = option.bar
			for i = 1, #bar.buttons do
				bar.buttons[i].frame:SetSize(value, value)
			end
			option.bar:sizeFrame()
		end)
	end,
	setSpacing = function (self, token, value, option)
		option.bar:anchorButtons()
	end,
	setCols = function (self, token, value, option)
		O3:safe(function ()
			local bar = option.bar
			self.settings[option.subModule].rows = math.ceil(12/self.settings[option.subModule].columns)
			self.settings[option.subModule].columns = math.ceil(12/self.settings[option.subModule].rows)
			for i = 1, #self.options do
				local option = self.options[i]
				if (option.token == 'rows' or option.token == 'columns') and option.bar == bar then
					option:reset()
				end
			end
			option.bar:anchorButtons()
		end)
	end,
	setPreset = function (self, token, value, option)
		self:loadPreset(value)
	end,
	loadPreset = function (self)
		local preset = preset or self.settings.preset
		if (preset) then
			local presetSettings = ns.presets[preset]
			if (presetSettings) then
				for i = 1, #self.bars do
					local bar = self.bars[i]
					if (presetSettings[bar.name]) then
						for setting, value in pairs(presetSettings[bar.name]) do
							self.settings[bar.name][setting] = value
						end
						self:reloadSettings(bar)
					end
				end
			end
		end
	end,
	reloadSettings = function (self, bar)
		O3:safe(function ()
			for i = 1, #bar.buttons do
				bar.buttons[i].frame:SetSize(bar.settings.buttonSize, bar.settings.buttonSize)
			end
			bar:sizeFrame()
			bar:anchorButtons()
			bar:place(self)
			if (bar.settings.visible) then
				bar:show()
			else
				bar:hide()
			end

		end)
	end,
	saveBinding = function (self, name, index, binding)
		local found = false
		for i = 1, #self.bars do
			local bar = self.bars[i]
			for j = 1, #bar.buttons do
				local button = bar.buttons[j]
				if button.binding == binding then
					found = true
					button:setBinding(true)
					bar.settings.bindings[j] = nil
				end
			end
		end
		if (found) then
			SetBinding(binding, nil)
		end
		for i = 1, #self.bars do
			local bar = self.bars[i]
			local button = bar.buttons[index]
			if (button) then
				if button.index == index and button.frame:GetName() == name then
					bar.settings.bindings[index] = binding
					button.binding = binding
					button:setBinding()					
				end
			end
		end
	end,
	onKeyUp = function (self, key)
		local buttonFrame = GetMouseFocus()
		local button = buttonFrame.panel
		local buttonName = buttonFrame:GetName()
		local index = button and button.index or nil
		local binding = nil

		if key == "ESCAPE" then
			binding = nil
		else
			if key == "LSHIFT" or key == "RSHIFT" or key == "LCTRL" or key == "RCTRL" or key == "LALT" or key == "RALT" or key == "UNKNOWN" or key == "LeftButton" then 
				return 
			end
			if IsMouseButtonDown(3) then
				key = 'BUTTON3'
			end
			if IsMouseButtonDown(4) then
				key = 'BUTTON4'
			end
			if IsMouseButtonDown(5) then
				key = 'BUTTON5'
			end
			if key == "MiddleButton" then 
				key = "BUTTON3" 
			end
			if key == "Button4" then 
				key = "BUTTON4" 
			end
			if key == "Button5" then 
				key = "BUTTON5" 
			end
			
			local alt = IsAltKeyDown() and "ALT-" or ""
			local ctrl = IsControlKeyDown() and "CTRL-" or ""
			local shift = IsShiftKeyDown() and "SHIFT-" or ""

			binding = alt..ctrl..shift..key
		end
		if (index and button and button.setBinding) then
			self:saveBinding(buttonName, index, binding)
		end
	end,
	toggleBindingMode = function (self)
		ns.Button.handler = self
		self.bindingMode = not self.bindingMode
		if (self.bindingMode) then
			ns.Button.keybindMode = true
			O3.Alert('Keybinds mode is enabled. Press exit to leave keybind mode', function ()
				ns.Button.keybindMode = false
				-- for i = 1, #self.bars do
				-- 	for b = 1, #self.bars[i].buttons do
				-- 		self.bars[i].buttons[b]:keybindMode(nil)
				-- 	end
				-- end
			end, 'Exit')
		else
			ns.Button.keybindMode = false
		end

	end,	
	toggleConfigMode = function (self)
		self.configMode = not self.configMode
		for i = 1, #self.bars do
			local bar = self.bars[i]
			if (self.configMode) then
				bar:unregisterStateDriver()
				bar.frame:Show()
			else
				if (bar.settings.visible) then
					bar:show()
				else
					bar:hide()
				end
				bar:registerStateDriver()
			end
		end
	end,
	addBar = function (self, bar)
		tableInsert(self.bars, bar)
	end,
	postCreate = function (self)
		self:hideBlizzardCrap()
		for i = 1, #self.bars do
			local constructor = self.bars[i]
			
			if (not self.settings[constructor.name]) then
				self.settings[constructor.name] = {
					bindings = {},
				}
				for i = 1,#constructor.config.bindings do
					self.settings[constructor.name].bindings[i] = constructor.config.bindings[i]
				end
			end
			constructor.settings = self.settings[constructor.name]
			setmetatable(constructor.settings, {__index = constructor.config})
			local bar = constructor:instance({
				handler = self,
			})
			self.anchorLookup[bar.name] = bar.frame
			table.insert(self.barDropdown, { label = bar.name, value = bar.name})
			if (bar.id) then
				self.barDict[bar.id] = bar
			end
			self.bars[i] = bar

		end

		for i = 1, #self.bars do
			local bar = self.bars[i]
			bar:load()
		end
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
			PetActionBarFrame, 
			--PossessBarFrame, 
			--StanceBarFrame,
			ShapeshiftBarLeft, ShapeshiftBarMiddle, ShapeshiftBarRight,
			ActionBarButtonEventsFrame,
			ActionBarActionEventsFrame,
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
		self:postCreate()
	end,
	setupEventHandler = function (self)
		self.frame:SetScript('OnEvent', function (frame, event, ...)
			local objects = self._events[event]
			if objects then
				for object, enabled in pairs(objects) do
					if enabled and object.frame:IsVisible() and object[event] then
						object[event](object, ...)
					end
				end
			end
		end)	
	end,	
})
--handler:addBar(test)


ns.Handler = handler