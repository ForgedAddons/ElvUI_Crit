local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local C = E:NewModule('Crit', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0')

C.version = GetAddOnMetadata("ElvUI_Crit", "Version")

function C:Initialize()
	if E.db.general.loginmessage then
		print(format(L['CRIT_LOGIN_MSG'], E["media"].hexvaluecolor, C.version))
	end
end

E:RegisterModule(C:GetName())
