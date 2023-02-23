
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "Remington 870"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[Iconic 12 gauge shotgun.]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_870.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_870.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 75

SWEP.ActivePose = {
	Pos = Vector( -0.6, -6, 0.25 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.CrouchPose = {
	Pos = Vector(-2.5, -2, -0.6),
	Ang = Angle(0, 0, -14),
	MidPos = Vector( -0.2, 0, -0.5 ),
	MidAng = Angle( 0, 0, 0 ),
}
SWEP.IronsightPose = {
	Pos = Vector( -3.66, -3, 2.2 ),
	Ang = Angle( -0.75, 0, 2.8 ),
	MidPos = Vector( -1.15, -2, -1 ),
	MidAng = Angle( -0.5, 0, -6 ),
	ViewModelFOV = 65,
	Magnification = 1.3,
}

SWEP.HoldTypeHip			= "ar2"
SWEP.HoldTypeSight			= "rpg"
SWEP.HoldTypeSprint			= "passive"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/870/"
local tail = ")/arccw_uc/common/12ga/"
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
	{ s = tail.."fire-dist-12ga-pasg-ext-01.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-02.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-03.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-04.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-05.ogg" },
	{ s = tail.."fire-dist-12ga-pasg-ext-06.ogg" },
}
SWEP.Sound_TailINT				= {
	{ s = p0.."fire-dist-int-shotgun-01.ogg" },
	{ s = p0.."fire-dist-int-shotgun-02.ogg" },
	{ s = p0.."fire-dist-int-shotgun-03.ogg" },
	{ s = p0.."fire-dist-int-shotgun-04.ogg" },
	{ s = p0.."fire-dist-int-shotgun-05.ogg" },
	{ s = p0.."fire-dist-int-shotgun-06.ogg" },
}

SWEP.MuzzleEffect						= "muzzleflash_shotgun"
SWEP.QCA_Muzzle							= 1

SWEP.ShellModel							= "models/weapons/arccw/uc_shells/12g.mdl"
SWEP.ShellScale							= 0.5
SWEP.QCA_Case							= 2

SWEP.QCA_Camera							= 3
SWEP.CameraCorrection					= Angle( 0, -90, -90 )

--
-- Functionality
--
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.ClipSize		= 6
SWEP.Delay					= ( 60 / 120 )

SWEP.Firemodes				= {
	{
		Mode = 1,
	},
}
SWEP.SwayCorrection = 0.45

SWEP.Accuracy				= 4

SWEP.Dispersion				= 4
SWEP.Dispersion_Air			= 3
SWEP.Dispersion_Move		= 3
SWEP.Dispersion_Crouch		= 0.75
SWEP.Dispersion_Sights		= 0

SWEP.SightTime				= 0.4
SWEP.SprintTime				= 0.4

--
-- Recoil
--
SWEP.RecoilUp				= 1
SWEP.RecoilSide				= 0.6
SWEP.RecoilSwing			= 1
SWEP.RecoilDrift			= .8
SWEP.RecoilDecay			= 15

--
-- Damage
--
SWEP.DamageNear				= ArcCW.UC.StdDmg["12g_p"].max
SWEP.RangeNear				= 5
SWEP.DamageFar				= ArcCW.UC.StdDmg["12g_p"].min
SWEP.RangeFar				= 50
SWEP.Force					= 5
SWEP.Penetration			= ArcCW.UC.StdDmg["12g_p"].pen
SWEP.Pellets				= ArcCW.UC.StdDmg["12g_p"].num

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
SWEP.ManualAction			= 1
SWEP.Animations				= {
	["idle"]	= {
		Source = "idle",
	},
	["idle_empty"]	= {
		Source = "idle_empty",
	},
	["draw"]	= {
		Source = "draw",
		ReloadingTime = 0.3,
		StopSightTime = 0.1,
	},
	["draw_empty"]	= {
		Source = "draw_empty",
		ReloadingTime = 0.3,
		StopSightTime = 0.1,
	},
	["holster"]	= {
		Source = "holster",
		Time = 0.3,
		HolsterTime = 0.15,
	},
	["holster_empty"]	= {
		Source = "holster_empty",
		Time = 0.3,
		HolsterTime = 0.15,
	},
	["cycle"]	= {
		Source = "cycle",
		Events = {
			{s = Ssnd.rottle, t = 0},
			{s = p1 .. "rack_1.ogg",  t = 0},
			{s = p1 .. "eject.ogg",  t = 0.1},
			{s = p1 .. "rack_2.ogg",  t = 0.11},
		},
		ShellEjectTime = 0.1,
		CycleDelayTime = 0.3,
	},
	["fire"]	= {
		Source = "fire",
		CycleDelayTime = 0.3,
	},
	["sgreload_start"] = {
		Source = "sgreload_start",
		Time = 0.5,
		Events = {
		},
		ShotgunReloadingTime = 0.3,
	},
	["sgreload_insert"] = {
		Source = "sgreload_insert",
		Time = 0.6,
		Events = {
			{s = Ssnd.rottle, t = 0},
			{s = shellin, t = 0.05},
		},
		LoadIn = 0.3,
		AmountToLoad = 1,
		ShotgunReloadingTime = 0.5,
	},
	["sgreload_finish"] = {
		Source = "sgreload_finish",
		Time = 0.5,
		Events = {
			{s = Ssnd.rottle, t = 0},
			{s = p0 .. "shoulder.ogg",  t = 0.27},
		},
		ReloadingTime = 0,
	},
	["sgreload_finish_empty"] = {
		Source = "sgreload_finish_empty",
		Time = 1.1,
		Events = {
			{s = Ssnd.rottle, t = 0.5},
			{s = p1 .. "rack_1.ogg",  t = 0.3},
			{s = p1 .. "eject.ogg",  t = 0.4},
			{s = p1 .. "rack_2.ogg",  t = 0.425},
			{s = p0 .. "shoulder.ogg",  t = 0.8},
		},
		ReloadingTime = 0,
	},
}

SWEP.Attachments = {
	{
		Name = "Rear Sight",
		SortOrder = 1.0,
	},
	{
		Name = "Optical Sight",
		SortOrder = 1.1,
	},
	{
		Name = "Front Sight",
		SortOrder = 1.2,
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
		Name = "Upper Receiver",
		SortOrder = 2.2,
	},
	{
		Name = "Lower Receiver",
		SortOrder = 2.3,
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

SWEP.Elements = {}