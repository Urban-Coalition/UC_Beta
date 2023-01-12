
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "Uzi"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[Iconic 9x19mm sub-machine gun.]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_uzi.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_uzi.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 65

SWEP.ActivePose = {
	Pos = Vector( 0.4, -3, 0.7 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.IronsightPose = {
	Pos = Vector( -2.865, -7, 1.95 ),
	Ang = Angle( 0, 0, 0 ),
	MidPos = Vector( -0.8, 0, -0.3 ),
	MidAng = Angle( 0, 0, -6 ),
	ViewModelFOV = 65,
	Magnification = 1.2,
}

SWEP.HoldTypeHip			= "ar2"
SWEP.HoldTypeSight			= "rpg"
SWEP.HoldTypeSprint			= "passive"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/uzi/"
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
SWEP.Primary.ClipSize		= 32
SWEP.Delay					= ( 60 / 700 )

SWEP.Firemodes				= {
	{
		Mode = math.huge,
	},
	{
		Mode = 1,
	}
}
SWEP.SwayCorrection = 0.35

SWEP.Accuracy				= 1

SWEP.Dispersion				= 2
SWEP.Dispersion_Air			= 1
SWEP.Dispersion_Move		= 1
SWEP.Dispersion_Crouch		= 0.75
SWEP.Dispersion_Sights		= 0

SWEP.SightTime				= 0.35
SWEP.SprintTime				= 0.35

--
-- Recoil
--
SWEP.RecoilUp				= 1.4
SWEP.RecoilSide				= 1.8
SWEP.RecoilSwing			= 1.5
SWEP.RecoilDrift			= 0.5
SWEP.RecoilDecay			= 5

--
-- Animation
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
		Time = 2.1,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_pull_small.ogg" },
			{ t = 0.2,			s = p1.."magout.ogg" },
			{ t = 0.5,			s = p1.."magin.ogg" },
		},
		ReloadingTime = 1.8,
		LoadIn = 1.1,
	},
	["reload_empty"] = {
		Source = "reload_empty",
		Time = 3.1,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_pull_small.ogg" },
			{ t = 0.3,			s = p1.."magout.ogg" },
			{ t = 1.0,			s = p1.."magin.ogg" },
			{ t = 2.0,			s = p1.."chback.ogg" },
			{ t = 2.25,			s = p1.."chforward.ogg" },
		},
		ReloadingTime = 2.8,
		LoadIn = 2.4,
	},
}