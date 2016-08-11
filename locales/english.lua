-- English localization file for enUS and enGB.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("ElvUI", "enUS", true);

if not L then return end

-- Init
L["CRIT_LOGIN_MSG"] = "You are using |cff1784d1ElvUI |r|cffc7c7cfCrit|r UI version %s%s|r."

-- Equipment
L["Equipment"] = true
L["No Change"] = true

L["DURABILITY_DESC"] = "Adjust the settings for the durability information on the character screen."
L['Enable/Disable the display of durability information on the character screen.'] = true
L["Damaged Only"] = true
L["Only show durabitlity information for items that are damaged."] = true

L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
L["Enable/Disable the display of item levels on the character screen."] = true

L["Miscellaneous"] = true
L['Equipment Set Overlay'] = true
L['Show the associated equipment sets for the items in your bags (or bank).'] = true

-- Movers
L["Mover Transparency"] = true
L["Changes the transparency of all the movers."] = true

-- Automatic Role Assignment
L['Automatic Role Assignment'] = true
L['Enables the automatic role assignment based on specialization for party / raid members (only work when you are group leader or group assist).'] = true

-- Attack Icon
L['Attack Icon'] = true
L['Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked.'] = true

-- Minimap Buttons
L["Minimap Button Bar"] = true
L['Skin Buttons'] = 'Enable'
L['Skins the minimap buttons in Elv UI style.'] = 'Enable the minimap button bar and skin the buttons in ElvUI style.'
L['Skin Style'] = true
L['Change settings for how the minimap buttons are skinned.'] = true
L['The size of the minimap buttons.'] = true

L['No Anchor Bar'] = true
L['Horizontal Anchor Bar'] = true
L['Vertical Anchor Bar'] = true

L['Layout Direction'] = true
L['Normal is right to left or top to bottom, or select reversed to switch directions.'] = true
L['Normal'] = true
L['Reversed'] = true

-- PvP Autorelease
L['PvP Autorelease'] = true
L['Automatically release body when killed inside a battleground.'] = true

-- Track Reputation
L['Track Reputation'] = true
L['Automatically change your watched faction on the reputation bar to the faction you got reputation points for.'] = true

-- Select Quest Reward
L['Select Quest Reward'] = true
L['Automatically select the quest reward with the highest vendor sell value.'] = true

-- Item Level Datatext
L['Item Level'] = true

-- Range Datatext
L['Target Range'] = true
L['Distance'] = true

-- Extra Datatexts
L['Actionbar1DataPanel'] = 'Actionbar 1'
L['Actionbar3DataPanel'] = 'Actionbar 3'
L['Actionbar5DataPanel'] = 'Actionbar 5'

-- Raid Marker Bar
L['Raid Marker Bar'] = true
L['Display a quick action bar for raid targets and world markers.'] = true
L['Modifier Key'] = true
L['Set the modifier key for placing world markers.'] = true
L['Shift Key'] = true
L['Ctrl Key'] = true
L['Alt Key'] = true
L["Raid Markers"] = true
L["Click to clear the mark."] = true
L["Click to mark the target."] = true
L["%sClick to remove all worldmarkers."] = true
L["%sClick to place a worldmarker."] = true
