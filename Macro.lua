local addon, ns = ...
local ActionBar = ns.ActionBar

local macroText = ns.config.macroText
local keyBindings = ns.config.keyBindings
local stringGsub = string.gsub

local MacroActionBar = {
	Setup = function (self, name)

		local frame = CreateFrame('Frame', nil, UIParent, 'SecureHandlerStateTemplate')
		self.frame = frame
		frame:Hide()
		self.buttons = {}
		self.name = name
	end,
	CreateButton = function (self, action, index)
		local buttonName = self.name.."Button"..index
		local button = CreateFrame("Button", buttonName, self.frame, "SecureActionButtonTemplate")

		button:SetSize(self.config.buttonWidth, self.config.buttonHeight)
		Singularity.Frame:Shadow(button)

		button:SetAttribute("type", "macro")
		button:RegisterForDrag("LeftButton")
		button:RegisterForClicks("ANYDOWN")

		if keyBindings[buttonName] and macroText[buttonName] then
			button:SetAttribute("macrotext", macroText[buttonName])
			SetBinding(keyBindings[buttonName], "CLICK "..buttonName..":LeftButton")
		end

		return button
	end,
}
setmetatable(MacroActionBar, {__index = ActionBar})

ns.MacroActionBar = MacroActionBar