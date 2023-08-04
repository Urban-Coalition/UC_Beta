
-- Urban Coalition: Optics

-- Short
local att = {}
att.Name = "Sightmark Sure Shot"
att.SortOrder = 2
att.ShortName = "Sure Shot"
att.ShortNameSubtitle = "REFLEX"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_sureshot.mdl"
att.ModelScale = Vector(0.9, 0.9, 0.9)
Suburb_GenAtt(att, "uc_optic_sureshot")

local att = {}
att.Name = "Holosun HS510C"
att.SortOrder = 2
att.ShortName = "Holosun"
att.ShortNameSubtitle = "REFLEX"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_holosun2.mdl"
att.ModelOffset = Vector( 0, 0, -1 )
att.ModelScale = Vector(1.5, 1.5, 1.5)
Suburb_GenAtt(att, "uc_optic_holosun")

-- Hybrid
local att = {}
att.Name = "EOTech 553 + G33"
att.SortOrder = 4
att.ShortName = "EOTech 553 + G33"
att.ShortNameSubtitle = "HOLO / OPTICAL 2x"
att.Slot = "optic_hybrid"

att.Model = "models/weapons/arccw/atts/uc_gso_eotech.mdl"
att.ModelOffset = Vector(-0.03, 0, 0)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(1.2, 1.2, 1.2)
Suburb_GenAtt(att, "uc_optic_eotech553")

local att = {}
att.Name = "EOTech 552"
att.SortOrder = 3
att.ShortName = "EOTech 552"
att.ShortNameSubtitle = "HOLO"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_eotech552.mdl"
att.ModelOffset = Vector(0.07, 0, 0)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(0.6, 0.6, 0.6)
Suburb_GenAtt(att, "uc_optic_eotech552")

-- Medium
local att = {}
att.Name = "Trijicon Advanced Combat Optical Gunsight"
att.SortOrder = 5
att.ShortName = "ACOG"
att.ShortNameSubtitle = "OPTICAL 4x"
att.Slot = "optic_medium"

att.Model = "models/weapons/arccw/atts/ud_acog.mdl"
att.ModelScale = Vector(1.15, 1.15, 1.15)

att.Sights = {
	{
		RTScope = true,
		RTScopeMat = 1,
		RTScopeMagnfiication = 2.5,
		RTScopeAtt_Center = 1,
		RTScopeAtt_Bottom = 2,
		RTScopeOverlay = Material("hud/scopes/uc_acog_reticle.png", "smooth"),

		Pos = Vector( -2.809, -4.7, 1.01 ),
		Ang = Angle( 0, 0, 0 ),
		MidPos = Vector( -1.15, 2, -0.4 ), -- See if I can inherit this from the weapon.
		MidAng = Angle( -0.5, 0, -6 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}
Suburb_GenAtt(att, "uc_optic_acog")

local att = {}
att.Name = "ELCAN C79"
att.SortOrder = 5
att.ShortName = "ELCAN"
att.ShortNameSubtitle = "OPTICAL 2.5x"
att.Slot = "optic_medium"

att.Model = "models/weapons/arccw/atts/uc_gso_elcan.mdl"

att.Sights = {
	{
		RTScope = true,
		RTScopeMat = 2,
		RTScopeMagnfiication = 2.5,
		RTScopeAtt_Center = 1,
		RTScopeAtt_Bottom = 2,
		RTScopeOverlay = Material("hud/scopes/uc_elcan.png", "smooth"),

		Pos = Vector( -2.809, -4.7, 1.01 ),
		Ang = Angle( 0, 0, 0 ),
		MidPos = Vector( -1.15, 2, -0.4 ),
		MidAng = Angle( -0.5, 0, -6 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}
Suburb_GenAtt(att, "uc_optic_elcan")

-- Long

local att = {}
att.Name = "Trijicon TARS"
att.SortOrder = 6
att.ShortName = "TARS"
att.ShortNameSubtitle = "OPTICAL 10x"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_trijicon_tars.mdl"
att.ModelOffset = Vector(0, 0, 0.5)
Suburb_GenAtt(att, "uc_optic_tars")