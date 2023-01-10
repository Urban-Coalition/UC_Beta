
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
SWEP.IronsightPose = {
	Pos = Vector( -2.81, -5, 1.32 ),
	Ang = Angle( 0, 0, 0 ),
	MidPos = Vector( -0.3, 0, -0.5 ),
	MidAng = Angle( 0, 0, -3 ),
	ViewModelFOV = 65,
	Magnification = 1.3,
}

SWEP.HoldTypeHip			= "ar2"
SWEP.HoldTypeSight			= "rpg"
SWEP.HoldTypeSprint			= "passive"

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/m16/"
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
	{ s = p0.."fire-dist-int-rifle-01.ogg" },
	{ s = p0.."fire-dist-int-rifle-02.ogg" },
	{ s = p0.."fire-dist-int-rifle-03.ogg" },
	{ s = p0.."fire-dist-int-rifle-04.ogg" },
	{ s = p0.."fire-dist-int-rifle-05.ogg" },
	{ s = p0.."fire-dist-int-rifle-06.ogg" },
}

--
-- Functionality
--
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.ClipSize		= 30
SWEP.Delay					= ( 60 / 800 )

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

SWEP.SightTime				= 0.4
SWEP.SprintTime				= 0.4

--
-- Sexyness
--
local rottle = {
	p0.."cloth_1.ogg",
	p0.."cloth_2.ogg",
	p0.."cloth_3.ogg",
	p0.."cloth_4.ogg",
	p0.."cloth_6.ogg",
	p0.."rattle.ogg",
}
local rattel = {
	p0.."rattle1.ogg",
	p0.."rattle2.ogg",
	p0.."rattle3.ogg",
}

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
		Time = 2.4,
		Events = {
			{ t = 0.1,			s = p0.."magpouch_gear.ogg" },
			{ t = 0.3,			s = p1.."magout_empty.ogg" },
			{ t = 0.95,			s = p1.."magin.ogg" },

			{ t = 0.0,			s = rottle },
			{ t = 0.25,			s = rattel },
			{ t = 0.5,			s = rattel },
			{ t = 1.1,			s = rattel },
			{ t = 1.39,			s = rottle },
			{ t = 1.9,			s = rattel },
		},
		ReloadingTime = 2,
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

			{ t = 0.0,			s = rottle },
			{ t = 0.25,			s = rattel },
			{ t = 0.5,			s = rattel },
			{ t = 1.1,			s = rattel },
			{ t = 1.39,			s = rottle },
			{ t = 1.9,			s = rattel },
		},
		ReloadingTime = 2.5,
		LoadIn = 1.8,
	},
}