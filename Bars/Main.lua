local addon, ns = ...

local mainBar = ns.ActionBar:instance({
	buttonWidth = 36,
	buttonHeight = 36,
	id = 'main',
	name = 'Main',
	classPaging = {
		DRUID = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [form:3,nostealth] 7; [form:3,stealth] 8; [form:1] 9; [form:5] 10;1",
		ROGUE = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7; 1",
		HUNTER = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1",
		MAGE = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1",
		WARLOCK = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1",
		HUNTER = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1",
		PALADIN = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1",
		MONK = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; 1", -- No different bar for ox
		SHAMAN = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1", -- No different bar for other stances
		WARRIOR = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7;1",
		PRIEST = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7; 1",
	},
	config = {
		visible = true,
		XOffset = 0,
		YOffset = 4,
		anchor = 'BOTTOM',
		anchorTo = 'BOTTOM',
		anchorParent = 'Screen',
	},	
	getSlot = function (self)
		return (self.frame:GetAttribute("actionpage")-1)*12+self.action
	end,	
	bindings = {
		"1", "2", "3", "4", "5", "`", "Q", "E", "F", "V", "C", "Z",
	},
	place = function (self, handler)
		self.frame:ClearAllPoints()
		self.frame:SetPoint(handler.settings[self.name..'anchor'], handler.anchorLookup[handler.settings[self.name..'anchorParent']], handler.settings[self.name..'anchorTo'], handler.settings[self.name..'XOffset'], handler.settings[self.name..'YOffset'])
	end,
	registerStateDriver = function (self)
		local _, class = UnitClass('player')
		RegisterStateDriver(self.frame, "page", self.classPaging[class])		
	end,
})

ns.Handler:addBar(mainBar)

local secondBar = ns.ActionBar:instance({
	vertical = true,
	buttonWidth = 32,
	buttonHeight = 32,
	actionOffset = 25,
	rows = 12,
	columns = 4,
	name = 'Second',
	config = {
		visible = false,
		XOffset = 0,
		YOffset = 0,
		anchor = 'RIGHT',
		anchorTo = 'RIGHT',
		anchorParent = 'Screen',
	},
	bindings = {
		"ALT-1", "ALT-2", "ALT-3", "ALT-4", "ALT-5", "ALT-`", "ALT-Q", "ALT-E", "ALT-F", "ALT-V", "ALT-C", "ALT-Z",
		"R","SHIFT-R","ALT-R","G","SHIFT-G","ALT-G","T","SHIFT-T","ALT-T","X","SHIFT-X","ALT-X",
		"ALT-W","ALT-A","ALT-S","ALT-D","SHIFT-W","SHIFT-A","SHIFT-S","SHIFT-D","CTRL-W","CTRL-A","CTRL-S","CTRL-D",
		"CTRL-1","CTRL-2","CTRL-3","B","Y","ALT-B","SHIFT-Q","SHIFT-E","SHIFT-F","SHIFT-V","SHIFT-C","SHIFT-Z",
	},
	place = function (self, handler)
		self.frame:ClearAllPoints()
		self.frame:SetPoint(handler.settings[self.name..'anchor'], handler.anchorLookup[handler.settings[self.name..'anchorParent']], handler.settings[self.name..'anchorTo'], handler.settings[self.name..'XOffset'], handler.settings[self.name..'YOffset'])
	end,	
	registerStateDriver = function (self)
	end,
})

ns.Handler:addBar(secondBar)


-- local rightBar = ns.ActionBar:instance({
-- 	vertical = true,
-- 	buttonWidth = 32,
-- 	buttonHeight = 32,
-- 	actionOffset = 25,
-- 	rows = 12,
-- 	columns = 3,
-- 	name = 'Third',
-- 	config = {
-- 		visible = false,
-- 	},	
-- 	bindings = {
-- 		"ALT-1", "ALT-2", "ALT-3", "ALT-4", "ALT-5", "ALT-`", "ALT-Q", "ALT-E", "ALT-F", "ALT-V", "ALT-C", "ALT-Z",
-- 		"R","SHIFT-R","ALT-R","G","SHIFT-G","ALT-G","T","SHIFT-T","ALT-T","X","SHIFT-X","ALT-X",
-- 		"ALT-W","ALT-A","ALT-S","ALT-D","SHIFT-W","SHIFT-A","SHIFT-S","SHIFT-D","CTRL-W","CTRL-A","CTRL-S","CTRL-D",

-- 	},
-- 	place = function (self, handler)
-- 		self.frame:SetPoint('RIGHT', secondBar.frame, 'LEFT', 0, 0)	
-- 	end,
-- 	registerStateDriver = function (self)
-- 	end,
-- })

-- ns.Handler:addBar(rightBar)


-- local testBar = ns.ActionBar:instance({
-- 	vertical = true,
-- 	buttonWidth = 32,
-- 	buttonHeight = 32,
-- 	actionOffset = 1,
-- 	rows = 12,
-- 	columns = 10,
-- 	name = 'TestBar',
-- 	config = {
-- 		visible = false,
-- 	},	
-- 	bindings = {
-- 	},
-- 	place = function (self, handler)
-- 		self.frame:SetPoint('RIGHT', secondBar.frame, 'LEFT', 0, 0)	
-- 	end,
-- 	registerStateDriver = function (self)
-- 	end,
-- })

-- ns.Handler:addBar(testBar)







