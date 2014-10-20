local addon, ns = ...

local petBar = ns.ActionBar:instance({
	buttonWidth = 32,
	buttonHeight = 32,
	columns = 10,
	name = 'Pet',
	id = 'pet',
	bindings = {
		"ALT-CTRL-1", "ALT-CTRL-2", "ALT-CTRL-3", "CTRL-4", "CTRL-5", "CTRL-`", "CTRL-Q", "CTRL-E", "CTRL-C", "CTRL-X",
	},
	config = {
		visible = true,
		XOffset = 0,
		YOffset = 74,
		anchor = 'BOTTOM',
		anchorTo = 'TOP',
		anchorParent = 'Main',
	},		
	createButton = function (self, action, index)
		local buttonName = self.name.."Button"..index
		local button = ns.PetButton:instance({
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
	place = function (self, handler)
		self.frame:ClearAllPoints()
		self.frame:SetPoint(handler.settings[self.name..'anchor'], handler.anchorLookup[handler.settings[self.name..'anchorParent']], handler.settings[self.name..'anchorTo'], handler.settings[self.name..'XOffset'], handler.settings[self.name..'YOffset'])
	end,
	registerStateDriver = function (self)
		RegisterStateDriver(self.frame, "visibility", "[pet] show; hide")
	end,
})


ns.Handler:addBar(petBar)