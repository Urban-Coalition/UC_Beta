
-- Urban Decay: M16

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