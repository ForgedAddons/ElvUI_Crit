local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local EO = E:NewModule('CritOptions', 'AceEvent-3.0')
local EP = LibStub('LibElvUIPlugin-1.0')
local ElvUICrit = select(1, ...)

local tsort = table.sort

local positionValues = {
	TOPLEFT = 'TOPLEFT',
	LEFT = 'LEFT',
	BOTTOMLEFT = 'BOTTOMLEFT',
	RIGHT = 'RIGHT',
	TOPRIGHT = 'TOPRIGHT',
	BOTTOMRIGHT = 'BOTTOMRIGHT',
	CENTER = 'CENTER',
	TOP = 'TOP',
	BOTTOM = 'BOTTOM',
}

local raidmarkerVisibility = {
	DEFAULT = L['Use Default'],
	INPARTY = AGGRO_WARNING_IN_PARTY,
	ALWAYS  = L['Always Display'],
}

local function ColorizeSettingName(settingName)
	return ("|cffff8000%s|r"):format(settingName)
end

function EO:DataTextOptions()
	local EDT = E:GetModule('ExtraDataTexts')

	E.Options.args.datatexts.args.actionbar1 = {
		order = 20,
		name = ColorizeSettingName(L['Actionbar1DataPanel']),
		type = 'toggle',
		set = function(info, value) 
			E.db.datatexts[ info[#info] ] = value
			EDT:ToggleSettings(1)
		end,
	}
	
	E.Options.args.datatexts.args.actionbar3 = {
		order = 21,
		name = ColorizeSettingName(L['Actionbar3DataPanel']),
		type = 'toggle',
		set = function(info, value) 
			E.db.datatexts[ info[#info] ] = value
			EDT:ToggleSettings(3)
		end,
	}
	
	E.Options.args.datatexts.args.actionbar5 = {
		order = 22,
		name = ColorizeSettingName(L['Actionbar5DataPanel']),
		type = 'toggle',
		set = function(info, value) 
			E.db.datatexts[ info[#info] ] = value
			EDT:ToggleSettings(5)
		end,
	}
end

function EO:EquipmentOptions()
	local PD = E:GetModule('PaperDoll')
	local BI = E:GetModule('CritBagInfo')

	E.Options.args.equipment = {
		type = 'group',
		name = ColorizeSettingName(L['Equipment']),
		get = function(info) return E.private.equipment[ info[#info] ] end,
		set = function(info, value) E.private.equipment[ info[#info] ] = value end,
		args = {
			intro1 = {
				type = "description",
				name = L["DURABILITY_DESC"],
				order = 1,
			},		
			durability = {
				type = 'group',
				name = DURABILITY,
				guiInline = true,
				order = 2,
				get = function(info) return E.private.equipment.durability[ info[#info] ] end,
				set = function(info, value) E.private.equipment.durability[ info[#info] ] = value PD:UpdatePaperDoll() end,
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enable/Disable the display of durability information on the character screen."],
					},
					onlydamaged = {
						type = "toggle",
						order = 2,
						name = L["Damaged Only"],
						desc = L["Only show durabitlity information for items that are damaged."],
						disabled = function() return not E.private.equipment.durability.enable end,
					},
				},
			},
			intro2 = {
				type = "description",
				name = L["ITEMLEVEL_DESC"],
				order = 3,
			},		
			itemlevel = {
				type = 'group',
				name = STAT_AVERAGE_ITEM_LEVEL,
				guiInline = true,
				order = 4,
				get = function(info) return E.private.equipment.itemlevel[ info[#info] ] end,
				set = function(info, value) E.private.equipment.itemlevel[ info[#info] ] = value PD:UpdatePaperDoll() end,
				args = {
					enable = {
						type = "toggle",
						order = 1,
						name = L["Enable"],
						desc = L["Enable/Disable the display of item levels on the character screen."],
					},
				},
			},
			misc = {
				type = 'group',
				name = L["Miscellaneous"],
				guiInline = true,
				order = 8,
				get = function(info) return E.private.equipment.misc[ info[#info] ] end,
				set = function(info, value) E.private.equipment.misc[ info[#info] ] = value end,
				disabled = function() return not E.private.bags.enable end,
				args = {
					setoverlay = {
						type = "toggle",
						order = 1,
						name = L['Equipment Set Overlay'],
						desc = L['Show the associated equipment sets for the items in your bags (or bank).'],
						set = function(info, value) E.private.equipment.misc[ info[#info] ] = value BI:ToggleSettings() end,
					}
				}
			}
		},
	}
end

function EO:MapOptions()
	local MB = E:GetModule('MinimapButtons')
	
	E.Options.args.general.args.minimapbar = {
		order = 1,
		get = function(info) return E.private.general.minimapbar[ info[#info] ] end,
		set = function(info, value) E.private.general.minimapbar[ info[#info] ] = value; MB:UpdateLayout() end,
		type = "group",
		name = ColorizeSettingName(L["Minimap Button Bar"]),
		args = {
			skinButtons = {
				order = 1,
				type = 'toggle',
				name = L['Skin Buttons'],
				desc = L['Skins the minimap buttons in Elv UI style.'],
				set = function(info, value) E.private.general.minimapbar.skinButtons = value; E:StaticPopup_Show("PRIVATE_RL") end,					
			},
			skinStyle = {
				order = 2,
				type = 'select',
				name = L['Skin Style'],
				desc = L['Change settings for how the minimap buttons are skinned.'],
				disabled = function() return not E.private.general.minimapbar.skinButtons end,
				set = function(info, value) E.private.general.minimapbar[ info[#info] ] = value; MB:UpdateSkinStyle() end,
				values = {
					['NOANCHOR'] = L['No Anchor Bar'],
					['HORIZONTAL'] = L['Horizontal Anchor Bar'],
					['VERTICAL'] = L['Vertical Anchor Bar'],
				},
			},
			layoutDirection = {
				order = 3,
				type = 'select',
				name = L['Layout Direction'],
				desc = L['Normal is right to left or top to bottom, or select reversed to switch directions.'],
				disabled = function() return not E.private.general.minimapbar.skinButtons or E.private.general.minimapbar.skinStyle == 'NOANCHOR' end,
				values = {
					['NORMAL'] = L['Normal'],
					['REVERSED'] = L['Reversed'],
				},
			},
			buttonSize = {
				order = 4,
				type = 'range',
				name = L['Button Size'],
				desc = L['The size of the minimap buttons.'],
				min = 16, max = 40, step = 1,
				disabled = function() return not E.private.general.minimapbar.skinButtons or E.private.general.minimapbar.skinStyle == 'NOANCHOR' end,
			},
			backdrop = {
				type = 'toggle',
				order = 5,
				name = L["Backdrop"],
				disabled = function() return not E.private.general.minimapbar.skinButtons or E.private.general.minimapbar.skinStyle == 'NOANCHOR' end,
			},			
			mouseover = {
				order = 6,
				name = L['Mouse Over'],
				desc = L['The frame is not shown unless you mouse over the frame.'],
				type = "toggle",
				set = function(info, value) E.private.general.minimapbar.mouseover = value; MB:ChangeMouseOverSetting() end,
				disabled = function() return not E.private.general.minimapbar.skinButtons or E.private.general.minimapbar.skinStyle == 'NOANCHOR' end,
			},
			mmbuttons = {
				order = 7,
				type = "group",
				name = L["Minimap Buttons"],
				guiInline = true,
				args = {
					mbgarrison = {
						order = 1,
						name = GARRISON_LOCATION_TOOLTIP,
						desc = L['TOGGLESKIN_DESC'],
						type = "toggle",
						disabled = function() return not E.private.general.minimapbar.skinButtons or E.private.general.minimapbar.skinStyle == 'NOANCHOR' end,
						set = function(info, value) E.private.general.minimapbar.mbgarrison = value; E:StaticPopup_Show("PRIVATE_RL") end,
					},
					mbcalendar = {
						order = 1,
						name = L['Calendar'],
						desc = L['TOGGLESKIN_DESC'],
						type = "toggle",
						disabled = function() return not E.private.general.minimapbar.skinButtons or E.private.general.minimapbar.skinStyle == 'NOANCHOR' end,
						set = function(info, value) E.private.general.minimapbar.mbcalendar = value; E:StaticPopup_Show("PRIVATE_RL") end,
					}
				}
			}
		}
	}
end

function EO:MiscOptions()
	local M = E:GetModule('CritMisc')

	E.Options.args.general.args.general.args.pvpautorelease = {
		order = 40,
		type = "toggle",
		name = ColorizeSettingName(L['PvP Autorelease']),
		desc = L['Automatically release body when killed inside a battleground.'],
		get = function(info) return E.private.general.pvpautorelease end,
		set = function(info, value) E.private.general.pvpautorelease = value; E:StaticPopup_Show("PRIVATE_RL") end,
	}
	
	E.Options.args.general.args.general.args.autorepchange = {
		order = 41,
		type = "toggle",
		name = ColorizeSettingName(L['Track Reputation']),
		desc = L['Automatically change your watched faction on the reputation bar to the faction you got reputation points for.'],
		get = function(info) return E.private.general.autorepchange end,
		set = function(info, value) E.private.general.autorepchange = value; end,
	}
	
	E.Options.args.general.args.general.args.movertransparancy = {
		order = 3,
		type = 'range',
    isPercent = true,
    name = ColorizeSettingName(L["Mover Transparency"]),
    desc = L["Changes the transparency of all the movers."],
    min = 0, max = 1, step = 0.01,
    set = function(info, value) E.db.general.movertransparancy = value M:UpdateMoverTransparancy() end,
    get = function(info) return E.db.general.movertransparancy end,
	}
end

function EO:RaidMarkerOptions()
	local RM = E:GetModule('RaidMarkerBar')
	
	E.Options.args.general.args.raidmarkerbar = {
		order = 7,
		get = function(info) return E.private.general.raidmarkerbar[ info[#info] ] end,	
		set = function(info, value) E.private.general.raidmarkerbar[ info[#info] ] = value; RM:ToggleSettings() end,
		type = "group",
		name = ColorizeSettingName(L['Raid Marker Bar']),
		args = {
			enable = {
				type = 'toggle',
				order = 2,
				name = L['Enable'],
				desc = L['Display a quick action bar for raid targets and world markers.'],	
			},
			visibility = {		
				type = 'select',
				order = 3,
				name = L["Visibility"],
				disabled = function() return not E.private.general.raidmarkerbar.enable end,
				values = raidmarkerVisibility,
			},
			backdrop = {
				type = 'toggle',
				order = 4,
				name = L["Backdrop"],
				disabled = function() return not E.private.general.raidmarkerbar.enable end,			
			},
			buttonSize = {
				order = 5,
				type = 'range',
				name = L['Button Size'],
				min = 16, max = 40, step = 1,
				disabled = function() return not E.private.general.raidmarkerbar.enable end,
			},
			spacing = {
				order = 6,
				type = 'range',
				name = L["Button Spacing"],
				min = 0, max = 10, step = 1,
				disabled = function() return not E.private.general.raidmarkerbar.enable end,
			},
			orientation = {
				order = 7,
				type = 'select',
				name = L['Orientation'],
				disabled = function() return not E.private.general.raidmarkerbar.enable end,
				values = {
					['HORIZONTAL'] = L['Horizontal'],
					['VERTICAL'] = L['Vertical'],
				},
			},
			modifier = {
				order = 8,
				type = 'select',
				name = L['Modifier Key'],
				desc = L['Set the modifier key for placing world markers.'],
				disabled = function() return not E.private.general.raidmarkerbar.enable end,
				values = {
					['shift-'] = L['Shift Key'],
					['ctrl-'] = L['Ctrl Key'],
					['alt-'] = L['Alt Key'],
				}
			}
		}
	}
end

function EO:UnitFramesOptions()
	local UF = E:GetModule('UnitFrames')

	--Target
	E.Options.args.unitframe.args.target.args.attackicon = {
		order = 1001,
		type = 'group',
		name = ColorizeSettingName(L['Attack Icon']),
		get = function(info) return E.db.unitframe.units['target']['attackicon'][ info[#info] ] end,
		set = function(info, value) E.db.unitframe.units['target']['attackicon'][ info[#info] ] = value end,
		args = {
			enable = {
				type = 'toggle',
				order = 1,
				name = L['Enable'],
				desc = L['Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked.'],
			},
			xOffset = {
				order = 4,
				type = 'range',
				name = L['xOffset'],
				min = -60, max = 60, step = 1,
			},
			yOffset = {
				order = 5,
				type = 'range',
				name = L['yOffset'],
				min = -60, max = 60, step = 1,
			},
		},
	}	
end


function EO:GetOptions()
	EO:DataTextOptions()
	EO:EquipmentOptions()
	EO:MapOptions()
	EO:MiscOptions()
	EO:RaidMarkerOptions()
	EO:UnitFramesOptions()
end

E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'] = {
	text = L['INCOMPATIBLE_ADDON'],
	OnAccept = function(self) DisableAddOn(E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].addon); ReloadUI(); end,
	OnCancel = function(self) E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].optiontable[E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].value] = false; ReloadUI(); end,
	timeout = 0,
	whileDead = 1,	
	hideOnEscape = false,	
}

E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON2'] = {
	text = L['INCOMPATIBLE_ADDON'],
	OnAccept = function(self) DisableAddOn(E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON2'].addon); ReloadUI(); end,
	timeout = 0,
	whileDead = 1,	
	hideOnEscape = false,	
}

function EO:IncompatibleAddOn(addon, module, optiontable, value)
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].button1 = addon
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].button2 = 'Enhanced: '..module
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].addon = addon
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].module = module
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].optiontable = optiontable
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].value = value
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON'].showAlert = true
	E:StaticPopup_Show('ENHANCED_INCOMPATIBLE_ADDON', addon, module)
end

function EO:IncompatibleAddOn2(addon, module)
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON2'].button1 = addon
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON2'].addon = addon
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON2'].module = module
	E.PopupDialogs['ENHANCED_INCOMPATIBLE_ADDON2'].showAlert = true
	E:StaticPopup_Show('ENHANCED_INCOMPATIBLE_ADDON2', addon, module)
end

function EO:CheckIncompatible()
	if E.global.ignoreIncompatible then return end

	if IsAddOnLoaded('SquareMinimapButtons') and E.private.general.minimapbar.skinButtons then
		EO:IncompatibleAddOn('SquareMinimapButtons', 'MinimapButtons', E.private.general.minimapbar, "skinButtons")
	end
	
	if IsAddOnLoaded('ElvUI_HyperDT') then
		EO:IncompatibleAddOn2('ElvUI_HyperDT', 'Enhanced Datatext')
	end
	if IsAddOnLoaded('ElvUI_TransparentMovers') then
		EO:IncompatibleAddOn2('ElvUI_TransparentMovers', 'Tranparent Movers')
	end
end

function EO:Initialize()
  EP:RegisterPlugin(ElvUICrit, EO.GetOptions)
  self:CheckIncompatible()
end

E:RegisterModule(EO:GetName())
