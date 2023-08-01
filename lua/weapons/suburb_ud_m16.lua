
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

SWEP.DefaultBodygroups = "0 3 0 0 1 4 2 7 0 0 0 2"
SWEP.DefaultBodygroups = "0 0 0 0 0 0 0 0 0 0 0 1"
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
SWEP.ShellScale							= 0.5
SWEP.QCA_Case							= 2

SWEP.QCA_Camera							= 3
SWEP.CameraCorrection					= Angle( 0, 0, -90 )

--
-- Functionality
--
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.ClipSize		= 30
SWEP.ChamberSize			= 1
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

SWEP.Accuracy				= 0.25

SWEP.Dispersion				= 3.5
SWEP.Dispersion_Air			= 2.5
SWEP.Dispersion_Move		= 2.5
SWEP.Dispersion_Crouch		= 0.75
SWEP.Dispersion_Sights		= 0

SWEP.SightTime				= 0.4
SWEP.SprintTime				= 0.4

--
-- Recoil
--
SWEP.RecoilUp				= 1.2
SWEP.RecoilSide				= 0.7
SWEP.RecoilPunch			= 0.2
SWEP.RecoilSwing			= 0.5
SWEP.RecoilDrift			= .8
SWEP.RecoilDecay			= 11

SWEP.UniversalAnimationInfo = {
	bone = "m16_parent",
	pos = Vector( 0, 0, 0 ),
	ang = Angle( 0, 0, 0 ),
}

--
-- Damage
--
SWEP.DamageNear				= ArcCW.UC.StdDmg["556"].max
SWEP.RangeNear				= 50
SWEP.DamageFar				= ArcCW.UC.StdDmg["556"].min
SWEP.RangeFar				= 300
SWEP.Force					= 5
SWEP.Penetration			= ArcCW.UC.StdDmg["556"].pen

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
		Time = 0.5,
		HolsterTime = 0.2,
	},
	["holster_empty"]	= {
		Source = "holster_empty",
		Time = 0.5,
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
		ReloadingTime = 2.0,
		LoadIn = 1.5,
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
		ReloadingTime = 2.4,
		LoadIn = 2.0,
	},
}

SWEP.Attachments = {
	{
		Name = "Rear Sight",
		SortOrder = 1.0,
		Icon = Material("entities/att/acwatt_ud_m16_rs_kac.png", "mips smooth"),
		Slot = "ud_m16_rs",
		ActivateElements = {"flattop"},

		Bone = "m16_parent",
		Pos = Vector(-1.652, 0, 0.5),
		Ang = Angle(90, -90, 0)
	},
	{
		Name = "Optical Sight",
		SortOrder = 1.1,
		Icon = Material("entities/att/acwatt_uc_optic_comp_m2.png", "mips smooth"),
		Slot = Sslot("optic_short", "optic_medium", "optic_hybrid", "optic_long"),
		ActivateElements = {"flattop"},

		Bone = "m16_parent",
		Pos = Vector(-1.652, 0, 2.0),
		Ang = Angle(90, -90, 0),

		Pos0 = Vector(-1.652, 0, 0),
		Pos1 = Vector(-1.652, 0, 5.5),
	},
	{
		Name = "Front Sight",
		SortOrder = 1.2,
		Icon = Material("entities/att/acwatt_ud_m16_fs_kac.png", "mips smooth"),
		Slot = "ud_m16_fs",
		ActivateElements = {"nofs"},

		Bone = "m16_parent",
		Pos = Vector(-1.652, 0, 12.5),
		Ang = Angle(90, -90, 0)
	},
	{
		Name = "Barrel",
		SortOrder = 2.0,
		Icon = Material("entities/att/acwatt_ud_m16_barrel_20.png", "mips smooth"),
		Slot = "ud_m16_barrel",
		DefaultAtt = "ud_m16_barrel_14"
	},
	{
		Name = "Handguard",
		SortOrder = 2.1,
		Icon = Material("entities/att/acwatt_ud_m16_hg_ribbed.png", "mips smooth"),
		Slot = "ud_m16_hg"
	},
	{
		Name = "Upper Receiver",
		SortOrder = 2.2,
		Icon = Material("entities/att/acwatt_ud_m16_receiver_auto.png", "mips smooth"),
		Slot = "ud_m16_ur"
	},
	{
		Name = "Lower Receiver",
		SortOrder = 2.3,
		Icon = Material("entities/att/acwatt_ud_m16_receiver_default.png", "mips smooth"),
		Slot = "ud_m16_lr"
	},
	{
		Name = "Stock",
		SortOrder = 2.4,
		Icon = Material("entities/att/acwatt_ud_m16_stock_default.png", "mips smooth"),
		Slot = "ud_m16_stock"
	},
	{
		Name = "Magazine",
		SortOrder = 2.5,
		Icon = Material("entities/att/acwatt_ud_m16_mag_30.png", "mips smooth"),
		Slot = "ud_m16_mag"
	},
	{
		Name = "Muzzle",
		SortOrder = 3.0,
		Icon = Material("entities/att/acwatt_uc_muzzle_fhider1.png", "mips smooth"),
		Slot = Sslot("muzzle_break", "muzzle_suppressor"),

		Bone = "m16_parent",
		Pos = Vector(-0.35, 0, 19.53),
		Ang = Angle(90, -90, 0),
	},
	{
		Name = "Tactical",
		SortOrder = 3.1,
		Icon = Material("entities/att/acwatt_uc_tac_anpeq16a.png", "mips smooth"),
		Slot = "tactical"
	},
	{
		Name = "Underbarrel",
		SortOrder = 3.2,
		Icon = Material("entities/att/acwatt_uc_grip_kacvfg.png", "mips smooth"),
		Slot = "underbarrel"
	},
}

SWEP.Elements = {
	["barrel_10"] = {
		Bodygroups = { [4] = 2, [5] = 4, [6] = 2, [11] = 3 }
	},
	["barrel_14"] = {
		Bodygroups = { [4] = 1, [5] = 4, [6] = 2, [11] = 2 }
	},
	["flattop"] = {
		Bodygroups = { [1] = 1, [3] = 2 }
	},
	["hg_ris"] = {
		Bodygroups = { [5] = 2 }
	},
	["stock_carbine"] = {
		Bodygroups = { [7] = 7 }
	},
	["stock_wire"] = {
		Bodygroups = { [7] = 1 }
	},
	["stock_slide"] = {
		Bodygroups = { [7] = 4 }
	},
	["stock_cap"] = {
		Bodygroups = { [7] = 6 }
	},
	["stock_wood"] = {
		Bodygroups = { [7] = 9 }
	},
	["ud_m16_ur_classic"] = {
		Bodygroups = { [1] = 3 },
		AttPos = {
			[1] = { Pos = Vector( -3.45, 0, 0.9 ), Ang = Angle( -90, 90, 0 ) },
			[2] = { Pos = Vector( -3.45, 0, 2 ), Ang = Angle( -90, 90, 0 ) },
			[3] = { Pos = Vector( -3.45, 0, 5.8 ), Ang = Angle( -90, 90, 0 ) },
		}
	},
	["ud_m16_mag_20"] = {
		Bodygroups = { [2] = 1 },
	},
	["ud_m16_mag_40"] = {
		Bodygroups = { [2] = 2 },
	},
	["ud_m16_mag_60"] = {
		Bodygroups = { [2] = 3 },
	},
	["ud_m16_mag_100"] = {
		Bodygroups = { [2] = 4 },
	},
}

function SWEP:Hook_PreRegenBGTab()
	local ae = self.ActivatedElements
end

function SWEP:Hook_RegenBGTab( bgtab )
	local ae = self.ActivatedElements
	local shortbarrel = (ae["barrel_14"] or ae["barrel_10"])
	if shortbarrel then
		if ae["hg_ris"] then
			bgtab[5] = 5
		end
	end
	if ae["nofs"] then
		bgtab[6] = 5
	end
	if ae["ud_m16_ur_classic"] and ae["flattop"] then
		bgtab[3] = 1
		bgtab[1] = 3
	end
end