local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local UF = E:GetModule('UnitFrames')

function UF:AddShouldIAttackIcon(frame)
	if not frame then return end

	local tag = CreateFrame("Frame", nil, frame)
	tag:SetFrameLevel(frame:GetFrameLevel() + 8)
	tag:EnableMouse(false)

	local size = frame.Health and frame.Health:GetHeight() - 16 or 24
	tag:Size(size, size)
	tag:SetAlpha(.5)

	tag.tx = tag:CreateTexture(nil, "OVERLAY")
	tag.tx:SetTexture([[Interface\AddOns\ElvUI_Crit\media\textures\shield.tga]])
	tag.tx:SetAllPoints()

	tag.db = E.db.unitframe.units.target.attackicon

	tag:RegisterEvent("PLAYER_TARGET_CHANGED")
	tag:RegisterEvent("UNIT_COMBAT")

	tag:SetScript("OnEvent", function()
		--if UnitIsTapped("target") and not (UnitIsTappedByPlayer("target") or UnitIsTappedByAllThreatList("target")) then
			--tag:Hide
		--end
		--if UnitCanAttack("player", "target") and (not UnitIsTapped("target") or UnitIsTappedByAllThreatList("target")) then
		--	tag:Show()
		--else
		--	tag:Hide()
		--end
		if tag.db.enable and not UnitIsDeadOrGhost("target") and UnitCanAttack("player", "target") and UnitIsTapDenied("target") then
			tag:ClearAllPoints()
			tag:SetPoint("CENTER", frame, "CENTER", tag.db.xOffset, tag.db.yOffset)
			tag:Show()
		else
			tag:Hide()
		end
	end)
end

function UF:ApplyUnitFrameEnhancements()
	UF:ScheduleTimer("AddShouldIAttackIcon", 8, _G["ElvUF_Target"])
end

local CF = CreateFrame('Frame')
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:SetScript("OnEvent", function(self, event)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if not E.private["unitframe"].enable then return end

	UF:ScheduleTimer("ApplyUnitFrameEnhancements", 5)
end)
