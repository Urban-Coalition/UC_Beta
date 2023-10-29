
-- Urban Coalition: Optics

-- Short
local att = {}
att.Name = "Sightmark Sure Shot"
att.SortOrder = 1
att.ShortName = "Sure Shot"
att.ShortNameSubtitle = "REFLEX"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_sureshot.mdl"
att.ModelScale = Vector(0.9, 0.9, 0.9)

att.Sights = {
	{
		Reflex = true,
		ReflexOverlay = {
			{
				ReflexSize = 64, -- at 720p
				ReflexOverlay = Material("hud/reticles/uc_reddot.png", "ignorez mips smooth"),
				ReflexColor = "colorable"
			},
			{
				ReflexSize = 32, -- at 720p
				ReflexOverlay = Material("hud/reticles/uc_reddot.png", "ignorez mips smooth"),
				ReflexColor = color_white
			}
		},
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, 90, 0 ),
		StencilTest = "10",

		Pos = Vector( 0, -12.5, 1.24 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (0.5/60)
Suburb_GenAtt(att, "uc_optic_sureshot")

local att = {}
att.Name = "Holosun HS510C"
att.SortOrder = 1
att.ShortName = "Holosun"
att.ShortNameSubtitle = "REFLEX"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_holosun2.mdl"
att.ModelOffset = Vector( 0, 0, 0 )
att.ModelScale = Vector(1.5, 1.5, 1.5)

att.ModelOffset0 = Vector( 0, 0, 0 )
att.ModelOffset1 = Vector( 0, -2, 0 )

att.Sights = {
	{
		Reflex = true,
		ReflexOverlay = {
			{
				ReflexSize = 64, -- at 720p
				ReflexOverlay = Material("hud/reticles/uc_reddot.png", "ignorez mips smooth"),
				ReflexColor = "colorable"
			},
			{
				ReflexSize = 32, -- at 720p
				ReflexOverlay = Material("hud/reticles/uc_reddot.png", "ignorez mips smooth"),
				ReflexColor = color_white
			}
		},
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, 90, 0 ),
		StencilTest = "10",

		Pos = Vector( 0, -12.5, 1.0 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (0.5/60)
Suburb_GenAtt(att, "uc_optic_holosun")

-- Hybrid
local att = {}
att.Name = "EOTech 553 + G33"
att.SortOrder = 2
att.ShortName = "EOTech 553 + G33"
att.ShortNameSubtitle = "HOLO / OPTICAL 2x"
att.Slot = "optic_hybrid"

att.Model = "models/weapons/arccw/atts/uc_gso_eotech.mdl"
att.ModelOffset = Vector(0, 0, 0.03)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(1.2, 1.2, 1.2)

att.ModelOffset0 = Vector( 0, 1, 0 )
att.ModelOffset1 = Vector( 0, -2, 0 )
att.Sights = {
	{
		Reflex = true,
		ReflexOverlay = {
			{
				ReflexSize = 26, -- at 720p
				ReflexOverlay = Material("hud/reticles/ud_holo_flare.png", "ignorez smooth"),
				ReflexColor = "colorable"
			},
			{
				ReflexSize = 26, -- at 720p
				ReflexOverlay = Material("hud/reticles/ud_holo_64.png", "ignorez smooth"),
				ReflexColor = color_white
			},
		},
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, 90, 0 ),
		StencilTest = "10",

		Pos = Vector( 0, -12.5, 1.38 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (1/60)
Suburb_GenAtt(att, "uc_optic_eotech553")

local att = {}
att.Name = "EOTech G33"
att.SortOrder = 2
att.ShortName = "EOTech G33"
att.ShortNameSubtitle = "HOLO / OPTICAL 2x"
att.Slot = "optic_hybrid"

att.Model = "models/weapons/arccw/atts/uc_eotechg33.mdl"
att.ModelOffset = Vector(0, 0, 0)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(1, 1, 1)	

att.ModelOffset0 = Vector( 0, -1, 0 )
att.ModelOffset1 = Vector( 0, -2, 0 )
att.Sights = {
	{
		OpticRT = true,
		OpticRTMaterialIndex = 1,
		OpticRTMagnification = 2.2,
		OpticRTOverlay = Material("hud/scopes/uc_acog_reticle.png", "ignorez smooth"),
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0.09, -180.08, 0 ), -- I don't fucking know why this happens.
		OpticAtt_Bottom = 2,
		StencilTest = "10",

		Pos = Vector( 0.0, -12.5, 1.54048 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (1/60)
Suburb_GenAtt(att, "uc_optic_eotechg33")

local att = {}
att.Name = "EOTech 552"
att.SortOrder = 1
att.ShortName = "EOTech 552"
att.ShortNameSubtitle = "HOLO"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_eotech552.mdl"
att.ModelOffset = Vector(0, 0, -0.05)
att.ModelAngle = Angle(0, 0, 0)
att.ModelScale = Vector(0.6, 0.6, 0.6)

att.ModelOffset0 = Vector( 0, 1, 0 )
att.ModelOffset1 = Vector( 0, -3, 0 )

att.Sights = {
	{
		Reflex = true,
		ReflexOverlay = {
			{
				ReflexSize = 26, -- at 720p
				ReflexOverlay = Material("hud/reticles/ud_holo_flare.png", "ignorez smooth"),
				ReflexColor = "colorable"
			},
			{
				ReflexSize = 26, -- at 720p
				ReflexOverlay = Material("hud/reticles/ud_holo_64.png", "ignorez smooth"),
				ReflexColor = color_white
			},
		},
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, 90, 0 ),
		StencilTest = "10",

		Pos = Vector( 0, -12.5, 1.20 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (0.5/60)
Suburb_GenAtt(att, "uc_optic_eotech552")

-- Medium
local att = {}
att.Name = "Trijicon Advanced Combat Optical Gunsight"
att.SortOrder = 3
att.ShortName = "ACOG"
att.ShortNameSubtitle = "OPTICAL 3x"
att.Slot = "optic_medium"

att.Model = "models/weapons/arccw/atts/ud_acog.mdl"
att.ModelScale = Vector(1.15, 1.15, 1.15)

att.ModelOffset0 = Vector( 0, 1, 0 )
att.ModelOffset1 = Vector( 0, -2, 0 )

att.Sights = {
	{
		OpticRT = true,
		OpticRTMaterialIndex = 1,
		OpticRTMagnification = 2.2,
		OpticRTOverlay = Material("hud/scopes/uc_acog_reticle.png", "ignorez smooth"),
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, -90, 0 ),
		OpticAtt_Bottom = 2,
		StencilTest = "101",

		Pos = Vector( 0, -8, 1.49 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
	{
		Pos = Vector( 0, -8, 2.38 ),
		Ang = Angle( -0.9, 0, 0 ),
		ViewModelFOV = 60,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_optic_acog")

local att = {}
att.Name = "ELCAN C79"
att.SortOrder = 2.5
att.ShortName = "ELCAN"
att.ShortNameSubtitle = "OPTICAL 2.5x"
att.Slot = "optic_medium"

att.Model = "models/weapons/arccw/atts/uc_gso_elcan.mdl"

att.ModelOffset0 = Vector( 0, 1, 0 )
att.ModelOffset1 = Vector( 0, -3, 0 )

att.Sights = {
	{
		OpticRT = true,
		OpticRTMaterialIndex = 2,
		OpticRTMagnification = 2.5,
		OpticRTOverlay = Material("hud/scopes/uc_elcan.png", "ignorez smooth"),
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, -90, 0 ),
		OpticAtt_Bottom = 2,
		StencilTest = "10",

		Pos = Vector( 0, -8, 1.515 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
	{
		Pos = Vector( 0, -8, 2.63 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 60,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_optic_elcan")

local att = {}
att.Name = "Leupold High Accuracy Multi-Range Riflescope"
att.SortOrder = 3
att.ShortName = "HAMR"
att.ShortNameSubtitle = "REFLEX / OPTICAL 3x"
att.Slot = "optic_medium"

att.Model = "models/weapons/arccw/atts/uc_gso_hamr.mdl"
att.ModelOffset = Vector( 0, -0.5, -0.07 )

att.ModelOffset0 = Vector( 0, 2, 0 )
att.ModelOffset1 = Vector( 0, -1.5, 0 )

att.Sights = {
	{
		OpticRT = true,
		OpticRTMaterialIndex = 1,
		OpticRTMagnification = 2.5,
		OpticRTOverlay = Material("hud/scopes/uc_hamr.png", "ignorez mips smooth"),
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, 90, 0 ),
		OpticAtt_Bottom = 3,
		StencilTest = "1011",

		Pos = Vector( 0, -8, 1.466 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
	{
		Reflex = true,
		ReflexOverlay = {
			{
				ReflexSize = 64, -- at 720p
				ReflexOverlay = Material("hud/reticles/uc_reddot.png", "ignorez mips smooth"),
				ReflexColor = "colorable"
			},
			{
				ReflexSize = 32, -- at 720p
				ReflexOverlay = Material("hud/reticles/uc_reddot.png", "ignorez mips smooth"),
				ReflexColor = color_white
			}
		},
		StencilTest = "1101",

		Pos = Vector( 0, -12, 2.887 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_optic_hamr")

-- Long

local att = {}
att.Name = "Trijicon TARS"
att.SortOrder = 8
att.ShortName = "TARS"
att.ShortNameSubtitle = "OPTICAL 2-8x"
att.Slot = "optic_short"

att.Model = "models/weapons/arccw/atts/uc_trijicon_tars.mdl"
att.ModelOffset = Vector(0, 0.5, 0)

att.ModelOffset0 = Vector( 0, 0.5, 0 )
att.ModelOffset1 = Vector( 0, -2.5, 0 )

att.Sights = {
	{
		OpticRT = true,
		OpticRTMaterialIndex = 1,
		OpticRTMagnification = 1,
		OpticRTMagnificationMax = 8,
		OpticRTOverlay = Material("hud/scopes/uc_tars_reticle.png", "ignorez smooth"),
		OpticAtt_Center = 1,
		OpticAtt_Rotate = Angle( 0, -90, 0 ),
		OpticAtt_Bottom = 2,
		StencilTest = "10",

		Pos = Vector( 0, -12, 1.3662 ),
		Ang = Angle( 0, 0, 0 ),
		ViewModelFOV = 30,
		Magnification = 1.3,
	},
}

att.Add_SightTime = (4/60)
Suburb_GenAtt(att, "uc_optic_tars")