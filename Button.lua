local addon, ns = ...

local stringGsub = string.gsub

ns.Button = O3.UI.IconButton:extend({
	font = O3.Media:font('Normal'),
	fontSize = 12,
	width = 32,
	height = 32,
	action = 0,
	type = 'Button',
	template = "SecureActionButtonTemplate, SecureHandlerDragTemplate, SecureHandlerEnterLeaveTemplate",
	name = 'Default',
	updateCooldown = function (self)
		local buttonFrame = self.frame
		local modifiedSlot = (buttonFrame:GetAttribute("actionpage")-1)*12+buttonFrame:GetID()
		local start, duration, enable, charges, maxCharges = GetActionCooldown(modifiedSlot)
		local cooldown = self.cooldown
		if (start+duration ~= self.startDuration) then
			cooldown:SetCooldown(start, duration)
		end
		self.startDuration  = start + duration
	end,
	updateAction = function (self)
		local buttonFrame = self.frame
		local icon = self.icon
		local modifiedSlot = (buttonFrame:GetAttribute("actionpage")-1)*12+buttonFrame:GetID()
		local type, id, subType, spellID = GetActionInfo(modifiedSlot)

		if (type == "spell") then
			local spellName, spellRank, buttonFrameTexture = GetSpellInfo(id)
			icon:SetTexture(buttonFrameTexture)
		elseif (type == "macro") then
			local macroName, macroTexture, macroBody = GetMacroInfo(id)
			icon:SetTexture(macroTexture)
		elseif (type == "item") then
			local itemTexture = GetActionTexture(modifiedSlot)
			icon:SetTexture(itemTexture)
		else
			local actionTexture = GetActionTexture(modifiedSlot)
			icon:SetTexture(actionTexture)
		end
		local count = GetActionCount(modifiedSlot)
		if (count > 1) then
			self.count:SetText(count)
		else
			local actionCount, actionMax = GetActionCharges(modifiedSlot)
			if actionMax > 0 then 
				self.count:SetText(actionCount)
			else
				self.count:SetText("")
			end
		end
	end,
	updateState = function (self)
		self:updateAction()
	end,
	updateUsable = function (self)
		local buttonFrame = self.frame
		local modifiedSlot = (buttonFrame:GetAttribute("actionpage")-1)*12+buttonFrame:GetID()
		local type, id, subType, spellID = GetActionInfo(modifiedSlot)
		if (IsUsableAction(modifiedSlot)) then
			self.icon:SetDesaturated(false)
			-- if ActionHasRange(modifiedSlot) then
			-- 	if (IsActionInRange(modifiedSlot) == 1) then
			-- 		self.icon:SetVertexColor(1.0, 1.0, 1.0)	
			-- 	else
			-- 		self.icon:SetVertexColor(1.0, 0, 0)
			-- 	end
			-- else
				self.icon:SetVertexColor(1.0, 1.0, 1.0)
			-- end
		else
			self.icon:SetDesaturated(true)
			self.icon:SetVertexColor(0.5, 0.5, 0.5)
		end
	end,
	update = function (self)
		self:updateAction()
		self:updateState()
		self:updateUsable()
		self:updateCooldown()
	end,
	postInit = function (self)

		self:setAttributes()

		self.frame:RegisterForDrag("Leftself")
		self.frame:RegisterForClicks("ANYDOWN")

		SecureHandlerWrapScript(self.frame, "OnEnter", self.frame, [[
			control:CallMethod("showTooltip")
		]])
		SecureHandlerWrapScript(self.frame, "OnLeave", self.frame, [[
			control:CallMethod("hideTooltip")
		]])

		self.frame.update = function (buttonFrame)
		 	self:update()
		end

		self:setBinding()
		self:update()
	end,
	setAttributes = function (self)
		local action = self.action
		self.frame:SetID(action)
		self.frame:SetAttribute("type", "action")
		self.frame:SetAttribute("action", action)
		self.frame:SetAttribute("actionpage",1)
		self.frame:SetAttribute("useparent-actionpage", true)

		self.frame:SetAttribute("_ondragstart", [[
			local modifiedSlot = (self:GetAttribute("actionpage")-1)*12+self:GetID()
			return "clear", "action", modifiedSlot
		]])

		SecureHandlerWrapScript(self.frame, "OnAttributeChanged", self.frame, [[
			if name == "actionpage" then
				local modifiedSlot = (value-1)*12+self:GetID()
				control:CallMethod("update")
			end
			control:CallMethod("update")
		]])

		self.frame.showTooltip = function (buttonFrame)
			local modifiedSlot = (buttonFrame:GetAttribute("actionpage")-1)*12+buttonFrame:GetID()
			GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
			GameTooltip:SetAction(modifiedSlot)
			GameTooltip:Show()
		end

		self.frame.hideTooltip = function (buttonFrame)
			GameTooltip:Hide()
		end

	end,

	createRegions = function (self)
		self.text = self:createFontString({
			offset = {nil, nil, nil, 2},
			fontFlags = 'OUTLINE',
			-- shadowOffset = {1, -1},
			fontSize = 12,
		})
		self.count = self:createFontString({
			offset = {2, nil, 2, nil},
			fontFlags = 'OUTLINE',
			-- shadowOffset = {1, -1},
			fontSize = 12,
		})
		self.cooldown = CreateFrame("Cooldown", nil, self.frame, "CooldownFrameTemplate")
		self.cooldown:SetDrawEdge(false)
		self.cooldown:SetDrawSwipe(true)

		self.cooldown:SetPoint('TOPRIGHT', -2, -2)
		self.cooldown:SetPoint('BOTTOMLEFT', 2, 2)
	end,	
	getSlot = function (self)
		return self.action
	end,
	setBinding = function (self, clear)
		if (clear) then
			self.binding = nil
			self.text:SetText('')
		elseif self.binding then
			SetBinding(self.binding, "CLICK "..self.name..":Left")
			local bindingText = stringGsub(self.binding, "ALT--CTRL", "ac")
			bindingText = stringGsub(bindingText,"ALT--SHIFT","as")
			bindingText = stringGsub(bindingText,"SHIFT","s")
			bindingText = stringGsub(bindingText,"ALT","a")
			bindingText = stringGsub(bindingText,"CTRL","c")
			bindingText = stringGsub(bindingText,"MOUSEWHEELUP","▲")
			bindingText = stringGsub(bindingText,"MOUSEWHEELDOWN","▼")
			self.text:SetText(bindingText)
		end
	end,
})

local petTextures = {
	PET_DEFENSIVE_TEXTURE = "Interface\\Icons\\Ability_Defend",
	PET_AGGRESSIVE_TEXTURE = "Interface\\Icons\\Ability_Racial_BloodRage",
	PET_PASSIVE_TEXTURE = "Interface\\Icons\\Ability_Seal",
	PET_ATTACK_TEXTURE = "Interface\\Icons\\Ability_GhoulFrenzy",
	PET_FOLLOW_TEXTURE = "Interface\\Icons\\Ability_Tracking",
	PET_WAIT_TEXTURE = "Interface\\Icons\\Spell_Nature_TimeStop",
	PET_DISMISS_TEXTURE = "Interface\\Icons\\Spell_Shadow_Teleport",
	PET_MOVE_TO_TEXTURE = "Interface\\Icons\\Ability_Hunter_Pet_Goto",
	PET_ASSIST_TEXTURE = "Interface\\Icons\\Ability_Hunter_Pet_Assist",
}

ns.PetButton = ns.Button:extend({
	name = 'PetButton',
	updateCooldown = function (self)
		local button = self.frame
		local modifiedSlot = button:GetID()
		local start, duration, enable = GetPetActionCooldown(button:GetID())
		local cooldown = self.cooldown
		cooldown:SetCooldown(start, duration)
		button.startDuration  = start + duration
	end,
	updateAction = function (self)
		local button = self.frame
		local modifiedSlot = button:GetID()
		local name, subtext, buttonTexture, isToken, isActive, autoCastAllowed, autoCastEnabled = GetPetActionInfo(modifiedSlot)
		buttonTexture = petTextures[buttonTexture] or buttonTexture
		self.icon:SetTexture(buttonTexture)


		if name and not InCombatLockdown() then
			button:SetAttribute("type2", "macro")
			button:SetAttribute("*macrotext2", "/petautocasttoggle "..name)
		end

		-- if (autoCastEnabled) then
		-- 	self.frame.shadow:SetBackdropColor(0, 1.0, 0, 0.4)
		-- else
		-- 	self.frame.shadow:SetBackdropColor(0, 0, 0, 0.4)
		-- end
	end,
	updateUsable = function (self)
		local button = self.frame

		local modifiedSlot = button:GetID()
		if (GetPetActionSlotUsable(modifiedSlot)) then
			self.icon:SetDesaturated(false)
		else
			self.icon:SetDesaturated(true)
		end	
	end,
	update = function (self)
		self:updateAction()
		self:updateState()
		self:updateUsable()
		self:updateCooldown()
	end,
	setAttributes = function (self)
		local action = self.action
		self.frame:SetAttribute("_ondragstart", [[
			return "clear", "petaction", self:GetID()
		]])

		self.frame:SetID(action)

		self.frame:SetAttribute("type1", "pet")
		self.frame:SetAttribute("*action1", action)

		self.frame.showTooltip = function (buttonFrame)
			GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
			GameTooltip:SetPetAction(buttonFrame:GetID())
			GameTooltip:Show()
		end

		self.frame.hideTooltip = function (buttonFrame)
			GameTooltip:Hide()
		end

	end,
})
