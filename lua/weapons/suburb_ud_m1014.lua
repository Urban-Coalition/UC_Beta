
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "Benelli M4"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[12 gauge shotgun]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_m1014.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_m1014.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 72

SWEP.ActivePose = {
	Pos = Vector( -0.4, -2, -0.2 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.CrouchPose = {
	Pos = Vector(-2.5, -2, -0.6),
	Ang = Angle(0, 0, -14),
	MidPos = Vector( -0.2, 0, -0.5 ),
	MidAng = Angle( 0, 0, 0 ),
}
SWEP.IronsightPose = {
	Pos = Vector( -2.73, -4, 1.1 ),
	Ang = Angle( 0.25, 0, 0 ),
	MidPos = Vector( -0.5, 0.5, 0.5 ),
	MidAng = Angle( -0.5, 1, 3 ),
	ViewModelFOV = 65,
	Magnification = 1.3,
}

SWEP.HoldTypeHip			= "ar2"
SWEP.HoldTypeSight			= "rpg"
SWEP.HoldTypeSprint			= "passive"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/m1014/"
local p2 = ")weapons/arccw_ud/870/"
local tail = ")arccw_uc/common/12ga/"
SWEP.Sound_Blast			= {
	{ s = p2.."fire-01.ogg" },
	{ s = p2.."fire-02.ogg" },
	{ s = p2.."fire-03.ogg" },
	{ s = p2.."fire-04.ogg" },
	{ s = p2.."fire-05.ogg" },
	{ s = p2.."fire-06.ogg" },
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
	{ s = tail.."fire-dist-12ga-pasg-ext-01.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-02.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-03.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-04.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-05.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-06.ogg" },
}
SWEP.Sound_TailINT				= {
	{ s = tail.."fire-dist-12ga-pasg-int-01.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-int-02.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-int-03.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-int-04.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-int-05.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-int-06.ogg" },
}

SWEP.MuzzleEffect						= "muzzleflash_shotgun"
SWEP.QCA_Muzzle							= 1

SWEP.ShellModel							= "models/weapons/arccw/uc_shells/12g.mdl"
SWEP.ShellScale							= 0.5
SWEP.QCA_Case							= 2

SWEP.QCA_Camera							= 3
SWEP.CameraCorrection					= Angle( 0, 0, -90 )

--
-- Functionality
--
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.ClipSize		= 7
SWEP.ChamberSize			= 1
SWEP.Delay					= ( 60 / 220 )

SWEP.Firemodes				= {
	{
		Mode = 1,
	},
}
SWEP.SwayCorrection = 0.52

SWEP.Accuracy				= 3

SWEP.Dispersion				= 4
SWEP.Dispersion_Air			= 3.2
SWEP.Dispersion_Move		= 3.2
SWEP.Dispersion_Crouch		= 0.75
SWEP.Dispersion_Sights		= 0

SWEP.SightTime				= 0.4
SWEP.SprintTime				= 0.4

--
-- Recoil
--
SWEP.RecoilUp				= 7
SWEP.RecoilSide				= 6
SWEP.RecoilPunch			= 0.2
SWEP.RecoilSwing			= 2
SWEP.RecoilDrift			= .6
SWEP.RecoilDecay			= 8

--
-- Damage
--
SWEP.DamageNear				= ArcCW.UC.StdDmg["12g_s"].max
SWEP.RangeNear				= 4
SWEP.DamageFar				= ArcCW.UC.StdDmg["12g_s"].min
SWEP.RangeFar				= 40
SWEP.Force					= 5
SWEP.Penetration			= ArcCW.UC.StdDmg["12g_s"].pen
SWEP.Pellets				= ArcCW.UC.StdDmg["12g_s"].num

SWEP.UniversalAnimationInfo = {
	bone = "m16_parent",
	pos = Vector( 0, 0, 0 ),
	ang = Angle( 0, 0, 0 ),
}

--
-- Animation
--
local shellin = {
	p1 .. "shell-insert-01.ogg",
	p1 .. "shell-insert-02.ogg",
	p1 .. "shell-insert-03.ogg"
}
SWEP.ShotgunReloading		= true
SWEP.Animations				= {
	["idle"]	= {
		Source = "idle",
	},
	["idle_empty"]	= {
		Source = "idle_empty",
	},
	["draw"]	= {
		Source = "draw",
		Time = 0.8,
		ReloadingTime = 0.4,
		StopSightTime = 0.3,
	},
	["draw_empty"]	= {
		Source = "draw_empty",
		Time = 0.8,
		ReloadingTime = 0.4,
		StopSightTime = 0.3,
	},
	["holster"]	= {
		Source = "holster",
		Time = 0.4,
		ReloadingTime = 0.4,
		HolsterTime = 0.3,
	},
	["holster_empty"]	= {
		Source = "holster_empty",
		Time = 0.4,
		ReloadingTime = 0.4,
		HolsterTime = 0.3,
	},
	["fire"]	= {
		Source = "fire",
		ShellEjectTime = 0,
	},
	["fire_empty"] = {
		Source = "fire_empty",
		ShellEjectTime = 0,
	},
	["sgreload_start_empty"] = {
		Source = "sgreload_start_empty",
		Time = 1.33,
		Events = {
			{s = Ssnd.rottle, 					t = 0},
			{s = p1 .. "breechload.ogg",		t = 0.05},
			{s = p1 .. "breechclose.ogg",		t = 0.75},
		},
		ShotgunReloadingTime = 1.2,
		LoadIn = 0.9,
		AmountToLoad = 1,
	},
	["sgreload_start"] = {
		Source = "sgreload_start",
		Time = 0.6,
		Events = {
		},
		ShotgunReloadingTime = 0.45,
	},
	["sgreload_insert"] = {
		Source = "sgreload_insert",
		Time = 0.75,
		Events = {
			{s = shellin, t = 0},
			{s = Ssnd.rottle, t = 0.05},
		},
		LoadIn = 0.3,
		AmountToLoad = 1,
		ShotgunReloadingTime = 0.75,
	},
	["sgreload_finish"] = {
		Source = "sgreload_finish",
		Time = 0.8,
		Events = {
		},
		ReloadingTime = 0,
	},
}

SWEP.Attachments = {
	{
		Name = "Optical Sight",
		SortOrder = 1.1,
		Slot = QT("optic_short", "optic_medium", "optic_hybrid", "optic_long"),

		Bone = "1014_parent",
		Pos = Vector(0, 2.0, 1.392),
		Ang = Angle(90, -90, 0),
	},
	{
		Name = "Barrel",
		SortOrder = 2.0,
	},
	{
		Name = "Handguard",
		SortOrder = 2.1,
	},
	{
		Name = "Muzzle",
		SortOrder = 3.0,
	},
	{
		Name = "Tactical",
		SortOrder = 3.1,
	},
	{
		Name = "Underbarrel",
		SortOrder = 3.2,
	},
}

SWEP.Elements = {
	["test"] = {
		Model = "models/props_junk/wood_crate001a.mdl",
		Bone = "1014_parent",
		Pos = Vector(-2, 0, 2),
		Ang = Angle(0, -90, 0),
		Scale = Vector(0.03, 0.03, 0.03),
	}
}