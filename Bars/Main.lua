local addon, ns = ...

local mainBar = ns.ActionBar:extend({
	id = 'main',
	name = 'Main',
	statePage = true,
	classPaging = {
		DRUID = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [form:2,nostealth] 7; [form:2,stealth] 8; [form:1] 9; [form:5] 10;1",
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
		DEATHKNIGHT = "[vehicleui:12] 12; [possessbar] 12; [overridebar] 14; [bar:2] 2; [bonusbar:1] 7; 1",
	},
	config = {
		rows = 1,
		columns = 12,
		spacing = 1,
		buttonSize = 36,
		visible = true,
		xOffset = 0,
		yOffset = 4,
		anchor = 'BOTTOM',
		anchorTo = 'BOTTOM',
		anchorParent = 'Screen',
		bindings = {
			"1", "2", "3", "4", "5", "`", "Q", "E", "F", "V", "C", "Z",
		},		
	},	
	getSlot = function (self)
		return (self.frame:GetAttribute("actionpage")-1)*12+self.action
	end,	
})
ns.Handler:addBar(mainBar)

local secondBar = ns.ActionBar:extend({
	actionOffset = 25,
	name = 'Second',
	config = {
		rows = 12,
		columns = 1,
		spacing = 1,
		buttonSize = 32,
		visible = false,
		xOffset = 0,
		yOffset = 0,
		anchor = 'RIGHT',
		anchorTo = 'RIGHT',
		anchorParent = 'Screen',
		bindings = {
			"ALT-1", "ALT-2", "ALT-3", "ALT-4", "ALT-5", "ALT-`", "ALT-Q", "ALT-E", "ALT-F", "ALT-V", "ALT-C", "ALT-Z",
		},
	},
	registerStateDriver = function (self)
	end,
})
ns.Handler:addBar(secondBar)


local thirdBar = ns.ActionBar:extend({
	actionOffset = 37,
	name = 'Third',
	config = {
		visible = false,
		buttonSize = 32,
		spacing = 1,
		rows = 12,
		columns = 1,
		xOffset = 0,
		yOffset = 0,
		anchor = 'RIGHT',
		anchorTo = 'LEFT',
		anchorParent = 'Second',
		bindings = {
			"R","SHIFT-R","ALT-R","G","SHIFT-G","ALT-G","T","SHIFT-T","ALT-T","X","SHIFT-X","ALT-X",
		},
	},
	registerStateDriver = function (self)
	end,
})
ns.Handler:addBar(thirdBar)

local fourthBar = ns.ActionBar:extend({
	actionOffset = 49,
	name = 'Fourth',
	config = {
		visible = false,
		buttonSize = 32,
		spacing = 1,
		rows = 12,
		columns = 1,
		xOffset = 0,
		yOffset = 0,
		anchor = 'RIGHT',
		anchorTo = 'LEFT',
		anchorParent = 'Third',
		bindings = {
			"ALT-W","ALT-A","ALT-S","ALT-D","SHIFT-W","SHIFT-A","SHIFT-S","SHIFT-D","CTRL-W","CTRL-A","CTRL-S","CTRL-D",
		},
	},
	registerStateDriver = function (self)
	end,
})
ns.Handler:addBar(fourthBar)

local fifthBar = ns.ActionBar:extend({
	actionOffset = 61,
	name = 'Fifth',
	config = {
		buttonSize = 32,
		spacing = 1,
		rows = 12,
		columns = 1,
		visible = false,
		xOffset = 0,
		yOffset = 0,
		anchor = 'RIGHT',
		anchorTo = 'LEFT',
		anchorParent = 'Fourth',
		bindings = {
			"CTRL-1","CTRL-2","CTRL-3","B","Y","ALT-B","SHIFT-Q","SHIFT-E","SHIFT-F","SHIFT-V","SHIFT-C","SHIFT-Z",
		},
	},
	registerStateDriver = function (self)
	end,
})
ns.Handler:addBar(fifthBar)