
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
	Pos = Vector( 0, -3, 1 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.IronsightPose = {
	Pos = Vector( -2.3, -4, 2.52 ),
	Ang = Angle( 0.3, 0, 0 ),
	MidPos = Vector( -0.4, 0, -0.4 ),
	MidAng = Angle( 0, 0, -6 ),
	ViewModelFOV = 65,
	Magnification = 1.1,
}

SWEP.HoldTypeHip			= "pistol"
SWEP.HoldTypeSight			= "revolver"
SWEP.HoldTypeSprint			= "normal"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/glock/"
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
	{ s = p1.."fire-dist-01.ogg" },
	{ s = p1.."fire-dist-02.ogg" },
	{ s = p1.."fire-dist-03.ogg" },
	{ s = p1.."fire-dist-04.ogg" },
	{ s = p1.."fire-dist-05.ogg" },
	{ s = p1.."fire-dist-06.ogg" },
}
SWEP.Sound_TailINT				= {
	{ s = p0.."fire-dist-int-pistol-01.ogg" },
	{ s = p0.."fire-dist-int-pistol-02.ogg" },
	{ s = p0.."fire-dist-int-pistol-03.ogg" },
	{ s = p0.."fire-dist-int-pistol-04.ogg" },
	{ s = p0.."fire-dist-int-pistol-05.ogg" },
	{ s = p0.."fire-dist-int-pistol-06.ogg" },
}

SWEP.MuzzleEffect						= "muzzleflash_1"
SWEP.QCA_Muzzle							= 1

SWEP.ShellModel							= "models/weapons/arccw/uc_shells/9x19.mdl"
SWEP.ShellScale							= 1
SWEP.QCA_Case							= 2

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

SWEP.Accuracy				= 2

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
		Time = 1.8,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_pull_small.ogg" },
			{ t = 0.3,			s = p1.."magout_partial.ogg" },
			{ t = 0.4,			s = p1.."magin_new.ogg" },

			{ t = 0,			s = Ssnd.rottle },
			{ t = 0.3,			s = Ssnd.rattlepistol },
			{ t = 0.35,			s = Ssnd.rattlepistol },
			{ t = 0.5,			s = Ssnd.rottle },
		},
		ReloadingTime = 1.6,
		LoadIn = 1,
	},
	["reload_empty"] = {
		Source = "reload_empty",
		Time = 2.2,
		Events = {
			{ t = 0.1,			s = p1.."magout_empty.ogg" },
			{ t = 0.2,			s = p0.."magpouch_pull_small.ogg" },
			{ t = 0.5,			s = p1.."magin_new.ogg" },
			{ t = 1.37,			s = p1.."chamber.ogg" },

			{ t = 0,			s = Ssnd.rattlepistol },
			{ t = 0.5,			s = Ssnd.rattlepistol },
			{ t = 1.15,			s = Ssnd.rottle },
		},
		ReloadingTime = 1.7,
		LoadIn = 1.45,
	},
}