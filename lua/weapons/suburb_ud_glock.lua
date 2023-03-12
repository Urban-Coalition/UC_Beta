
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "Glock 17"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[9x19mm pistol]]
SWEP.Trivia = {
	"Year",
	"1989",
	"Mechanism",
	"Short-recoil",
	"Country",
	"Austria",
	"Manufacturer",
	"Glock Ges.m.b.H.",
}
SWEP.Slot					= 1

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_glock.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_glock.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 72

SWEP.ActivePose = {
	Pos = Vector( 0, -2, 1 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.CrouchPose = {
	Pos = Vector(-2.5, -2, -0.5),
	Ang = Angle(0, 0, -20),
}
SWEP.IronsightPose = {
	Pos = Vector( -1.73, -3, 2.35 ),
	Ang = Angle( 0.7, 0, 0 ),
	MidPos = Vector( -0.5, -1, -0.3 ),
	MidAng = Angle( 0, 0, 0 ),
	ViewModelFOV = 65,
	Magnification = 1.05,
}
SWEP.SwayCorrection = 0.33

SWEP.HoldTypeHip			= "pistol"
SWEP.HoldTypeSight			= "revolver"
SWEP.HoldTypeSprint			= "normal"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/glock/"
local tail = ")/arccw_uc/common/9x19/"
SWEP.Sound_Blast			= {
	{ s = p1.."fire-01.ogg" },
	{ s = p1.."fire-02.ogg" },
	{ s = p1.."fire-03.ogg" },
	{ s = p1.."fire-04.ogg" },
	{ s = p1.."fire-05.ogg" },
	{ s = p1.."fire-06.ogg" },
}
SWEP.Sound_Mech				= {
	{ s = p1.."mech-01.ogg" },
	{ s = p1.."mech-02.ogg" },
	{ s = p1.."mech-03.ogg" },
	{ s = p1.."mech-04.ogg" },
	{ s = p1.."mech-05.ogg" },
	{ s = p1.."mech-06.ogg" },
}
SWEP.Sound_TailEXT				= {
	{ s = tail.."fire-dist-9x19-pistol-ext-01.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-ext-02.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-ext-03.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-ext-04.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-ext-05.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-ext-06.ogg" }
}
SWEP.Sound_TailINT				= {
	{ s = tail.."fire-dist-9x19-pistol-int-01.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-int-02.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-int-03.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-int-04.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-int-05.ogg" },
	{ s = tail.."fire-dist-9x19-pistol-int-06.ogg" },
}

SWEP.MuzzleEffect						= "muzzleflash_1"
SWEP.QCA_Muzzle							= 1

SWEP.ShellModel							= "models/weapons/arccw/uc_shells/9x19.mdl"
SWEP.ShellScale							= .666
SWEP.QCA_Case							= 2

SWEP.QCA_Camera							= 3
SWEP.CameraCorrection					= Angle( 0, -90, -90 )

--
-- Functionality
--
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.ClipSize		= 17
SWEP.ChamberSize			= 1
SWEP.Delay					= ( 60 / 450 )

SWEP.Firemodes				= {
	{
		Mode = 1,
	}
}

SWEP.Accuracy				= 1

SWEP.Dispersion				= 3
SWEP.Dispersion_Air			= 2
SWEP.Dispersion_Move		= 2
SWEP.Dispersion_Crouch		= 0.75
SWEP.Dispersion_Sights		= 0

SWEP.SightTime				= 0.3
SWEP.SprintTime				= 0.3

--
-- Recoil
--
SWEP.RecoilUp				= 1.2
SWEP.RecoilSide				= 2
SWEP.RecoilSwing			= 1
SWEP.RecoilDrift			= 0.7
SWEP.RecoilDecay			= 10

--
-- Animation
--
SWEP.Animations				= {
	["idle"]	= {
		Source = "idle",
	},
	["idle_empty"]	= {
		Source = "idle_empty",
	},
	["draw"]	= {
		Source = "draw",
		ReloadingTime = 0.2,
		StopSightTime = 0.1,
		Events = {
			{ t = 0,			s = Ssnd.draw_pistol },
			{ t = 0.1,			s = p0.."raise.ogg", },
		},
	},
	["draw_empty"]	= {
		Source = "draw_empty",
		ReloadingTime = 0.2,
		StopSightTime = 0.1,
	},
	["holster"]	= {
		Source = "holster",
		Time = 0.3,
		HolsterTime = 0.1,
	},
	["holster_empty"]	= {
		Source = "holster_empty",
		Time = 0.3,
		HolsterTime = 0.1,
	},
	["fire"]	= {
		Source = "fire",
		ShellEjectTime = 0,
	},
	["fire_empty"] = {
		Source = "fire_empty",
		ShellEjectTime = 0,
	},
	["reload"]	= {
		Source = "reload",
		Time = 2.2,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_pull_small.ogg" },
			{ t = 0.2,			s = p0.."magpouch_partial_start.ogg" },
			{ t = 0.5,			s = p1.."magout_partial.ogg" },
			{ t = 0.65,			s = p1.."magin_new.ogg" },
			{ t = 1.375,		s = p0.."magpouch_replace_small.ogg" },
			{ t = 1.8,			s = p1.."grab.ogg" },

			{ t = 0,			s = Ssnd.rottle },
			{ t = 0.5,			s = Ssnd.rottle },
			{ t = 1.2,			s = Ssnd.rottle },
		},
		ReloadingTime = 1.6,
		LoadIn = 1.3,
	},
	["reload_empty"] = {
		Source = "reload_empty",
		Time = 2.4,
		Events = {
			{ t = 0.1,			s = p1.."magout_empty.ogg" },
			{ t = 0.4,			s = p0.."magpouch_pull_small.ogg" },
			{ t = 0.55,			s = p1.."magin_new.ogg" },
			{ t = 1.5,			s = p1.."chamber.ogg" },
			{ t = 1.95,			s = p1.."grab.ogg" },

			{ t = 0,			s = Ssnd.rattlepistol },
			{ t = 0.5,			s = Ssnd.rattlepistol },
			{ t = 1.15,			s = Ssnd.rottle },
			{ t = 1.5,			s = Ssnd.rottle },
		},
		ReloadingTime = 2.0,
		LoadIn = 1.65,
	},
}