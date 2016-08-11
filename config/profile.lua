local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

--General
P['general']['movertransparancy'] = .8


--Unitframes
P['unitframe']['units']['target']['attackicon'] = {
	['enable'] = true,
	['xOffset'] = 24,
	['yOffset'] = 6,
}

-- DataTexts
P['datatexts']['Actionbar1DataPanel'] = false
P['datatexts']['Actionbar3DataPanel'] = false
P['datatexts']['Actionbar5DataPanel'] = false

P['datatexts']['panels']['Actionbar1DataPanel'] = {
	['left'] = 'Crit Chance',
	['middle'] = L['Target Range'],
	['right'] = L["Item Level"],
}

P['datatexts']['panels']['Actionbar3DataPanel'] = 'Talent/Loot Specialization'

P['datatexts']['panels']['Actionbar5DataPanel'] = 'Call to Arms'
