local addon, ns = ...
local O3 = O3
local GetTime = GetTime


local tableInsert = table.insert
local stringGsub = string.gsub


ns.ActionBar = O3.Class:extend({
	rows = 1,
	columns = 12,
	actionOffset = 1,
	buttonWidth = 32,
	buttonHeight = 32,
	vertical = false,
	id = nil,
	spacing = 1,
	timeSinceLastUpdate = 0,
	name = 'Default',
	config = {
		visible = true,
		XOffset = -100,
		YOffset = 100,
		anchor = 'BOTTOMRIGHT',
		anchorTo = 'BOTTOMRIGHT',
		anchorParent = 'Screen',
	},
	bindings = {
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

		frame:SetScript('OnUpdate', function (frame, elapsed)
			self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed

			if (self.timeSinceLastUpdate > 0.5) then
				for i = 1, #self.buttons do
					local button = self.buttons[i]
					--button:updateAction()
					button:updateUsable()
				end				
				self.timeSinceLastUpdate = 0
			end			
		end)
		self.buttons = {}
		self.frame = frame
	end,
	register = function (self, handler)
		handler:addOption(self.name..'_1', {
			type = 'Title',
			label = self.name,
		})
		handler:addOption(self.name..'visible', {
			type = 'Toggle',
			label = 'Visible',
			bar = self,
			setter = 'setVisible',
		})
        handler:addOption(self.name..'anchor', {
            type = 'DropDown',
            label = 'Point',
            bar = self,
            setter = 'anchorSet',
            _values = O3.UI.anchorPoints
        })
        handler:addOption(self.name..'anchorParent', {
            type = 'DropDown',
            label = 'Anchor To',
            bar = self,
            setter = 'anchorSet',
            _values = handler.barDropdown
        })         
        handler:addOption(self.name..'anchorTo', {
            type = 'DropDown',
            label = 'To Point',
            bar = self,
            setter = 'anchorSet',
            _values = O3.UI.anchorPoints
        })        
		handler:addOption(self.name..'XOffset', {
			type = 'Range',
			label = 'Horizontal',
			setter = 'anchorSet',
			bar = self,
			min = -500,
			max = 500,
			step = 5,
		})
		handler:addOption(self.name..'YOffset', {
			type = 'Range',
			label = 'Vertical',
			setter = 'anchorSet',
			bar = self,
			min = -500,
			max = 500,
			step = 5,
		})
		for k, v in pairs(self.config) do
			handler.config[self.name..k] = v
		end

	end,
	place = function (self, handler)
		self.frame:ClearAllPoints()
		self.frame:SetPoint(handler.settings[self.name..'anchor'], handler.anchorLookup[handler.settings[self.name..'anchorParent']], handler.settings[self.name..'anchorTo'], handler.settings[self.name..'XOffset'], handler.settings[self.name..'YOffset'])
	end,
	load = function (self, handler)
		self:createButtons()
		self:sizeFrame()
		self:anchorButtons()
		self:register(handler)
		if (handler.settings[self.name..'visible']) then
			self:show()
		else
			self:hide()
		end
		self:place(handler)
		self:registerStateDriver()
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
			parentFrame = self.frame,
			width = self.buttonWidth,
			name = buttonName,
			binding = self.bindings[index] or nil,
			action = action,
			height = self.buttonHeight,
		}, self.frame)
		self.frame:SetFrameRef(buttonName, button.frame)
		return button
	end,
	createButtons = function (self)
		local buttonIndex = 0
		local maxButtons = self.rows*self.columns
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
		local width = self.columns*(self.buttonWidth+self.spacing)+self.spacing
		local height = self.rows*(self.buttonHeight+self.spacing)+self.spacing
		self.frame:SetSize(width, height)
	end,
	anchorButtons = function (self)
		if (self.vertical) then
			self:anchorButtonsVertical()
		else
			self:anchorButtonsHorizontal()
		end
	end,
	anchorButtonsVertical = function (self)
		local spacing, rows, lastButton = self.spacing, self.rows, self.buttons[1]
		lastButton.frame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
		for i = 2, #self.buttons do
			local button = self.buttons[i]
			if (i % rows == 1) then
				button.frame:SetPoint("TOPLEFT", self.buttons[i-rows].frame, "TOPRIGHT", spacing, 0)
			--elseif (i  == 7) then
			--	button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing * 20, 0)
			else
				button.frame:SetPoint("TOPLEFT", lastButton.frame, "BOTTOMLEFT", 0, -spacing)
			end
			lastButton = button
		end
	end,	
	anchorButtonsHorizontal = function (self)
		local spacing, columns, lastButton = self.spacing, self.columns, self.buttons[1]
		lastButton.frame:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
		for i = 2, #self.buttons do
			local button = self.buttons[i]
			if (i % columns == 1) then
				button.frame:SetPoint("TOPLEFT", self.buttons[i-columns].frame, "BOTTOMLEFT", 0, -spacing)
			--elseif (i  == 7) then
			--	button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing * 20, 0)
			else
				button.frame:SetPoint("TOPLEFT", lastButton.frame, "TOPRIGHT", spacing, 0)
			end
			lastButton = button
		end
	end,
	registerStateDriver = function (self)
		--RegisterStateDriver(self.frame, "page", "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7; 1")		
	end,
})





-- ActionBar = {
-- 	config = {
-- 		columns = 12,
-- 		rows = 1,
-- 		buttonWidth = 30,
-- 		buttonHeight = 30,
-- 		spacing = 4,
-- 		paging = false,
-- 		font = O3.Media:font('Normal'),
-- 		fontSize = 10,
-- 	},
-- 	indexedButtons = {
-- 	},
-- 	actionOffset = 1,
-- 	createButton = function (self, action, index)
-- 		local buttonName = self.name.."Button"..index
-- 		local button = CreateFrame("Button", buttonName, self.frame, "SecureActionButtonTemplate, SecureHandlerDragTemplate, SecureHandlerEnterLeaveTemplate")
-- 		self.indexedButtons[action] = button
-- 		button:SetSize(self.buttonWidth, self.config.buttonHeight)
-- 		O3.UI:shadow(button)
-- 		--O3.UI:wod(button, {0.8, 0.5, 0.5, 1})

-- 		button:SetID(action)

-- 		button:SetAttribute("type", "action")
-- 		button:SetAttribute("action", action)
-- 		button:SetAttribute("actionpage",1)
-- 		button:SetAttribute("useparent-actionpage", true)
-- 		button:RegisterForDrag("LeftButton")
-- 		button:RegisterForClicks("ANYDOWN")
-- 		button:SetAttribute("_ondragstart", [[

-- 			local modifiedSlot = (self:GetAttribute("actionpage")-1)*12+self:GetID()
-- 			return "clear", "action", modifiedSlot
-- 		]])
-- 		-- button:SetAttribute("_onreceivedrag ", [[
-- 		-- 	control:CallMethod("update")
-- 		-- ]])

-- 		self.frame:SetFrameRef(buttonName, button)

-- 		SecureHandlerWrapScript(button, "OnEnter", button, [[
-- 			control:CallMethod("showTooltip")
-- 		]])
-- 		SecureHandlerWrapScript(button, "OnLeave", button, [[
-- 			control:CallMethod("hideTooltip")
-- 		]])

-- 		local texture = button:CreateTexture()
-- 		texture:SetAllPoints()
-- 		texture:SetTexCoord(.08, .92, .08, .92)
-- 		texture:SetDrawLayer("BACKGROUND")

-- 		button.cooldownElapsed = 0
-- 		button.usableElapsed = 0
-- 		button.stateElapsed = 0

-- 		button.updateCooldown = function (self)
-- 			local modifiedSlot = (self:GetAttribute("actionpage")-1)*12+self:GetID()
-- 			local start, duration, enable, charges, maxCharges = GetActionCooldown(modifiedSlot)
-- 			local cooldown = self.cooldown
-- 			cooldown.callbackTexture = texture
-- 			if (start+duration ~= button.startDuration) then
-- 				cooldown:SetCooldown(start, duration)
-- 			end
-- 			button.startDuration  = start + duration
-- 		end

-- 		button.updateAction = function (self)
-- 			local modifiedSlot = (self:GetAttribute("actionpage")-1)*12+self:GetID()
-- 			local type, id, subType, spellID = GetActionInfo(modifiedSlot)

-- 			if (type == "spell") then
-- 				local spellName, spellRank, buttonTexture = GetSpellInfo(id)
-- 				if buttonTexture ~= button.texture then
-- 					texture:SetTexture(buttonTexture)
-- 				end
-- 				button.texture = buttonTexture
-- 			elseif (type == "macro") then
-- 				local macroName, macroTexture, macroBody = GetMacroInfo(id)
-- 				if buttonTexture ~= button.texture then
-- 					texture:SetTexture(macroTexture)
-- 				end
-- 				button.texture = macroTexture
-- 			elseif (type == "item") then
-- 				local itemTexture = GetActionTexture(modifiedSlot)
-- 				if itemTexture ~= button.texture then
-- 					texture:SetTexture(itemTexture)
-- 				end
-- 				button.texture = itemTexture
-- 			else
-- 				local actionTexture = GetActionTexture(modifiedSlot)
-- 				if buttonTexture ~= button.texture then
-- 					texture:SetTexture(actionTexture)
-- 				end
-- 				button.texture = actionTexture
-- 			end
-- 			local count = GetActionCount(modifiedSlot)
-- 			if (count > 1) then
-- 				self.count:SetText(count)
-- 			else
-- 				local actionCount, actionMax = GetActionCharges(modifiedSlot)
-- 				if actionMax > 0 then 
-- 					self.count:SetText(actionCount)
-- 				else
-- 					self.count:SetText("")
-- 				end
-- 			end
-- 		end

-- 		button.updateState = function (self)

-- 		end

-- 		button.updateUsable = function (self)
-- 			local modifiedSlot = (self:GetAttribute("actionpage")-1)*12+self:GetID()
-- 			if (IsUsableAction(modifiedSlot)) then
-- 				texture:SetVertexColor(1.0, 1.0, 1.0)
-- 			else
-- 				texture:SetVertexColor(0.2, 0.2, 0.2)
-- 			end
-- 		end

-- 		button.update = function (self)
-- 			self:updateState()
-- 			self:updateUsable()
-- 			self:updateCooldown()
-- 			self:updateAction()
-- 		end

-- 		button.showTooltip = function (self)
-- 			local modifiedSlot = (self:GetAttribute("actionpage")-1)*12+self:GetID()
-- 			GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
-- 			GameTooltip:SetAction(modifiedSlot)
-- 			GameTooltip:Show()
-- 		end

-- 		button.hideTooltip = function (self)
-- 			GameTooltip:Hide()
-- 		end

-- 		SecureHandlerWrapScript(button, "OnAttributeChanged", button, [[
-- 			if name == "actionpage" then
-- 				local modifiedSlot = (value-1)*12+self:GetID()
-- 				control:CallMethod("update")
-- 			end
-- 			control:CallMethod("update")
-- 		]])

-- 		local cooldown = CreateFrame("Cooldown", nil, button)
-- 		--local cooldown = O3.Widget.Cooldown(button)
-- 		cooldown:SetAllPoints()
-- 		button.cooldown = cooldown

-- 		button.texture = texture

-- 		local count = button:CreateFontString(nil, "OVERLAY")
-- 		count:SetFont(self.config.font, self.config.fontSize, "THINOUTLINE")
-- 		-- count:SetShadowColor(0,0,0)
-- 		-- count:SetShadowOffset(1,-1)
-- 		count:SetJustifyH("LEFT")
-- 		count:SetTextColor(1, 1, 0)
-- 		count:SetPoint("TOPLEFT")
-- 		button.count = count

-- 		local text = button:CreateFontString(nil, "OVERLAY")
-- 		text:SetFont(self.config.font, self.config.fontSize,"THINOUTLINE")
-- 		-- text:SetShadowColor(0,0,0)
-- 		-- text:SetShadowOffset(1,-1)
-- 		text:SetJustifyH("CENTER")
-- 		text:SetTextColor(1, 1, 1)
-- 		text:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)
-- 		button.text = text

-- 		if keyBindings[buttonName] then
-- 			SetBinding(keyBindings[buttonName], "CLICK "..buttonName..":LeftButton")
-- 			local bindingText = stringGsub(keyBindings[buttonName], "ALT--CTRL", "ac")
-- 			bindingText = stringGsub(bindingText,"ALT--SHIFT","as")
-- 			bindingText = stringGsub(bindingText,"SHIFT","s")
-- 			bindingText = stringGsub(bindingText,"ALT","a")
-- 			bindingText = stringGsub(bindingText,"CTRL","c")
-- 			bindingText = stringGsub(bindingText,"MOUSEWHEELUP","▲")
-- 			bindingText = stringGsub(bindingText,"MOUSEWHEELDOWN","▼")
-- 			text:SetText(bindingText)
-- 		end

-- 		button:update()
-- 		button.action = action
-- 		return button
-- 	end,

-- 	update = function (self)
-- 		for i = 1, #self.buttons do
-- 			local button = self.buttons[i]
-- 			button:update()
-- 		end
-- 	end,
-- 	updateSlot = function (self, action)
-- 		if (self.indexedButtons[action]) then
-- 			self.indexedButtons[action]:update()
-- 		end
-- 	end,
-- 	updateAction = function (self, action)
-- 		for i = 1, #self.buttons do
-- 			local button = self.buttons[i]
-- 			button:updateAction()
-- 		end
-- 	end,
-- 	updateState = function (self)
-- 		for i = 1, #self.buttons do
-- 			local button = self.buttons[i]
-- 			button:updateState()
-- 		end
-- 	end,
-- 	updateCooldown = function (self)
-- 		for i = 1, #self.buttons do
-- 			local button = self.buttons[i]
-- 			button:updateCooldown()
-- 		end
-- 	end,
-- 	updateUsable = function (self)
-- 		for i = 1, #self.buttons do
-- 			local button = self.buttons[i]
-- 			button:updateUsable()
-- 		end
-- 	end,
-- 	createButtons = function (self, actionOffset)
-- 		local buttonIndex = 0
-- 		local maxButtons = self.config.rows*self.config.columns
-- 		for i = 1, maxButtons do
-- 			tableInsert(self.buttons, self:createButton(buttonIndex+actionOffset, i))
-- 			buttonIndex = buttonIndex+1
-- 		end
-- 		self.frame:Execute(([[ 
-- 			buttons = table.new()
-- 			for i = 1, %d do
-- 				table.insert(buttons, self:GetFrameRef("%s" .. i))
-- 			end  
-- 		]]):format(maxButtons, self.name.."Button"))

-- 		if self.config.paging then 
-- 			RegisterStateDriver(self.frame, "page", "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7; 1")		
-- 		end
-- 	end,
-- 	sizeFrame = function (self)
-- 		local width = self.config.columns*(self.config.buttonWidth+self.config.spacing)+self.config.spacing*21
-- 		local height = self.config.rows*(self.config.buttonHeight+self.config.spacing)+self.config.spacing
-- 		self.frame:SetSize(width, height)
-- 	end,
-- 	anchorButtons = function (self)
-- 		local spacing, columns, lastButton = self.config.spacing, self.config.columns, self.buttons[1]
-- 		lastButton:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
-- 		for i = 2, #self.buttons do
-- 			local button = self.buttons[i]
-- 			if (i % columns == 1) then
-- 				button:SetPoint("TOPLEFT", self.buttons[i-columns], "BOTTOMLEFT", 0, -spacing)
-- 			elseif (i  == 7) then
-- 				button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing * 20, 0)
-- 			else
-- 				button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing, 0)
-- 			end
-- 			lastButton = button
-- 		end
-- 	end,
-- 	setup = function (self, name)

-- 		local frame = CreateFrame('Frame', nil, UIParent, 'SecureHandlerStateTemplate')
-- 		frame:SetAttribute("_onstate-page", [[
-- 			newstate = tonumber(newstate)
-- 			self:SetAttribute('actionpage',newstate)
-- 			for i, button in ipairs( buttons ) do
-- 				button:SetAttribute("actionpage", tonumber(newstate))
-- 			end
-- 		]])
-- 		self.frame = frame

-- 		self.buttons = {}
-- 		self.name = name
-- 	end,
-- 	hide = function (self)
-- 		self.frame:Hide()
-- 	end,
-- 	show = function (self)
-- 		self.frame:Show()
-- 	end,
-- 	init = function (self, actionOffset)
-- 		self:createButtons(actionOffset)
-- 		self:sizeFrame()
-- 		self:anchorButtons()
-- 	end,
-- 	factory = function (self, name, actionOffset, config, anchor)
-- 		local bar = {
-- 			config = config,
-- 		}
-- 		setmetatable(bar.config, {__index = self.config})
-- 		self.setup(bar, name)
-- 		setmetatable(bar, {__index = self})
-- 		bar:init(actionOffset)
-- 		bar.frame:SetPoint(unpack(anchor))
-- 		return bar
-- 	end
-- }

-- VerticalActionBar = {
-- 	anchorButtons = function (self)
-- 		local spacing, rows, lastButton = self.config.spacing, self.config.rows, self.buttons[1]
-- 		lastButton:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
-- 		for i = 2, #self.buttons do
-- 			local button = self.buttons[i]
-- 			if (i % rows == 1) then
-- 				button:SetPoint("TOPLEFT", self.buttons[i-rows], "TOPRIGHT", spacing, 0)
-- 			else
-- 				button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -spacing)
-- 			end
-- 			lastButton = button
-- 		end
-- 	end,
-- 	sizeFrame = function (self)
-- 		local width = self.config.columns*(self.config.buttonWidth+self.config.spacing)+self.config.spacing
-- 		local height = self.config.rows*(self.config.buttonHeight+self.config.spacing)+self.config.spacing
-- 		self.frame:SetSize(width, height)
-- 	end,	
-- }
-- setmetatable(VerticalActionBar, {__index = ActionBar})



-- SplitActionBar = {
-- 	sizeFrame = function (self)
-- 		local width = self.config.columns*(self.config.buttonWidth+self.config.spacing)+self.config.spacing+161
-- 		local height = self.config.rows*(self.config.buttonHeight+self.config.spacing)+self.config.spacing
-- 		self.frame:SetSize(width, height)
-- 	end,
-- 	anchorButtons = function (self)
-- 		local spacing, columns, lastButton = self.config.spacing, self.config.columns, self.buttons[1]
-- 		lastButton:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
-- 		for i = 2, #self.buttons do
-- 			local button = self.buttons[i]
-- 			if (i % columns == 1) then
-- 				button:SetPoint("TOPLEFT", self.buttons[i-columns], "BOTTOMLEFT", 0, -spacing)
-- 			elseif (i  == 7) then
-- 				button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", 161+spacing, 0)
-- 			else
-- 				button:SetPoint("TOPLEFT", lastButton, "TOPRIGHT", spacing, 0)
-- 			end
-- 			lastButton = button
-- 		end
-- 	end,	
-- }
-- setmetatable(SplitActionBar, {__index = ActionBar})

-- ns.VerticalActionBar = VerticalActionBar
-- ns.ActionBar = ActionBar
-- ns.SplitActionBar = SplitActionBar
-- ns.ExtendedMacroBar = ExtendedMacroBar
-- --ns.CooldownBar = CooldownBar
-- O3.ActionBar = ActionBar