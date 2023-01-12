
SWEP.Base					= "weapon_base"
SWEP.Spawnable				= false
SWEP.Suburb					= true

--
-- Description
--
SWEP.PrintName				= "Suburb Base"
SWEP.Category				= "Urban Coalition"
SWEP.Description			= [[Where it all starts!]]
SWEP.Slot					= 2

--
-- Appearance
--
SWEP.ViewModel				= "models/weapons/arccw/c_ud_glock.mdl"
SWEP.WorldModel				= "models/weapons/arccw/c_ud_glock.mdl"
SWEP.VMWMClone				= { Pos = Vector(), Ang = Angle(), Size = Vector() }
SWEP.ViewModelFOV			= 75

SWEP.HoldTypeHip			= "ar2"
SWEP.HoldTypeSight			= "rpg"
SWEP.HoldTypeSprint			= "passive"

SWEP.Sound_Blast			= {}
SWEP.Sound_Mech				= {}
SWEP.Sound_TailEXT			= {}
SWEP.Sound_TailINT			= {}

SWEP.MuzzleEffect						= "muzzleflash_4"
SWEP.QCA_Muzzle							= 1

SWEP.ShellModel							= "models/weapons/arccw/uc_shells/9x19.mdl"
SWEP.ShellScale							= 1
SWEP.QCA_Case							= 2

--
-- Functionality
--
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.ClipSize		= 20
SWEP.Delay					= ( 60 / 800 )

SWEP.Firemodes				= {
	{
		Mode = math.huge,
	}
}

SWEP.Accuracy				= 0

SWEP.Dispersion				= 0
SWEP.Dispersion_Air			= 0
SWEP.Dispersion_Move		= 0
SWEP.Dispersion_Crouch		= 0
SWEP.Dispersion_Sights		= 0

SWEP.SightTime				= 0.3
SWEP.SprintTime				= 0.3

--
-- Recoil
--
SWEP.RecoilUp				= 4				-- degrees punched
SWEP.RecoilSide				= 2				-- degrees punched, in either direction (-100% to 100%)
SWEP.RecoilSwing			= 4				-- degrees on yaw punch
SWEP.RecoilDrift			= 0.7			-- how much will be smooth recoil
SWEP.RecoilDecay			= 20			-- how much recoil to remove per second

--
-- Damage
--
SWEP.DamageNear				= 30
SWEP.RangeNear				= 100
SWEP.DamageFar				= 22
SWEP.RangeFar				= 300
SWEP.Force					= 5

SWEP.ActivePose = {
	Pos = Vector( 0, 0, 0 ),
	Ang = Angle( 0, 0, 0 )
}
SWEP.IronsightPose = {
	Pos = Vector( -2, -2, 2 ),
	Ang = Angle( 0, 0, 0 ),
	ViewModelFOV = 65,
	Magnification = 1.1,
}
SWEP.SwayCorrection = 0.35

-- stuff:
--		StopSightTime
--		ReloadingTime
--		LoadIn
--		SuppressTime
--		CycleDelayTime
--		AttackTime
--		HolsterTime

--
-- Useless shit that you should NEVER touch
--
SWEP.UseHands				= true
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.m_WeaponDeploySpeed	= 10
SWEP.Primary.Automatic		= true -- This should ALWAYS be true.
SWEP.Primary.DefaultClip	= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.ClipMax		= -1

AddCSLuaFile("sh_holdtypes.lua")
include("sh_holdtypes.lua")

AddCSLuaFile("sh_firing.lua")
include("sh_firing.lua")

AddCSLuaFile("sh_think.lua")
include("sh_think.lua")

AddCSLuaFile("sh_binds.lua")
include("sh_binds.lua")

AddCSLuaFile("cl_hud.lua")
if CLIENT then include("cl_hud.lua") end

local yep = {
	["Bool"] = {
		"UserSight",
		"FiremodeDebounce",
		"Customizing",
	},
	["Int"] = {
		"BurstCount",
		"Firemode",
		"ShotgunReloading",
		"CycleCount",
		"TotalShotCount",
	},
	["Float"] = {
		"NextFire",
		"Aim",
		"ReloadingTime",
		"LoadIn",
		"SprintPer",
		"Holster_Time",
		"IdleIn",
		"StopSightTime",
		"DISP_Air",
		"DISP_Move",
		"DISP_Crouch",
	},
	["Entity"] = {
		"Holster_Entity",
	},
	["String"] = {
		"CurrentAnim",
	},
}

SWEP.Animations = {}
SWEP.Attachments = {}
SWEP.Elements = {}

function SWEP:SetupDataTables()
	for i, v in pairs(yep) do
		for k, p in pairs(v) do
			self:NetworkVar(i, k-1, p)
		end
	end
	self.Primary.DefaultClip = self.Primary.ClipSize * 1
	self:SetFiremode(1)
end

function SWEP:Reload()
	if CurTime() < self:GetNextFire() then
		return false
	end
	if CurTime() < self:GetReloadingTime() then
		return false
	end
	if self:GetOwner():KeyDown(IN_USE) then
		if !self:GetFiremodeDebounce() then
			self:GetOwner():ConCommand("impulse 150")
			self:SetFiremodeDebounce( true )
		end
		return false
	end
	if self:Clip1() >= self.Primary.ClipSize then
		return false
	end
	if self:Ammo1() <= 0 then
		return false
	end

	self:SetReloadingTime( CurTime() + 1 )
	self:SetLoadIn( CurTime() + 1 )
	self:SendAnimChoose( "reload", "reload" )
	return true
end

function SWEP:ReloadLoad()
end

function SWEP:Deploy()
	self:SetHolster_Time(0)
	self:SetAim(0)
	self:SetSprintPer(0)
	self:SetHolster_Entity(NULL)

	self:SendAnimChoose( "draw", "draw" )

	return true
end

function SWEP:Holster( ent )
	if ent == self then return end

	if self:GetHolster_Time() != 0 and self:GetHolster_Time() <= CurTime() or IsValid( self:GetHolster_Entity() ) or !IsValid( ent ) then
		self:SetHolster_Time(0)
		self:SetHolster_Entity( NULL )
		return true
	elseif !IsValid(self:GetHolster_Entity()) then
		self:SendAnimChoose( "holster", "holster" )
		self:SetIdleIn( -1 )
		self:SetHolster_Entity( ent )
	end
end

SWEP.BobScale = 0
SWEP.SwayScale = 0
local goddamn_p, goddamn_y = 0, 0
local custtemp = 0

local ox, oy = 0, 0
local LASTAIM

function SWEP:GetViewModelPosition(pos, ang)
	local opos, oang = Vector(), Angle()
	local p = self:GetOwner()
	if IsValid(p) then
	do -- ActivePose, 'idle'
		local b_pos, b_ang = Vector(), Angle()
		local si = 1
		si = si * (1-self:GetAim())
		-- si = si * (1-self:GetSprintPer())
		-- si = math.ease.InOutSine( si )

		b_pos:Add( self.ActivePose.Pos )
		b_ang:Add( self.ActivePose.Ang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- temporary sprint
		local b_pos, b_ang = Vector(), Angle()
		local si = math.ease.InOutQuad( self:GetSprintPer() )

		b_pos:Add( Vector( 1, 0, 0 ) )
		b_ang:Add( Angle( -15, 15, -15 ) )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- temporary customize
		local b_pos, b_ang = Vector(), Angle()
		local si = math.ease.InOutSine( custtemp or 0 )
		custtemp = math.Approach( custtemp, self:GetCustomizing() and 1 or 0, FrameTime() / 0.5 )

		b_pos:Add( Vector( 3, 0, -1 ) )
		b_ang:Add( Angle( 15, 15, 15 ) )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- sway
		local b_pos, b_ang = Vector(), Angle()
		local EY = p:EyeAngles()
		if !LASTAIM then LASTAIM = EY end
		ox = math.ApproachAngle(ox, ox + (EY.y - LASTAIM.y), math.huge)
		oy = math.ApproachAngle(oy, oy - (EY.p - LASTAIM.p), math.huge)
		ox = math.Approach(ox, ox*(1-(math.min(FrameTime(), (1/8))*8)), math.huge)
		oy = math.Approach(oy, oy*(1-(math.min(FrameTime(), (1/8))*8)), math.huge)
		LASTAIM:Set(p:EyeAngles())

		local sii = self:GetAim()
		local mult = 0.15
		local mult_aim = 0.1
		local correct = Lerp( sii, 0.12, self.SwayCorrection )
		local test = GetConVar("uc_dev_aimcorrect"):GetInt()
		if test == 1 then
			ox = (math.sin(CurTime()*3))*90
		elseif test == 2 then
			oy = (math.sin(CurTime()*3))*90
		end

		b_pos.x = b_pos.x + ox*correct
		b_ang.y = b_ang.y + ox*1

		b_pos.z = b_pos.z + oy*-correct
		b_ang.x = b_ang.x + oy*1

		--b_pos.z = b_pos.z - math.abs(ox*0.04)

		mult = mult * Lerp( sii, 1, mult_aim )
		b_pos:Mul( mult )
		b_ang:Mul( mult )
		b_ang:Normalize()

		opos:Add(b_pos)
		oang:Add(b_ang)
	end
	do -- ironsighting
		local b_pos, b_ang = Vector(), Angle()
		local si = self:GetAim()
		local ss_si = math.ease.InOutSine( si )

		b_pos:Add( self.IronsightPose.Pos )
		b_ang:Add( self.IronsightPose.Ang )
		b_pos:Mul( ss_si )
		b_ang:Mul( ss_si )
		opos:Add( b_pos )
		oang:Add( b_ang )
		
		local b_pos, b_ang = Vector(), Angle()
		local xi = si

		xi = math.sin( math.rad( 90 * si * 2 ) )
		local ss_xi = math.ease.InCirc( xi )

		b_pos:Add( self.IronsightPose.MidPos or vector_origin )
		b_ang:Add( self.IronsightPose.MidAng or angle_zero )
		b_pos:Mul( ss_xi )
		b_ang:Mul( ss_xi )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	end
	
	ang:RotateAroundAxis( ang:Right(),		oang.x )
	ang:RotateAroundAxis( ang:Up(),			oang.y )
	ang:RotateAroundAxis( ang:Forward(),	oang.z )

	pos:Add( opos.x * ang:Right() )
	pos:Add( opos.y * ang:Forward() )
	pos:Add( opos.z * ang:Up() )

	return pos, ang
end

-- Animating
function SWEP:SendAnimChoose( act, hold, send )
	assert( self.Animations, "SendAnimChoose: No animations table?!" )

	local retong = act

	if !self.Animations[act] then
		return false
	end

	if self:GetAim() > 0.5 and self.Animations[act .. "_sight"] then
		retong = retong .. "_sight"
	end

	if self:Clip1() == 0 and self.Animations[act .. "_empty"] then
		retong = retong .. "_empty"
	end

	return ( send and retong ) or self:SendAnim( retong, hold )
end
local fallback = {
	Mult = 1,
}
function SWEP:SendAnim( act, hold )
	local anim = fallback
	local anim = self.Animations
	assert( anim, "SendAnim: No animations table?!" )
	if !anim then
		-- print("No animation table!")
		return 0
	elseif !anim[act] then
		-- print("No defined animation!")
		return 0
	else
		anim = self.Animations[act]
	end
	local mult = anim.Mult or 1
	local seqc = self:LookupSequence( Suburb.quickie( anim.Source ) )
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( seqc )
	mult = vm:SequenceDuration() / (anim.Time or vm:SequenceDuration())
	vm:SetPlaybackRate( mult )
	local seqdur = (vm:SequenceDuration() / mult)
	if hold == "idle" then
		hold = false
	else
		self:SetIdleIn( CurTime() + seqdur )
	end

	local stopsight = hold and hold != "reload"
	local reloadtime = hold
	local loadin = hold == "reload"
	local suppresstime = false
	local cycledelaytime = hold == "cycle" or hold == "fire"
	local attacktime = false
	local holstertime = hold == "holster"

	if anim.StopSightTime then
		stopsight = true
	end
	if anim.ReloadingTime then
		reloadtime = true
	end
	if anim.LoadIn then
		loadin = true
	end
	if anim.SuppressTime then
		suppresstime = true
	end
	if anim.CycleDelayTime then
		cycledelaytime = true
	end
	if anim.AttackTime then
		attacktime = true
	end
	if anim.HolsterTime then
		holstertime = true
	end

	if reloadtime then
		self:SetReloadingTime( CurTime() + (anim.ReloadingTime or seqdur) )
	end
	if stopsight then
		self:SetStopSightTime( CurTime() + (anim.StopSightTime or seqdur) )
	end
	if loadin then
		self:SetLoadIn( CurTime() + (anim.LoadIn or seqdur) )
	end
	if suppresstime then
		self:SetSuppressIn( CurTime() + (anim.SuppressTime or seqdur) )
	end
	if cycledelaytime then
		self:SetCycleDelayTime( CurTime() + (anim.CycleDelayTime or seqdur) )
	end
	if attacktime then
		self:SetNextMechFire( CurTime() + (anim.AttackTime or seqdur) )
	end
	if holstertime then
		self:SetHolster_Time( CurTime() + (anim.HolsterTime or seqdur) )
	end

	if anim.Events then
		for i, v in pairs(anim.Events) do
			v.PLAYED = false
			v.STARTTIME = CurTime() + v.t
		end
	end
	self:SetCurrentAnim(act)

	return seqdur
end

function SWEP:PreDrawViewModel( vm, weapon, ply )
	cam.Start3D(EyePos(), EyeAngles(), Suburb.FOVix( Lerp( self:GetAim() * (1-(self.superaimedin or 0)*0.5), self.ViewModelFOV, self.IronsightPose.ViewModelFOV ) ), nil, nil, nil, nil)
	cam.IgnoreZ(true)
end

function SWEP:PostDrawViewModel( vm, weapon, ply )
	cam.End3D()
end

function SWEP:TranslateFOV(fov)
	local mag = 1.1
	if self.IronsightPose and self.IronsightPose.Magnification then
		mag = self.IronsightPose.Magnification
	end
	return Lerp( self:GetAim(), fov, fov or 75 ) / Lerp( math.ease.InOutQuad( self:GetAim() * (1-(self.superaimedin or 0)*0.5) ), 1, mag )
end

function SWEP:AdjustMouseSensitivity()
	local mag = 1.1
	if self.IronsightPose and self.IronsightPose.Magnification then
		mag = self.IronsightPose.Magnification
	end
	return 1 / Lerp( math.ease.InOutQuad( self:GetAim() * (1-(self.superaimedin or 0)*0.5) ), 1, mag )
end