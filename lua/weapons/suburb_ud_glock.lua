
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "Glock 17"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[Iconic 9x19mm pistol.]]
SWEP.Slot					= 1

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_glock.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_glock.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 65

SWEP.ActivePose = {
	Pos = Vector( 0.2, -1, 2-1 ),
	Ang = Angle( 0, 0, -5 )
}
SWEP.IronsightPose = {
	Pos = Vector( -2.3, -4, 2.52 ),
	Ang = Angle( 0.3, 0, 0 ),
	MidPos = Vector( -0.3, 0, -0.5 ),
	MidAng = Angle( 0, 0, 0 ),
	ViewModelFOV = 65,
	Magnification = 1.1,
}

SWEP.HoldTypeHip			= "pistol"
SWEP.HoldTypeSight			= "revolver"
SWEP.HoldTypeSprint			= "normal"

SWEP.Sound_Blast			= {
	{ s = ")weapons/arccw_ud/glock/fire-01.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-02.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-03.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-04.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-05.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-06.ogg" },
}
SWEP.Sound_Mech				= {
	{ s = ")weapons/arccw_ud/glock/mech-01.ogg" },
	{ s = ")weapons/arccw_ud/glock/mech-02.ogg" },
	{ s = ")weapons/arccw_ud/glock/mech-03.ogg" },
	{ s = ")weapons/arccw_ud/glock/mech-04.ogg" },
	{ s = ")weapons/arccw_ud/glock/mech-05.ogg" },
	{ s = ")weapons/arccw_ud/glock/mech-06.ogg" },
}
SWEP.Sound_TailEXT				= {
	{ s = ")weapons/arccw_ud/glock/fire-dist-01.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-dist-02.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-dist-03.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-dist-04.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-dist-05.ogg" },
	{ s = ")weapons/arccw_ud/glock/fire-dist-06.ogg" },
}
SWEP.Sound_TailINT				= {
	{ s = ")arccw_uc/common/fire-dist-int-pistol-01.ogg" },
	{ s = ")arccw_uc/common/fire-dist-int-pistol-02.ogg" },
	{ s = ")arccw_uc/common/fire-dist-int-pistol-03.ogg" },
	{ s = ")arccw_uc/common/fire-dist-int-pistol-04.ogg" },
	{ s = ")arccw_uc/common/fire-dist-int-pistol-05.ogg" },
	{ s = ")arccw_uc/common/fire-dist-int-pistol-06.ogg" },
}

--
-- Functionality
--
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.ClipSize		= 17
SWEP.Delay					= ( 60 / 450 )

SWEP.Firemodes				= {
	{
		Mode = 1,
	}
}

--
-- Sexyness
--
SWEP.Animations				= {
	["draw"]	= {
		Source = "draw",
	},
	["draw_empty"]	= {
		Source = "draw_empty",
	},
	["holster"]	= {
		Source = "holster",
	},
	["holster_empty"]	= {
		Source = "holster_empty",
	},
	["fire"]	= {
		Source = "fire",
	},
	["fire_empty"] = {
		Source = "fire_empty",
	},
	["reload"]	= {
		Source = "reload",
		Events = {
			{ t = 0.2,			s = "common/left.wav" },
			{ t = 0.7,			s = "common/right.wav" },
		},
		ReloadingTime = 2,
		LoadIn = 1,
	},
	["reload_empty"] = {
		Source = "reload_empty",
		Events = {
			{ t = 0.2,			s = "common/left.wav" },
			{ t = 0.7,			s = "common/right.wav" },
			{ t = 1.2,			s = "common/center.wav" },
		},
		ReloadingTime = 2,
		LoadIn = 1.5,
	},
}