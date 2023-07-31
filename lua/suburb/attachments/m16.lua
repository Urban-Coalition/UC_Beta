
-- Urban Decay: M16

-- Ironsights

local att = {}
att.Name = "M16 irons - KAC rear"
att.ShortName = "KAC"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/kac_rs.mdl"
att.ModelScale = Vector(0.68, 0.68, 0.68)
Suburb_GenAtt(att, "ud_m16_rs_kac")

local att = {}
att.Name = "M16 irons - KAC front"
att.ShortName = "KAC"
att.Slot = "ud_m16_fs"

att.Model = "models/weapons/arccw/atts/kac_fs.mdl"
att.ModelScale = Vector(0.68, 0.68, 0.68)
Suburb_GenAtt(att, "ud_m16_fs_kac")

-- Barrels

local att = {}
att.Name = "M16 10 Inch Barrel"
att.ShortName = "10.5 inch barrel"
att.Slot = "ud_m16_barrel"

att.ActivateElements = {"barrel_10"}
Suburb_GenAtt(att, "ud_m16_barrel_10")

local att = {}
att.Name = "M16 14 Inch Barrel"
att.ShortName = "14.5 inch barrel"
att.Slot = "ud_m16_barrel"

att.ActivateElements = {"barrel_14"}
Suburb_GenAtt(att, "ud_m16_barrel_14")

-- Stocks

local att = {}
att.Name = "M16 Carbine Stock"
att.ShortName = "Carbine Stock"
att.Slot = "ud_m16_stock"

att.ActivateElements = {"stock_carbine"}
Suburb_GenAtt(att, "ud_m16_stock_carbine")

-- Stocks

local att = {}
att.Name = "M16 RIS Handguard"
att.ShortName = "RIS Handguard"
att.Slot = "ud_m16_hg"

att.ActivateElements = {"hg_ris"}
Suburb_GenAtt(att, "ud_m16_hg_ris")

-- Lower receivers

local att = {}
att.Name = "M16A3 Automatic Lower Receiver"
att.ShortName = "Automatic Lower"
att.Slot = "ud_m16_lr"
Suburb_GenAtt(att, "ud_m16_lr_auto")

local att = {}
att.Name = "AR-15 Sporter Lower Receiver"
att.ShortName = "Sporter Lower"
att.Slot = "ud_m16_lr"
Suburb_GenAtt(att, "ud_m16_lr_semi")

local att = {}
att.Name = "AR-15GB Manual-Action Lower Receiver"
att.ShortName = "Manual-Action Lower"
att.Slot = "ud_m16_lr"
Suburb_GenAtt(att, "ud_m16_lr_bolt")