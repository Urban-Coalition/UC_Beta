
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
SWEP.CrouchPose = {
	Pos = Vector(-2.5, -2, -0.6),
	Ang = Angle(0, 0, -14),
	MidPos = Vector( 0, 0, 0 ),
	MidAng = Angle( 0, 0, 0 ),
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
		"ShotgunReloading",
		"NeedCycle",
	},
	["Int"] = {
		"BurstCount",
		"NWFiremode",
		"CycleCount",
		"TotalShotCount",
		"LoadAmount",
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
		"ShotgunReloadingTime",
		"CycleDelayTime",
	},
	["Entity"] = {
		"Holster_Entity",
	},
	["String"] = {
		"CurrentAnim",
	},
}

SWEP.CL_Firemode = 1
function SWEP:SetFiremode(x)
	if (!game.SinglePlayer() and CLIENT) then self.CL_Firemode = x end
	self:SetNWFiremode(x)
end

function SWEP:GetFiremode()
	if (!game.SinglePlayer() and CLIENT) then return self.CL_Firemode end
	return self:GetNWFiremode()
end


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
	self:SetLoadAmount(math.huge)
end

function SWEP:Reload()
	if CurTime() < self:GetNextFire() then
		return false
	end
	if CurTime() < self:GetReloadingTime() then
		return false
	end
	if CurTime() < self:GetShotgunReloadingTime() then
		return false
	end
	if self:GetShotgunReloading() then
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
	local shotgun = self.ShotgunReloading
	if shotgun then
		self:SendAnimChoose( "sgreload_start", "reload" )
		self:SetShotgunReloading( true )
	else
		self:SendAnimChoose( "reload", "reload" )
	end
	return true
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

subdeath = subdeath or {}
local MovePosCorrect = Vector( -12.906250, 2.736328, 3.873047 )
local MoveAngCorrect = Angle( 0, -90, -90 )

local ler_walk = 0
local ler_sprint = 0

local tempsprintpos, tempsprintang = Vector( 1, 0, 0.5 ), Angle( -15, 10, -10 )
local tempcustpos, tempcustang = Vector( 3, 0, -1 ), Angle( 15, 15, 15 )

function SWEP:GetViewModelPosition(pos, ang)
	local opos, oang = Vector(), Angle()
	local p = self:GetOwner()
	if IsValid(p) then
	do -- ActivePose, 'idle'
		local b_pos, b_ang = Vector(), Angle()
		local si = 1
		si = si * (1-math.ease.InOutSine( self:GetAim() ))
		-- si = si * (1-self:GetSprintPer())
		-- si = math.ease.InOutSine( si )

		b_pos:Add( self.ActivePose.Pos )
		b_ang:Add( self.ActivePose.Ang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- crouching
		local viewOffsetZ = p:GetViewOffset().z
		local crouchdelta = math.Clamp( math.ease.InOutSine((viewOffsetZ - p:GetCurrentViewOffset().z) / (viewOffsetZ - p:GetViewOffsetDucked().z) ), 0, 1)

		local b_pos, b_ang = Vector(), Angle()
		local si = crouchdelta
		si = si * (1-math.ease.InOutSine( self:GetAim() ))
		local ss_si = math.ease.InOutSine( si )

		b_pos:Add( self.CrouchPose.Pos )
		b_ang:Add( self.CrouchPose.Ang )
		b_pos:Mul( ss_si )
		b_ang:Mul( ss_si )
		opos:Add( b_pos )
		oang:Add( b_ang )
		
		local b_pos, b_ang = Vector(), Angle()
		local xi = ss_si
		xi = math.sin( math.rad( 90 * xi * 2 ) )

		b_pos:Add( self.CrouchPose.MidPos or vector_origin )
		b_ang:Add( self.CrouchPose.MidAng or angle_zero )
		b_pos:Mul( xi )
		b_ang:Mul( xi )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- temporary customize
		local b_pos, b_ang = Vector(), Angle()
		local si = math.ease.InOutSine( custtemp or 0 )
		if game.SinglePlayer() or (!game.SinglePlayer() and CLIENT and IsFirstTimePredicted()) then
			custtemp = math.Approach( custtemp, self:GetCustomizing() and 1 or 0, FrameTime() / 0.5 )
		end

		b_pos:Add( tempcustpos )
		b_ang:Add( tempcustang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- temporary sprint
		local b_pos, b_ang = Vector(), Angle()
		local si = math.ease.InOutSine( self:GetSprintPer() )

		b_pos:Add( tempsprintpos )
		b_ang:Add( tempsprintang )
		b_pos:Mul( si )
		b_ang:Mul( si )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- sway
		local b_pos, b_ang = Vector(), Angle()
		local EY = p:EyeAngles()
		if !LASTAIM then LASTAIM = EY end
		if game.SinglePlayer() or IsFirstTimePredicted() then
			ox = math.ApproachAngle(ox, ox + (EY.y - LASTAIM.y), math.huge)
			oy = math.ApproachAngle(oy, oy - (EY.p - LASTAIM.p), math.huge)
			ox = math.Approach(ox, ox*(1-(math.min(FrameTime(), (1/8))*8)), math.huge)
			oy = math.Approach(oy, oy*(1-(math.min(FrameTime(), (1/8))*8)), math.huge)
			LASTAIM:Set(p:EyeAngles())
		end

		local sii = self:GetAim()
		local mult = 0.08
		local mult_aim = 0.2
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

		if test == 0 then
			b_ang.z = b_ang.z - ox * Lerp( sii, 1, 5 )

			-- Wobble while swaying
			local joink = (math.abs( ox + oy ) ^ 2) * 0.01
			b_pos.x = b_pos.x + ( math.sin( CurTime() * 1.0 * 16 ) * joink * 0.1 )
			b_pos.y = b_pos.y + ( math.sin( CurTime() * 0.6 * 16 ) * joink * 0.1 )
			b_pos.z = b_pos.z + ( math.sin( CurTime() * 0.3 * 16 ) * joink * 0.1 )

			b_ang.x = b_ang.x + ( math.sin( CurTime() * 1.0 * 16 ) * joink * 0.2 )
			b_ang.y = b_ang.y + ( math.sin( CurTime() * 0.6 * 16 ) * joink * 0.2 )
			b_ang.z = b_ang.z + ( math.sin( CurTime() * 0.3 * 16 ) * joink * 0.2 )
		end

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
		local xi = ss_si
		xi = math.sin( math.rad( 90 * xi * 2 ) )

		b_pos:Add( self.IronsightPose.MidPos or vector_origin )
		b_ang:Add( self.IronsightPose.MidAng or angle_zero )
		b_pos:Mul( xi )
		b_ang:Mul( xi )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	if false then -- THINGING
		local b_pos, b_ang = Vector(), Angle()

		if true then--self.QCA_Camera then
			for i=1, 4 do
				if !(subdeath[i] and IsValid(subdeath[i])) then
					subdeath[i] = ClientsideModel( "models/weapons/c_pistol.mdl" )
					local mod = subdeath[i]
					mod:SetModel( "models/suburb/suburb_1.mdl" )
					mod:SetNoDraw(true)
					local seq = "rifle_idle"
					if i == 1 then
						seq = "rifle_idle"
					elseif i == 2 then
						seq = "rifle_idle_active"
					elseif i == 3 then
						seq = "rifle_walk"
					elseif i == 4 then
						seq = "rifle_run"
					end
					seq = mod:LookupSequence( seq )
					mod:ResetSequence( seq )
				end
				local mod = subdeath[i]
				mod:SetCycle( (CurTime()/5) % 1 )
				local result = mod:GetAttachment( 1 )
				local oddy, addy = Vector(), Angle()
				oddy:Set( result.Pos )
				addy:Set( result.Ang )
				oddy:Add( MovePosCorrect )
				addy:Add( MoveAngCorrect )

				local speed = p:GetAbsVelocity():Length2D()

				if i == 1 then -- Sighted idle
					oddy:Mul( 0 ) -- No need!
					addy:Mul( 0 )
				elseif i == 2 then -- Active idle
					oddy:Mul( 1 - self:GetAim() )
					addy:Mul( 1 - self:GetAim() )
				elseif i == 4 then -- Run
					local ler = math.TimeFraction( p:GetWalkSpeed(), p:GetRunSpeed(), speed )
					ler = math.Clamp( ler, 0, 1 )
					ler_sprint = math.Approach( ler_sprint, p:IsSprinting() and ler or 0, FrameTime() / 0.4 )
					local res = math.ease.InOutSine( ler_sprint )
					oddy:Mul( res )
					addy:Mul( res )
				elseif i == 3 then -- Walk
					local ler = math.TimeFraction( 50, 100, speed )
					ler = math.Clamp( ler, 0, 1 )
					ler_walk = math.Approach( ler_walk, p:IsSprinting() and 0 or ler, FrameTime() / 0.4 )
					local res = math.ease.InOutSine( ler_walk )
					oddy:Mul( res )
					addy:Mul( res )
				end

				--b_pos:Add( oddy )
				--b_ang:Add( addy )
			end

		end

		-- Anchor rotation test
		if true then
			if self.UniversalAnimationInfo then
				local bi = self.UniversalAnimationInfo
				if !(uni and IsValid(uni)) then
					uni = ClientsideModel( "models/weapons/c_pistol.mdl" )
					uni:SetNoDraw( false )
				end
				local vm = p:GetViewModel()
				uni:SetModel( vm:GetModel() )
				uni:SetSequence( uni:LookupSequence( "idle" ) )
				uni:SetCycle( 0 )--vm:GetCycle() )
				
				for i=0, vm:GetNumPoseParameters()-1 do
					local ppn = vm:GetPoseParameterName( i )
					local ppa = vm:GetPoseParameter( ppn )
					uni:SetPoseParameter( ppn, ppa )
					uni:InvalidateBoneCache()
				end
				
				local magic = Vector( 11.468750, -2.806641, -4.148438 )
				uni:SetupBones()
				local result = uni:GetBoneMatrix( uni:LookupBone( bi.bone ) )
				if !result then return end
				if bi.pos then result:Translate( bi.pos ) end
				if bi.ang then result:Rotate( bi.ang ) end
				local rp, ra = result:GetTranslation(), result:GetAngles()

				local rotato = Angle( 0, math.sin(CurTime())*90, 0 )

				local bp, ba = ArcCW.RotateAroundPoint2( Vector(), Angle(), Vector(), Vector(), rotato )

				b_pos:Add( bp )
				b_ang:Add( ba )
			end
		end

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

	local stopsight = hold and hold != "reload" and hold != "sginsert" and hold != "sgfinish" and hold != "cycle"
	local reloadtime = hold and hold != "cycle"
	local loadin = hold == "reload" or hold == "sginsert"
	local shotgunreloadingtime = hold == "reload" or hold == "sginsert"
	local cycledelaytime = hold == "cycle" or hold == "fire"
	local attacktime = false
	local holstertime = hold == "holster"
	local shelleject = false

	if anim.StopSightTime then
		stopsight = true
	end
	if anim.ReloadingTime then
		reloadtime = true
	end
	if anim.LoadIn then
		loadin = true
	end
	if anim.ShotgunReloadingTime then
		shotgunreloadingtime = true
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
	if anim.AmountToLoad then
		loadamount = true
	end
	if anim.ShellEjectTime then
		shelleject = true
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
	if shotgunreloadingtime then
		self:SetShotgunReloadingTime( CurTime() + (anim.ShotgunReloadingTime or seqdur) )
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
	if shelleject and CLIENT and IsFirstTimePredicted() then
		self.ShellEjectTime = ( CurTime() + anim.ShellEjectTime )
	end
	self:SetLoadAmount( anim.AmountToLoad or 300 )

	if anim.Events then
		for i, v in pairs(anim.Events) do
			v.PLAYED = false
			v.STARTTIME = CurTime() + v.t
		end
	end
	self:SetCurrentAnim(act)

	return seqdur
end

function SWEP:Think_Shell()
	if !self.ShellEjectTime then return end
	if (CLIENT and IsFirstTimePredicted()) and self.ShellEjectTime != -1 and self.ShellEjectTime <= CurTime() then
		self:Attack_Effects_Shell()
		self.ShellEjectTime = -1
	end
end

local emptab = {}
function SWEP:PreDrawViewModel( vm, weapon, ply )
	if IsValid(vm) then
		local bgtab = emptab
		if self.DefaultBodygroups then
			bgtab = string.Explode( " ", self.DefaultBodygroups )
		end
		for i=1, 32 do
			local tt = bgtab[i] or 0
			vm:SetBodygroup( i-1, tt )
		end
		vm:SetSkin( self.DefaultSkin or 0 )
	end
	local device = (1-math.ease.InOutQuad(self.superaimedin or 0)*0.5)
	cam.Start3D(EyePos(), EyeAngles(), Suburb.FOVix( Lerp( math.ease.InQuad( self:GetAim() * device ), self.ViewModelFOV, self.IronsightPose.ViewModelFOV ) ), nil, nil, nil, nil, 1, 1000 )
	cam.IgnoreZ(true)
end

function SWEP:PostDrawViewModel( vm, weapon, ply )
	cam.End3D()
end

function SWEP:GetAimAlt()
	return math.Clamp( math.TimeFraction( 0.5, 1, self:GetAim() ), 0, 1 )
end

function SWEP:TranslateFOV(fov)
	local device = (1-math.ease.InOutQuad(self.superaimedin or 0)*0.5)
	local mag = 1.1
	if self.IronsightPose and self.IronsightPose.Magnification then
		mag = self.IronsightPose.Magnification
	end
	return Lerp( self:GetAim(), fov, fov or 90 ) / Lerp( math.ease.InQuad( self:GetAimAlt() * device ), 1, mag )
end

function SWEP:AdjustMouseSensitivity()
	local device = (1-math.ease.InOutQuad(self.superaimedin or 0)*0.5)
	local mag = 1.1
	if self.IronsightPose and self.IronsightPose.Magnification then
		mag = self.IronsightPose.Magnification
	end
	return 1 / Lerp( math.ease.InQuad( self:GetAim() * device ), 1, mag )
end

function SWEP:CalcView( ply, pos, ang, fov )
	if self.QCA_Camera then
		if !(Suburb_CL1 and IsValid(Suburb_CL1)) then
			Suburb_CL1 = ClientsideModel( "models/weapons/c_pistol.mdl" )
			Suburb_CL1:SetNoDraw( true )
		end
		local vm = ply:GetViewModel()
		Suburb_CL1:SetModel( vm:GetModel() )
		Suburb_CL1:SetSequence( vm:GetSequence() )
		Suburb_CL1:SetCycle( vm:GetCycle() )
		Suburb_CL1:SetupBones()
		local result = Suburb_CL1:GetAttachment( self.QCA_Camera )
		if !result then return end
		local addy = Angle()
		addy:Set( result.Ang )
		addy:Add( self.CameraCorrection or angle_zero )
		ang:Add( addy )
	end
	return pos, ang, fov
end