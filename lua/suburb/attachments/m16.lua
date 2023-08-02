
-- Urban Decay: M16

-- Ironsights

local att = {}
att.Name = "M16 irons - KAC rear"
att.ShortName = "KAC"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/kac_rs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_rs_kac")

local att = {}
att.Name = "M16 irons - KAC front"
att.ShortName = "KAC"
att.Slot = "ud_m16_fs"

att.Model = "models/weapons/arccw/atts/kac_fs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_fs_kac")

local att = {}
att.Name = "M16 irons - Scalerworks rear"
att.ShortName = "Scalerworks"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/scalerworks_rs.mdl"
att.ModelOffset = Vector(0.1, -0.007, -1)
att.ModelScale = Vector(0.94, 0.94, 0.94)
Suburb_GenAtt(att, "ud_m16_rs_scalerworks")

local att = {}
att.Name = "M16 irons - Scalerworks front"
att.ShortName = "Scalerworks"
att.Slot = "ud_m16_fs"

att.Model = "models/weapons/arccw/atts/scalerworks_fs.mdl"
att.ModelOffset = Vector(0.1, -0.007, 0)
att.ModelScale = Vector(0.94, 0.94, 0.94)
Suburb_GenAtt(att, "ud_m16_fs_scalerworks")

local att = {}
att.Name = "M16 irons - Magpul rear"
att.ShortName = "Magpul"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/magpul_rs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_rs_magpul")

local att = {}
att.Name = "M16 irons - Magpul front"
att.ShortName = "Magpul"
att.Slot = "ud_m16_fs"

att.Model = "models/weapons/arccw/atts/magpul_fs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_fs_magpul")

local att = {}
att.Name = "M16 irons - SIG rear"
att.ShortName = "SIG"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/sig_rs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_rs_sig")

local att = {}
att.Name = "M16 irons - SIG front"
att.ShortName = "SIG"
att.Slot = "ud_m16_fs"

att.Model = "models/weapons/arccw/atts/sig_fs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_fs_sig")

local att = {}
att.Name = "M16 irons - Colt rear"
att.ShortName = "COLT"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/colt_rs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_rs_colt")

local att = {}
att.Name = "M16 irons - Colt carry handle"
att.ShortName = "CARRY HANDLE"
att.Slot = "ud_m16_rs"

att.Model = "models/weapons/arccw/atts/colt_ch.mdl"
att.ModelOffset = Vector(0.1, 0, 0.2)
att.ModelScale = Vector(0.78, 0.74, 0.74)
Suburb_GenAtt(att, "ud_m16_rs_coltch")

local att = {}
att.Name = "M16 irons - Colt front"
att.ShortName = "COLT"
att.Slot = "ud_m16_fs"

att.Model = "models/weapons/arccw/atts/colt_fs.mdl"
att.ModelScale = Vector(0.67, 0.67, 0.67)
Suburb_GenAtt(att, "ud_m16_fs_colt")

-- Barrels

local att = {}
att.Name = "M16 Commando 10.5\" Barrel"
att.ShortName = "10.5\" Commando Barrel"
att.Slot = "ud_m16_barrel"

att.ActivateElements = {"barrel_10"}

att.Mult_Delay = 0.9
att.Mult_SightTime = 0.8
Suburb_GenAtt(att, "ud_m16_barrel_10")

local att = {}
att.Name = "M16 Carbine 14\" Barrel"
att.ShortName = "14.5\" Carbine Barrel"
att.Slot = "ud_m16_barrel"

att.ActivateElements = {"barrel_14"}

att.Mult_Delay = 0.9
att.Mult_SightTime = 0.9
Suburb_GenAtt(att, "ud_m16_barrel_14")

-- Stocks

local att = {}
att.Name = "M16 Carbine Stock"
att.ShortName = "Carbine Stock"
att.Slot = "ud_m16_stock"
Suburb_GenAtt(att, "ud_m16_stock_carbine")

local att = {}
att.Name = "M16 M231 FPW Wire Stock"
att.ShortName = "M231 Wire Stock"
att.Slot = "ud_m16_stock"
Suburb_GenAtt(att, "ud_m16_stock_wire")

local att = {}
att.Name = "M16 M607 Slide Stock"
att.ShortName = "M607 Slide Stock"
att.Slot = "ud_m16_stock"
Suburb_GenAtt(att, "ud_m16_stock_slide")

local att = {}
att.Name = "M16 M608 Cap Stock"
att.ShortName = "M608 Cap Stock"
att.Slot = "ud_m16_stock"
Suburb_GenAtt(att, "ud_m16_stock_cap")

local att = {}
att.Name = "M16 Wooden Stock"
att.ShortName = "Wooden Stock"
att.Slot = "ud_m16_stock"
Suburb_GenAtt(att, "ud_m16_stock_wood")

-- Handguards

local att = {}
att.Name = "M16 RIS Handguard"
att.ShortName = "RIS Handguard"
att.Slot = "ud_m16_hg"
Suburb_GenAtt(att, "ud_m16_hg_ris")

local att = {}
att.Name = "M16A1 Handguard"
att.ShortName = "A1 Handguard"
att.Slot = "ud_m16_hg"
Suburb_GenAtt(att, "ud_m16_hg_a1")

local att = {}
att.Name = "M16 Wooden Handguard"
att.ShortName = "Wooden Handguard"
att.Slot = "ud_m16_hg"
Suburb_GenAtt(att, "ud_m16_hg_wood")

-- Magazines

local att = {}
att.Name = "M16 STANAG 100-Round C-Mag"
att.SortOrder = 100
att.ShortName = "100-Round C-Mag"
att.ShortNameSubtitle = "100 RND"
att.Slot = "ud_m16_mag"

att.Mult_Capacity = ( 100 / 30 )
att.Mult_SightTime = 2
Suburb_GenAtt(att, "ud_m16_mag_100")

local att = {}
att.Name = "M16 STANAG 60-Round Casket Magazine"
att.SortOrder = 60
att.ShortName = "60-Round Casket Magazine"
att.ShortNameSubtitle = "60 RND"
att.Slot = "ud_m16_mag"

att.Mult_Capacity = ( 60 / 30 )
att.Mult_SightTime = 1.5
Suburb_GenAtt(att, "ud_m16_mag_60")

local att = {}
att.Name = "M16 STANAG 40-Round Extended Magazine"
att.SortOrder = 40
att.ShortName = "40-Round Extended Magazine"
att.ShortNameSubtitle = "40 RND"
att.Slot = "ud_m16_mag"

att.Mult_Capacity = ( 40 / 30 )
att.Mult_SightTime = 1.2
Suburb_GenAtt(att, "ud_m16_mag_40")

local att = {}
att.Name = "M16 STANAG 20-Round Compact Magazine"
att.SortOrder = 20
att.ShortName = "20-Round Compact Magazine"
att.ShortNameSubtitle = "20 RND"
att.Slot = "ud_m16_mag"

att.Mult_Capacity = ( 20 / 30 )
att.Mult_SightTime = 0.9
Suburb_GenAtt(att, "ud_m16_mag_20")

-- Upper receivers

local att = {}
att.Name = "M16A1 Upper Receiver"
att.ShortName = "Classic Upper"
att.Slot = "ud_m16_ur"
Suburb_GenAtt(att, "ud_m16_ur_classic")

-- Lower receivers

local att = {}
att.Name = "M16A3 Automatic Lower Receiver"
att.ShortName = "Automatic Lower"
att.Slot = "ud_m16_lr"

att.Override_Firemodes = {
	{
		Mode = math.huge,
	},
	{
		Mode = 1,
	},
}
Suburb_GenAtt(att, "ud_m16_lr_auto")

local att = {}
att.Name = "AR-15 Sporter Lower Receiver"
att.ShortName = "Sporter Lower"
att.Slot = "ud_m16_lr"

att.Override_Firemodes = {
	{
		Mode = 1,
	},
}
Suburb_GenAtt(att, "ud_m16_lr_semi")

local att = {}
att.Name = "AR-15GB Manual-Action Lower Receiver"
att.ShortName = "Manual-Action Lower"
att.Slot = "ud_m16_lr"

att.Override_ManualAction = 1
att.Override_Firemodes = {
	{
		Mode = 1,
	},
}
Suburb_GenAtt(att, "ud_m16_lr_bolt")