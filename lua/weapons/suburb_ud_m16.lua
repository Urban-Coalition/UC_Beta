
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "M16A2"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[Iconic 5.56x45mm assault rifle.]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_m16.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_m16.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 75

SWEP.ActivePose = {
	Pos = Vector( 0.5, -2, 0.75 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.CrouchPose = {
	Pos = Vector(-2.5, -2, -0.6),
	Ang = Angle(0, 0, -14),
	MidPos = Vector( -0.2, 0, -0.5 ),
	MidAng = Angle( 0, 0, 0 ),
}
SWEP.IronsightPose = {
	Pos = Vector( -2.81, -6, 1.32 ),
	Ang = Angle( 0, 0, 0 ),
	MidPos = Vector( -1.15, 0.5, -0.5 ),
	MidAng = Angle( -0.5, 0, -6 ),
	ViewModelFOV = 65,
	Magnification = 1.3,
}

SWEP.HoldTypeHip			= "ar2"
SWEP.HoldTypeSight			= "rpg"
SWEP.HoldTypeSprint			= "passive"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/m16/"
local tail = ")/arccw_uc/common/556x45/"
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
	{ s = tail.."fire-dist-556x45-rif-ext-01.ogg" },
	{ s = tail.."fire-dist-556x45-rif-ext-02.ogg" },
	{ s = tail.."fire-dist-556x45-rif-ext-03.ogg" },
	{ s = tail.."fire-dist-556x45-rif-ext-04.ogg" },
	{ s = tail.."fire-dist-556x45-rif-ext-05.ogg" },
	{ s = tail.."fire-dist-556x45-rif-ext-06.ogg" },
}
SWEP.Sound_TailINT				= {
	{ s = p0.."fire-dist-int-rifle-01.ogg" },
	{ s = p0.."fire-dist-int-rifle-02.ogg" },
	{ s = p0.."fire-dist-int-rifle-03.ogg" },
	{ s = p0.."fire-dist-int-rifle-04.ogg" },
	{ s = p0.."fire-dist-int-rifle-05.ogg" },
	{ s = p0.."fire-dist-int-rifle-06.ogg" },
}

SWEP.MuzzleEffect						= "muzzleflash_1"
SWEP.QCA_Muzzle							= 1

SWEP.ShellModel							= "models/weapons/arccw/uc_shells/556x45.mdl"
SWEP.ShellScale							= 1
SWEP.QCA_Case							= 2

SWEP.QCA_Camera							= 3
SWEP.CameraCorrection					= Angle( 0, 0, -90 )

--
-- Functionality
--
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.ClipSize		= 30
SWEP.Delay					= ( 60 / 900 )

SWEP.Firemodes				= {
	{
		Mode = math.huge,
	},
	{
		Mode = 3,
	},
	{
		Mode = 1,
	},
}
SWEP.SwayCorrection = 0.45

SWEP.Accuracy				= 6

SWEP.Dispersion				= 5
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

SWEP.UniversalAnimationInfo = {
	bone = "m16_parent",
	pos = Vector( 0, 0, 0 ),
	ang = Angle( 0, 0, 0 ),
}

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
	["fire"]	= {
		Source = "fire",
	},
	["fire_empty"] = {
		Source = "fire_empty",
	},
	["reload"]	= {
		Source = "reload",
		Time = 2.4,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_gear.ogg" },
			{ t = 0.3,			s = p1.."magout_empty.ogg" },
			{ t = 0.95,			s = p1.."magin.ogg" },

			{ t = 0.0,			s = Ssnd.rottle },
			{ t = 0.25,			s = Ssnd.rattle },
			{ t = 0.5,			s = Ssnd.rattle },
			{ t = 1.1,			s = Ssnd.rattle },
			{ t = 1.39,			s = Ssnd.rottle },
			{ t = 1.9,			s = Ssnd.rattle },
		},
		ReloadingTime = 1.8,
		LoadIn = 1.6,
	},
	["reload_empty"] = {
		Source = "reload_empty",
		Time = 2.9,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_gear.ogg" },
			{ t = 0.3,			s = p1.."magout_empty.ogg" },
			{ t = 0.95,			s = p1.."magin.ogg" },
			{ t = 1.7,			s = p1.."boltdrop.ogg" },

			{ t = 0.0,			s = Ssnd.rottle },
			{ t = 0.25,			s = Ssnd.rattle },
			{ t = 0.5,			s = Ssnd.rattle },
			{ t = 1.1,			s = Ssnd.rattle },
			{ t = 1.39,			s = Ssnd.rottle },
			{ t = 1.9,			s = Ssnd.rattle },
		},
		ReloadingTime = 2.5,
		LoadIn = 1.8,
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