local addon, ns = ...

local petBar = ns.ActionBar:extend({
	buttonWidth = 32,
	buttonHeight = 32,
	columns = 10,
	name = 'Pet',
	id = 'pet',
	stateVisibility = "[pet] show; hide",
	events = {
		PET_BAR_UPDATE_COOLDOWN = true,
		PET_BAR_UPDATE = true,
		PET_BAR_UPDATE_USABLE = true,
		UNIT_PET = true,
		UNIT_TARGET = true,
	},
	config = {
		visible = true,
		xOffset = 0,
		yOffset = 74,
		anchor = 'BOTTOM',
		anchorTo = 'TOP',
		anchorParent = 'Main',
		bindings = {
			"ALT-CTRL-1", "ALT-CTRL-2", "ALT-CTRL-3", "CTRL-4", "CTRL-5", "CTRL-`", "CTRL-Q", "CTRL-E", "CTRL-C", "CTRL-X",
		},
	},
	bindEventHandlers = function (self)
		self.PET_BAR_UPDATE_COOLDOWN = self.updateCooldown
		self.PET_BAR_UPDATE = self.update
		self.PET_BAR_UPDATE_USABLE = self.udpateUsable
		self.UNIT_PET = self.update
		self.UNIT_TARGET = self.update
	end,
	createButton = function (self, action, index)
		local buttonName = self.name.."Button"..index
		local button = ns.PetButton:instance({
			parentFrame = self.frame,
			width = self.buttonWidth,
			index = index,			
			name = buttonName,
			binding = self.settings.bindings[index] or nil,
			action = action,
			height = self.buttonHeight,
		}, self.frame)
		self.frame:SetFrameRef(buttonName, button.frame)
		return button
	end,	
})


ns.Handler:addBar(petBar)