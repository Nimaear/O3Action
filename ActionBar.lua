local addon, ns = ...
local O3 = O3
local GetTime = GetTime

local tableInsert = table.insert
local stringGsub = string.gsub

ns.ActionBar = O3.Class:extend({
	actionOffset = 1,
	id = nil,
	timeSinceLastUpdate = 0,
	name = 'Default',
	statePage = false,
	stateVisibility = nil,
	maxButtons = 12,
	_actionLookup = {},
	_actionLastUpdate = {},
	config = {
		visible = true,
		rows = 1,
		columns = 12,
		buttonSize = 32,
		spacing = 1,
		yOffset = -100,
		xOffset = 100,
		anchor = 'BOTTOMRIGHT',
		anchorTo = 'BOTTOMRIGHT',
		anchorParent = 'Screen',
		bindings = {},
	},
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
		UPDATE_EXTRA_ACTION_BAR = true,
		UNIT_TARGET = true,
	},
	onShow = function (self)
		for i = 1, #self.buttons do
			local button = self.buttons[i]
			button:update()
		end
	end,
	init = function (self)
		local frame = CreateFrame('Frame', nil, UIParent, 'SecureHandlerStateTemplate')
		frame:SetAttribute("_onstate-page", [[
			newstate = tonumber(newstate)
			self:SetAttribute('actionpage',newstate)
			for i, button in ipairs( buttons ) do
				button:SetAttribute("actionpage", tonumber(newstate))
			end
		]])

		frame:SetScript('OnShow', function () 
			self:onShow()
		end)

		-- frame:SetScript('OnUpdate', function (frame, elapsed)
		-- 	self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed

		-- 	if (self.timeSinceLastUpdate > 0.5) then
		-- 		for i = 1, #self.buttons do
		-- 			local button = self.buttons[i]
		-- 			--button:updateAction()
		-- 			button:updateUsable()
		-- 		end				
		-- 		self.timeSinceLastUpdate = 0
		-- 	end			
		-- end)

		self.buttons = {}
		self:bindEventHandlers()
		self.frame = frame
		self:createButtons()
		self:anchorButtons()
		self:register()
	end,
	load = function (self)
		local handler = self.handler
		if (self.settings.visible) then
			self:show()
		else
			self:hide()
		end
		for event, foo in pairs(self.events) do
			handler:registerEvent(event, self)
		end
		self:place()
		self:registerStateDriver()
		if (self.ACTIONBAR_PAGE_CHANGED) then
			self:ACTIONBAR_PAGE_CHANGED()
		end
	end,
	register = function (self)
		local handler = self.handler
		handler:addOption('_1', {
			type = 'Title',
			label = self.name,
			subModule = self.name,
		})
		if (not self.stateVisibility) then
			handler:addOption('visible', {
				type = 'Toggle',
				label = 'Visible',
				bar = self,
				setter = 'setVisible',
				subModule = self.name,
			})
		end
		local cols, rows
		handler:addOption('rows', {
			type = 'Range',
			label = 'Rows',
			setter = 'setRows',
			bar = self,
			min = 1,
			max = 12,
			step = 1,
			subModule = self.name,
		})
		handler:addOption('columns', {
			type = 'Range',
			label = 'Columns',
			setter = 'setCols',
			bar = self,
			min = 1,
			max = 12,
			step = 1,
			subModule = self.name,
		})
		handler:addOption('buttonSize', {
			type = 'Range',
			label = 'Button Size',
			setter = 'setButtonSize',
			bar = self,
			min = 10,
			max = 48,
			step = 1,
			subModule = self.name,
		})
		handler:addOption('spacing', {
			type = 'Range',
			label = 'Spacing',
			setter = 'setSpacing',
			bar = self,
			min = 0,
			max = 10,
			step = 1,
			subModule = self.name,
		})
        handler:addOption('anchor', {
            type = 'DropDown',
            label = 'Point',
            bar = self,
            setter = 'anchorSet',
            _values = O3.UI.anchorPoints,
            subModule = self.name,
        })
        handler:addOption('anchorParent', {
            type = 'DropDown',
            label = 'Anchor To',
            bar = self,
            setter = 'anchorSet',
            _values = handler.barDropdown,
            subModule = self.name,
        })         
        handler:addOption('anchorTo', {
            type = 'DropDown',
            label = 'To Point',
            bar = self,
            setter = 'anchorSet',
            _values = O3.UI.anchorPoints,
            subModule = self.name,
        })        
		handler:addOption('xOffset', {
			type = 'Range',
			label = 'Horizontal',
			setter = 'anchorSet',
			bar = self,
			min = -500,
			max = 500,
			step = 5,
			subModule = self.name,
		})
		handler:addOption('yOffset', {
			type = 'Range',
			label = 'Vertical',
			setter = 'anchorSet',
			bar = self,
			min = -500,
			max = 500,
			step = 5,
			subModule = self.name,
		})
		for k, v in pairs(self.config) do
			handler.config[self.name..k] = v
		end

	end,
	place = function (self)
		local handler = self.handler
		self.frame:ClearAllPoints()
		self.frame:SetPoint(self.settings.anchor, handler.anchorLookup[self.settings.anchorParent], self.settings.anchorTo, self.settings.xOffset, self.settings.yOffset)
	end,
	show = function (self)
		for i = 1, #self.buttons do
			local button = self.buttons[i]
			button:update()
		end
		O3:safe(function ()
			self.frame:Show()
		end)		
	end,
	hide = function (self)
		O3:safe(function ()
			self.frame:Hide()
		end)		
	end,
	createButton = function (self, action, index)
		local buttonName = self.name.."Button"..index
		local button = ns.Button:instance({
			index = index,
			parentFrame = self.frame,
			width = self.settings.buttonSize,
			name = buttonName,
			binding = self.settings.bindings[index] or nil,
			action = action,
			height = self.settings.buttonSize,
		}, self.frame)
		self.frame:SetFrameRef(buttonName, button.frame)
		self._actionLookup[action] = button
		self._actionLastUpdate[action] = 0
		return button
	end,
	createButtons = function (self)
		local buttonIndex = 0
		local maxButtons = self.maxButtons
		for i = 1, maxButtons do
			tableInsert(self.buttons, self:createButton(buttonIndex+self.actionOffset, i))
			buttonIndex = buttonIndex+1
		end
		self.frame:Execute(([[ 
			buttons = table.new()
			for i = 1, %d do
				table.insert(buttons, self:GetFrameRef("%s" .. i))
			end  
		]]):format(maxButtons, self.name.."Button"))
	end,
	sizeFrame = function (self)
		local settings = self.settings
		local width = settings.columns*(settings.buttonSize+settings.spacing)+settings.spacing
		local height = settings.rows*(settings.buttonSize+settings.spacing)+settings.spacing
		self.frame:SetSize(width, height)
	end,
	anchorButtons = function (self)
		local spacing, columns, lastButton = self.settings.spacing, self.settings.columns, self.buttons[1]
		lastButton:clearAllPoints()
		lastButton.frame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
		for i = 2, #self.buttons do
			local button = self.buttons[i]
			button:clearAllPoints()
			if (i % columns == 1 or columns == 1) then
				button.frame:SetPoint("TOPLEFT", self.buttons[i-columns].frame, "BOTTOMLEFT", 0, -spacing)
			--elseif (i  == 7) then
			--	button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing * 20, 0)
			else
				button.frame:SetPoint("TOPLEFT", lastButton.frame, "TOPRIGHT", spacing, 0)
			end
			lastButton = button
		end
		self:sizeFrame()
	end,
	registerStateDriver = function (self)
		--RegisterStateDriver(self.frame, "page", "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7; 1")		
		if (self.stateVisibility) then
			RegisterStateDriver(self.frame, "visibility", self.stateVisibility)
		end
		if (self.statePage) then
			local _, class = UnitClass('player')
			RegisterStateDriver(self.frame, "page", self.classPaging[class])
		end
	end,
	unregisterStateDriver = function (self)
		UnregisterStateDriver(self.frame, "visibility")
	end,
	updateCooldown = function (self)
		for i = 1, #self.buttons do
			local button = self.buttons[i]
			button:updateCooldown()
		end
	end,
	updateUsable = function (self)
		for i = 1, #self.buttons do
			local button = self.buttons[i]
			button:updateUsable()
		end
	end,
	update = function (self)
		for i = 1, #self.buttons do
			local button = self.buttons[i]
			button:update()
		end
	end,
	ACTIONBAR_SLOT_CHANGED = function (self, slot)
		if (self._actionLookup[slot]) then
			local now = GetTime()
			if self._actionLastUpdate[slot] > now - 0.1 then
				self._actionLookup[slot]:update()
				self._actionLastUpdate[slot] = now
			end
		end
	end,
	bindEventHandlers = function (self)
		self.ACTIONBAR_UPDATE_COOLDOWN = self.updateCooldown
		self.ACTIONBAR_UPDATE_USABLE = self.updateUsable
		self.SPELL_UPDATE_USABLE = self.updateUsable
		self.ACTIONBAR_UPDATE_STATE = self.updateState
		self.SPELL_UPDATE_CHARGES = self.update
		self.SPELL_UPDATE_COOLDOWN = self.updateCooldown
		self.UPDATE_VEHICLE_ACTIONBAR = self.update
		--self.ACTIONBAR_SLOT_CHANGED = self.update
		self.UPDATE_BONUS_ACTIONBAR = self.update
		self.UPDATE_SHAPESHIFT_FORM = self.update
		self.UPDATE_SHAPESHIFT_FORMS = self.update
		self.UPDATE_SHAPESHIFT_USABLE = self.update
		self.UPDATE_EXTRA_ACTION_BAR = self.update
		self.UNIT_TARGET = self.update
	end,
})


