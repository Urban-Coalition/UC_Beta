
-- Urban Coalition: Optics

-- Short
local att = {}
att.Name = "Sightmark Sure Shot"
att.ShortName = "Sure Shot"
att.ShortNameSubtitle = "REFLEX"
att.Slot = "optic_short"
Suburb_GenAtt(att, "uc_optic_sureshot")

local att = {}
att.Name = "Holosun HS510C"
att.ShortName = "Holosun"
att.ShortNameSubtitle = "REFLEX"
att.Slot = {"optic_short"}

att.Model = "models/editor/axis_helper.mdl"
att.ModelScale = Vector(0.1, 0.1, 0.1)
Suburb_GenAtt(att, "uc_optic_holosun")

-- Hybrid
local att = {}
att.Name = "EOTech 553 + G33"
att.ShortName = "EOTech 553 + G33"
att.ShortNameSubtitle = "HOLO / 2x OPTICAL"
att.Slot = Sslot( "optic_hybrid", "optic_short" )

att.Model = "models/weapons/arccw/atts/uc_gso_eotech.mdl"
att.ModelOffset = Vector(-0.03, 0, 0)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(1.2, 1.2, 1.2)
Suburb_GenAtt(att, "uc_optic_eotech553")

local att = {}
att.Name = "EOTech 552"
att.ShortName = "EOTech 552"
att.ShortNameSubtitle = "HOLO"
att.Slot = Sslot( "optic_short" )

att.Model = "models/weapons/arccw/atts/uc_eotech552.mdl"
att.ModelOffset = Vector(0.07, 0, 0)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(0.6, 0.6, 0.6)
Suburb_GenAtt(att, "uc_optic_eotech552")

-- Medium
local att = {}
att.Name = "Trijicon Advanced Combat Optical Gunsight"
att.ShortName = "ACOG"
att.ShortNameSubtitle = "4x OPTICAL"
att.Slot = "optic_medium"
Suburb_GenAtt(att, "uc_optic_acog")

local att = {}
att.Name = "ELCAN C79"
att.ShortName = "ELCAN"
att.ShortNameSubtitle = "2.5x OPTICAL"
att.Slot = "optic_medium"
Suburb_GenAtt(att, "uc_optic_elcan")

-- Long