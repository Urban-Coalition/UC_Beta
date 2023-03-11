
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "Uzi"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[9x19mm submachine gun]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_uzi.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_uzi.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 72

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
}
SWEP.Sound_TailEXT				= {
	{ s = tail.."fire-dist-9x19-smg-ext-01.ogg" },
	{ s = tail.."fire-dist-9x19-smg-ext-02.ogg" },
	{ s = tail.."fire-dist-9x19-smg-ext-03.ogg" },
	{ s = tail.."fire-dist-9x19-smg-ext-04.ogg" },
	{ s = tail.."fire-dist-9x19-smg-ext-05.ogg" },
	{ s = tail.."fire-dist-9x19-smg-ext-06.ogg" },
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
SWEP.ShellScale							= 1
SWEP.QCA_Case							= 2

SWEP.QCA_Camera							= 3
SWEP.CameraCorrection					= Angle( 0, 0, -90 )

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
SWEP.RecoilSide				= 0.8
SWEP.RecoilSwing			= 1.5
SWEP.RecoilDrift			= 0.5
SWEP.RecoilDecay			= 5

--
-- Animation
--
SWEP.Animations				= {
	["idle"]	= {
		Source = "idle",
	},
	["draw"]	= {
		Source = "draw",
		Time = 0.4,
		ReloadingTime = 0.3,
		StopSightTime = 0.1,
	},
	["draw_empty"]	= {
		Source = "draw_empty",
		Time = 0.4,
		ReloadingTime = 0.3,
		StopSightTime = 0.1,
	},
	["holster"]	= {
		Source = "holster",
		Time = 0.3,
		HolsterTime = 0.2,
	},
	["holster_empty"]	= {
		Source = "holster_empty",
		Time = 0.3,
		HolsterTime = 0.2,
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