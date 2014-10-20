local addon, ns = ...

local extraBar = ns.ActionBar:instance({
	buttonWidth = 48,
	buttonHeight = 48,
	actionOffset = 169,
	rows = 1,
	columns = 1,
	name = 'Extra',
	id = 'extra',
	bindings = {
		"ALT-Y",
	},
	config = {
		visible = false,
		XOffset = -100,
		YOffset = 100,
		anchor = 'BOTTOMRIGHT',
		anchorTo = 'BOTTOMRIGHT',
		anchorParent = UIParent,
	},

	createButton = function (self, action, index)
		local buttonName = self.name.."Button"..index
		local button = ns.Button:instance({
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
		if (rawget(handler.settings,self.name..'anchorParent')) then
			self.frame:SetPoint(handler.settings[self.name..'anchor'], handler.anchorLookup[handler.settings[self.name..'anchorParent']], handler.settings[self.name..'anchorTo'], handler.settings[self.name..'XOffset'], handler.settings[self.name..'YOffset'])
		else		
			if (handler.barDict.pet) then
				self.frame:SetPoint('BOTTOM', handler.barDict.pet.frame, 'TOP', 0, 60)
			elseif (handler.barDict.main) then
				self.frame:SetPoint('BOTTOM', handler.barDict.pet.main, 'TOP', 0, 60)
			else
				self.frame:SetPoint('CENTER', UIParent, 'CENTER', -100, 0)	
			end
		end
	end,
	registerStateDriver = function (self)
		RegisterStateDriver(self.frame, "visibility", "[extrabar] show; hide")
	end,
})

ns.Handler:addBar(extraBar)