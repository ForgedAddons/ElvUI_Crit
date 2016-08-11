local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local M = E:NewModule('CritMisc', 'AceHook-3.0', 'AceEvent-3.0');

E.MiscEnh = M;

function M:Initialize()
	self:LoadAutoRelease()
	self:LoadWatchedFaction()
	self:LoadMoverTransparancy()
end

E:RegisterModule(M:GetName())
