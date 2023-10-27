
-- Urban Coalition: Muzzles

-- Short
local att = {}
att.Name = "KAC Vertical Foregrip"
att.SortOrder = 3.0
att.ShortName = "KAC Vertical Foregrip"
att.ShortNameSubtitle = "VERTICAL GRIP"
att.Slot = "underbarrel"

att.Model = "models/weapons/arccw/atts/uc_kacvfg1.mdl"
att.ModelOffset0 = Vector( 0, 1, 0 )
att.ModelOffset1 = Vector( 0, -1, 0 )

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_ub_kacvfg")

local att = {}
att.Name = "BCM Stubby Foregrip"
att.SortOrder = 2.0
att.ShortName = "BCM Stubby Grip"
att.ShortNameSubtitle = "STUBBY GRIP"
att.Slot = "underbarrel"

att.Model = "models/weapons/arccw/atts/ud_foregrip_mod3.mdl"

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_ub_bcmvfg")

local att = {}
att.Name = "Magpul Angled Foregrip"
att.SortOrder = 1.0
att.ShortName = "Magpul Angled Foregrip"
att.ShortNameSubtitle = "ANGLED GRIP"
att.Slot = "underbarrel"

att.Model = "models/weapons/arccw/atts/uc_magpul_afg2.mdl"

att.Add_SightTime = (1/60)
Suburb_GenAtt(att, "uc_ub_mgpafg")

local att = {}
att.Name = "M203 Grenade Launcher"
att.SortOrder = -1.0
att.ShortName = "M203 Grenade Launcher"
att.ShortNameSubtitle = "UNDERSLUNG"
att.Slot = "underbarrel"

att.Model = "models/weapons/arccw/atts/uc_ubgl_m203.mdl"
att.ModelOffset = Vector( 0, 0.7, 1.3 )

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_ub_w_m203")

local att = {}
att.Name = "Masterkey Underslung Shotgun"
att.SortOrder = -2.0
att.ShortName = "Masterkey Shotgun"
att.ShortNameSubtitle = "UNDERSLUNG"
att.Slot = "underbarrel"

att.Model = "models/weapons/arccw/atts/uc_ubgl_masterkey.mdl"
att.ModelOffset = Vector( 0, 1.6, -0.4 )

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_ub_w_masterkey")