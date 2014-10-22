local addon, ns = ...

local extraBar = ns.ActionBar:extend({
	buttonWidth = 48,
	buttonHeight = 48,
	actionOffset = 169,
	rows = 1,
	columns = 1,
	name = 'Extra',
	id = 'extra',
	stateVisibility = "[extrabar] show; hide",
	config = {
		visible = true,
		xOffset = 0,
		yOffset = 107,
		anchor = 'BOTTOM',
		anchorTo = 'TOP',
		anchorParent = 'Main',
		bindings = {
			--"ALT-Y",
		},
	},
	events = {
		ACTIONBAR_UPDATE_COOLDOWN = true,
		ACTIONBAR_UPDATE_USABLE = true,
		SPELL_UPDATE_USABLE = true,
		ACTIONBAR_UPDATE_STATE = true,
		SPELL_UPDATE_CHARGES = true,
		SPELL_UPDATE_COOLDOWN = true,
		ACTIONBAR_SLOT_CHANGED = true,
		UPDATE_EXTRA_ACTION_BAR = true,
		UNIT_TARGET = true,
	},
	createButton = function (self, action, index)
		local buttonName = self.name.."Button"..index
		local button = ns.Button:instance({
			width = self.buttonWidth,
			parentFrame = self.frame,
			name = buttonName,
			index = index,			
			binding = self.settings.bindings[index] or nil,
			action = action,
			height = self.buttonHeight,
		}, self.frame)
		self.frame:SetFrameRef(buttonName, button.frame)
		return button
	end,
})

ns.Handler:addBar(extraBar)