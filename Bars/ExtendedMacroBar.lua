local addon, ns = ...
local O3 = O3

local ActionBar = ns.ActionBar
local keyBindings = ns.config.keyBindings

local tableInsert = table.insert
local stringGsub = string.gsub

ExtendedMacroBar = {
	config = {
		columns = 2,
		rows = 12,
		buttonWidth = 30,
		buttonHeight = 30,
		spacing = 2,
		paging = false,
		font = O3.Media:font('Bold'),
		fontSize = 10,
	},
	actionOffset = 1,
	createButton = function (self, buttonInfo, index)
		local buttonInfo = buttonInfo or {}
		local titleText = buttonInfo.title or ""
		local icon = buttonInfo.icon 
		local buttonName = self.name.."Button"..index
		local macroText = buttonInfo.text or ""
		local button = CreateFrame("Button", buttonName, self.frame, "SecureActionButtonTemplate, SecureHandlerEnterLeaveTemplate")

		button:SetSize(self.config.buttonWidth, self.config.buttonHeight)
		O3.UI:shadow(button)

		button:SetAttribute("type", "macro")
		button:SetAttribute("macrotext", macroText)
		button:RegisterForDrag("LeftButton")
		button:RegisterForClicks("ANYDOWN")

		self.frame:SetFrameRef(buttonName, button)

		SecureHandlerWrapScript(button, "OnEnter", button, [[
			control:CallMethod("ShowTooltip")
		]])
		SecureHandlerWrapScript(button, "OnLeave", button, [[
			control:CallMethod("ShowTooltip")
		]])

		local texture = button:CreateTexture()
		texture:SetAllPoints()
		texture:SetTexCoord(.08, .92, .08, .92)
		texture:SetDrawLayer("BORDER")

		button.Update = function (self)
			if icon then
				texture:SetTexture([[Interface\Icons\]]..icon)
			end
		end


		button.updateState = function (self)
		end

		button.updateAction = function (self)
		end

		button.updateCooldown = function (self)
		end

		button.updateUsable = function (self)
		end

		button.ShowTooltip = function (self)
			GameTooltip:Show()
		end

		button.HideTooltip = function (self)
			GameTooltip:Hide()
		end

		local cooldown = CreateFrame("Cooldown", nil, button)
		cooldown:SetAllPoints()
		button.cooldown = cooldown

		button.texture = texture

		local text = button:CreateFontString(nil, "OVERLAY")
		text:SetFont(self.config.font, self.config.fontSize,"THINOUTLINE")
		-- text:SetShadowColor(0,0,0)
		-- text:SetShadowOffset(1,-1)
		text:SetJustifyH("CENTER")
		text:SetTextColor(1, 1, 1)
		text:SetPoint("BOTTOM", button, "BOTTOM", 0, 2)
		button.text = text

		-- local title = button:CreateFontString(nil, "OVERLAY")
		-- title:SetFont(self.config.font, self.config.fontSize-2,"THINOUTLINE")
		-- -- title:SetShadowColor(0,0,0)
		-- -- title:SetShadowOffset(1,-1)
		-- title:SetJustifyH("CENTER")
		-- title:SetTextColor(0.5, 0.5, 0.5)
		-- title:SetPoint("TOP", button, "TOP", 0, -2)
		-- title:SetText(titleText)
		-- button.title = title

		if buttonInfo.bind then
			SetBinding(buttonInfo.bind, "CLICK "..buttonName..":LeftButton")
			local bindingText = stringGsub(buttonInfo.bind, "ALT--CTRL", "ac")
			bindingText = stringGsub(bindingText,"ALT--SHIFT","as")
			bindingText = stringGsub(bindingText,"SHIFT","s")
			bindingText = stringGsub(bindingText,"ALT","a")
			bindingText = stringGsub(bindingText,"CTRL","c")
			text:SetText(bindingText)
		end

		button:Update()
		return button
	end,
	anchorButtons = function (self)
		local spacing, rows, lastButton = self.config.spacing, self.config.rows, self.buttons[1]
		lastButton:SetPoint("TOPLEFT", self.frame, "TOPLEFT", spacing, -spacing)
		for i = 2, #self.buttons do
			local button = self.buttons[i]
			if (i % rows == 1) then
				button:SetPoint("TOPLEFT", self.buttons[i-rows], "TOPRIGHT", spacing, 0)
			else
				button:SetPoint("TOPLEFT", lastButton, "BOTTOMLEFT", 0, -spacing)
			end
			lastButton = button
		end
	end,	
	createButtons = function (self)
		local buttonIndex = 0
		local maxButtons = self.config.rows*self.config.columns
		for i = 1, maxButtons do
			tableInsert(self.buttons, self:createButton(self.config[self.class][i], i))
			buttonIndex = buttonIndex+1
		end
		self.frame:Execute(([[ 
			buttons = table.new()
			for i = 1, %d do
				table.insert(buttons, self:GetFrameRef("%s" .. i))
			end  
		]]):format(maxButtons, self.name.."Button"))

	end,
	setup = function (self, name)

		local frame = CreateFrame('Frame', nil, UIParent, 'SecureHandlerStateTemplate')
		self.frame = frame

		self.buttons = {}
		self.name = name
	end,
	Init = function (self)
		self:createButtons()
		self:SizeFrame()
		self:anchorButtons()
	end,
	sizeFrame = function (self)
		local width = self.config.columns*(self.config.buttonWidth+self.config.spacing)+self.config.spacing
		local height = self.config.rows*(self.config.buttonHeight+self.config.spacing)+self.config.spacing
		self.frame:SetSize(width, height)
	end,	
	factory = function (self, name, config, anchor)
		local _, class = UnitClass("player")
		local bar = {
			config = config,
			class = class,
		}
		setmetatable(bar.config, {__index = self.config})
		self.setup(bar, name)
		setmetatable(bar, {__index = self})
		bar:init()
		bar.frame:SetPoint(unpack(anchor))
		return bar
	end

}
setmetatable(ExtendedMacroBar, {__index = ActionBar})


ns.ExtendedMacroBar = ExtendedMacroBar
O3.ActionBar = ActionBar