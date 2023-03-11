
SWEP.Base					= "suburb"
SWEP.Spawnable				= true

--
-- Description
--
SWEP.PrintName				= "M16A2"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[5.56x45mm assault rifle]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_m16.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_m16.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 72

SWEP.DefaultBodygroups = "0 0 0 0 0 0 0 0 0 0 0 1"
SWEP.DefaultBodygroups = "0 3 0 0 1 4 2 7 0 0 0 2"
SWEP.DefaultSkin = 0

SWEP.ActivePose = {
	Pos = Vector( 0.5, -2, 0.75 ),
	Ang = Angle( 0, 0, -3 )
}
SWEP.CrouchPose = {
	Pos = Vector(-2.5, -2, -1.6),
	Ang = Angle(0, 0, -8),
	MidPos = Vector( -0.2, 0, -0.5 ),
	MidAng = Angle( 0, 0, 0 ),
}
SWEP.IronsightPose = {
	Pos = Vector( -2.81, -6, 1.32 ),
	Ang = Angle( 0, 0, 0 ),
	MidPos = Vector( -1.15, 2, -0.4 ),
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
	{ s = tail.."fire-dist-556x45-rif-int-01.ogg" },
	{ s = tail.."fire-dist-556x45-rif-int-02.ogg" },
	{ s = tail.."fire-dist-556x45-rif-int-03.ogg" },
	{ s = tail.."fire-dist-556x45-rif-int-04.ogg" },
	{ s = tail.."fire-dist-556x45-rif-int-05.ogg" },
	{ s = tail.."fire-dist-556x45-rif-int-06.ogg" },
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

SWEP.Accuracy				= 1

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
		ShellEjectTime = 0,
	},
	["fire_empty"] = {
		Source = "fire_empty",
		ShellEjectTime = 0,
	},
	["reload"]	= {
		Source = "reload",
		Time = 2.4,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_gear.ogg" },
			{ t = 0.2,			s = p1.."magout_empty.ogg" },
			{ t = 1.0,			s = p1.."struggle.ogg" },
			{ t = 0.95,			s = p1.."magin.ogg" },
			{ t = 1.77,			s = p0.."grab-polymer.ogg" },
			{ t = 1.8,			s = p0.."shoulder.ogg" },

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
			{ t = 0.2,			s = p1.."magout_empty.ogg" },
			{ t = 0.95,			s = p1.."struggle.ogg" },
			{ t = 0.95,			s = p1.."magin.ogg" },
			{ t = 1.7,			s = p1.."boltdrop.ogg" },
			{ t = 2.2,			s = p0.."grab-polymer.ogg" },
			{ t = 2.3,			s = p0.."shoulder.ogg" },

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
		Icon = Material("entities/att/acwatt_ud_m16_rs_kac.png", "mips smooth")
	},
	{
		Name = "Optical Sight",
		SortOrder = 1.1,
		Icon = Material("entities/att/acwatt_uc_optic_comp_m2.png", "mips smooth")
	},
	{
		Name = "Front Sight",
		SortOrder = 1.2,
		Icon = Material("entities/att/acwatt_ud_m16_fs_kac.png", "mips smooth")
	},
	{
		Name = "Barrel",
		SortOrder = 2.0,
		Icon = Material("entities/att/acwatt_ud_m16_barrel_20.png", "mips smooth")
	},
	{
		Name = "Handguard",
		SortOrder = 2.1,
		Icon = Material("entities/att/acwatt_ud_m16_hg_ribbed.png", "mips smooth")
	},
	{
		Name = "Upper Receiver",
		SortOrder = 2.2,
		Icon = Material("entities/att/acwatt_ud_m16_receiver_auto.png", "mips smooth")
	},
	{
		Name = "Lower Receiver",
		SortOrder = 2.3,
		Icon = Material("entities/att/acwatt_ud_m16_receiver_default.png", "mips smooth")
	},
	{
		Name = "Magazine",
		SortOrder = 2.4,
		Icon = Material("entities/att/acwatt_ud_m16_mag_30.png", "mips smooth")
	},
	{
		Name = "Muzzle",
		SortOrder = 3.0,
		Icon = Material("entities/att/acwatt_uc_muzzle_fhider1.png", "mips smooth")
	},
	{
		Name = "Tactical",
		SortOrder = 3.1,
		Icon = Material("entities/att/acwatt_uc_tac_anpeq16a.png", "mips smooth")
	},
	{
		Name = "Underbarrel",
		SortOrder = 3.2,
		Icon = Material("entities/att/acwatt_uc_grip_kacvfg.png", "mips smooth")
	},
}

SWEP.Elements = {}