
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
SWEP.ChamberSize			= 1
SWEP.Delay					= ( 60 / 800 )

SWEP.ShotgunReloading		= false
SWEP.ManualAction			= 0
SWEP.ReloadRemovesNeedCycle	= false -- Whether starting a shotgun reload will remove the need to cycle the gun.

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
SWEP.RecoilPunch			= 0.2			-- how much recoil is also used as punch
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

SWEP.Animations = {}
SWEP.Attachments = {}
SWEP.Elements = {}

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

SWEP.ActivatedElements = {}
SWEP.SightList = {}
SWEP.BGTable = {}

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
		--"Readied",
	},
	["Int"] = {
		"BurstCount",
		"NWFiremode",
		"CycleCount",
		"TotalShotCount",
		"LoadAmount",
		"ActiveSight",
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
	--if (!game.SinglePlayer() and CLIENT) then self.CL_Firemode = x end
	self:SetNWFiremode(x)
end

function SWEP:GetFiremode()
	--if (!game.SinglePlayer() and CLIENT) then return self.CL_Firemode end
	return self:GetNWFiremode()
end

function SWEP:SetReadied(x)
	self.Readied = x
end

function SWEP:GetReadied()
	return self.Readied or false
end

function SWEP:SetupDataTables()
	for i, v in pairs(yep) do
		for k, p in pairs(v) do
			self:NetworkVar(i, k-1, p)
		end
	end
	self.Primary.DefaultClip = self.Primary.ClipSize * 1
	self:SetFiremode(1)
	self:SetActiveSight(1)
	self:SetLoadAmount(math.huge)
end

function SWEP:Initialize()
	self._WeaponList = weapons.GetStored( self:GetClass() )
	for index, attslot in ipairs(self.Attachments) do
		if index == "BaseClass" then continue end
		if attslot.DefaultAtt then
			attslot._Installed = attslot.DefaultAtt
		end
	end
	self:RegenStats()
end

function SWEP:OnReloaded()
	self:RegenStats()
end

-- Some gamers may want an option to unload their mag on command...
-- Consider an action that plays a unique animation with it too.
function SWEP:Unload( camount )
	local tounload = self:Clip1()
	tounload = math.max( tounload - self:GetStat("ChamberSize"), 0 )
	if camount then
		tounload = math.max( camount, 0 )
	end
	if tounload <= 0 then return false end -- Don't waste time
	if SERVER then
		if IsValid(self:GetOwner()) then
			self:GetOwner():GiveAmmo( tounload, self:GetPrimaryAmmoType(), false )
		else
			print( "Suburb: Just tried to Unload " .. (camount or tounload) .. " rounds, but the owner doesn't exist.", self )
		end
	end
	self:SetClip1( self:Clip1() - tounload )
end

function SWEP:Reload( automatic )
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
	if runawayburst and self:GetBurstCount() > 0 then
		return false
	end
	if self:Clip1() >= (self:GetCapacity()+self:GetStat("ChamberSize")) then
		return false
	end
	if self:Ammo1() <= 0 then
		return false
	end
	if self:GetOwner():KeyDown( IN_ATTACK ) and !automatic then
		return false
	end

	self:SetReloadingTime( CurTime() + 1 )
	self:SetLoadIn( CurTime() + 1 )
	self:SetBurstCount( 0 )
	local shotgun = self.ShotgunReloading
	local multi = self:GetStat( "ReloadTime", 1 )
	if shotgun then
		if self.Animations["sgreload_start_empty"] and self:Clip1() == 0 then
			self:SendAnimChoose( "sgreload_start_empty", "sgreload", multi )
		else
			self:SendAnimChoose( "sgreload_start", "sgreload", multi )
		end
		self:SetShotgunReloading( true )
		if self.ReloadRemovesNeedCycle then self:SetCycleCount( 0 ) end
	else
		self:SendAnimChoose( "reload", "reload", multi )
	end
	return true
end

-- This is to fix an issue in Multiplayer when spawning a weapon from the spawnmenu.
if SERVER then
	util.AddNetworkString("suburb_firstdeployfix")
else
	net.Receive("suburb_firstdeployfix", function()
		timer.Simple( 0.05, function()
			local p = LocalPlayer()
			local w = p:GetActiveWeapon()
			if IsValid( w ) and w.Suburb then
				if !w.ClientDeployedCorrectly then
					SDeP(w, "Did the first deploy fix.")
					w:Deploy()
				else
					SDeP(w, "First deploy fix was not required.")
				end
			end
		end)
	end)
end

function SWEP:Deploy()
	self:SetHolster_Time(0)
	self:SetAim(0)
	self:SetSprintPer(0)
	self:SetHolster_Entity(NULL)
	self:GetOwner():SetSaveValue("m_flNextAttack", 0)

	-- This is to fix an issue in Multiplayer when spawning a weapon from the spawnmenu.
	if CLIENT then self.ClientDeployedCorrectly = true end
	if (!game.SinglePlayer() and SERVER) then net.Start("suburb_firstdeployfix") net.Send( self:GetOwner() ) end

	if !self:GetReadied() and self.Animations["ready"] then
		self:SendAnimChoose( "ready", "draw" )
	else
		self:SendAnimChoose( "draw", "draw" )
	end
	self:SetReadied(true)

	self:GetOwner():SetCanZoom( false )

	return true
end

function SWEP:OwnerChanged()
	self:SetReadied(false)
end

function SWEP:Holster( ent )
	self:SetShotgunReloading( false )
	self:SetLoadIn( 0 )
	if ent == self then return end

	if self:GetHolster_Time() != 0 and self:GetHolster_Time() <= CurTime() or IsValid( self:GetHolster_Entity() ) or !IsValid( ent ) then
		self:GetOwner():SetCanZoom( true )
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

local lastpos, lastang = Vector(), Angle()
local ccvar_benchgun
local ccvar_aimcorrect

function SWEP:GetViewModelPosition(pos, ang)
	ccvar_benchgun = ccvar_benchgun or GetConVar("uc_dev_benchgun")
	if ccvar_benchgun:GetBool() then
		return lastpos, lastang
	end
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
		ccvar_aimcorrect = ccvar_aimcorrect or GetConVar("uc_dev_aimcorrect")
		local test = ccvar_aimcorrect:GetInt()
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

		local ipose = self:GetStat("IronsightPose")
		local wpos, wang = Vector(), Angle()
		local wpos_m, wang_m = ipose.MidPos, ipose.MidAng

		if self.SightList and self.SightList[self.SightTransition_From] and self.SightList[self.SightTransition_To] then
			local si_prev = self.SightList[self.SightTransition_From].SightData
			local si_next = self.SightList[self.SightTransition_To].SightData

			local si_tra = math.TimeFraction( (self.SightTransition or 0), (self.SightTransition or 0) + 0.2, CurTime() )
			si_tra = math.Clamp( si_tra, 0, 1 )

			wpos:Set( LerpVector( si_tra, si_prev.Pos, si_next.Pos ) )
			wang:Set( LerpAngle( si_tra, si_prev.Ang, si_next.Ang ) )

			-- TODO: Clean this the hell up!! This should be different!!
			local blah = math.sin( si_tra * math.pi )
			blah = math.Round( blah, 10 )
			wpos.y = wpos.y + ( 2 * blah )
		else
			wpos, wang = ipose.Pos, ipose.Ang
		end

		b_pos:Add( wpos )
		b_ang:Add( wang )
		b_pos:Mul( ss_si )
		b_ang:Mul( ss_si )
		opos:Add( b_pos )
		oang:Add( b_ang )
		
		local b_pos, b_ang = Vector(), Angle()
		local xi = ss_si
		xi = math.sin( math.rad( 90 * xi * 2 ) )

		b_pos:Add( wpos_m or vector_origin )
		b_ang:Add( wang_m or angle_zero )
		b_pos:Mul( xi )
		b_ang:Mul( xi )

		opos:Add( b_pos )
		oang:Add( b_ang )
	end
	do -- recoil fix
		local b_ang = Angle()
		b_ang:Set( self:GetOwner():GetViewPunchAngles() )

		b_ang.y = -b_ang.y
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

	lastpos:Set(pos)
	lastang:Set(ang)
	return pos, ang
end

-- Animating
function SWEP:SendAnimChoose( act, hold, mul, spy )
	assert( self.Animations, "SendAnimChoose: No animations table?!" )

	local test = { anim = act, mult = mul or 1 }
	self:AttHook( "TranslateAnimation", test )
	local final = test.anim
	local fmult = test.mult

	if !self.Animations[act] then
		print( "Suburb SendAnimChoose: Check 1: " .. act .. " is not in the Animations table. Stopping.." )
		return false
	end

	if self:GetAim() > 0.5 and self.Animations[final .. "_sight"] then
		final = final .. "_sight"
	end

	if self:Clip1() == 0 and self.Animations[final .. "_empty"] then
		final = final .. "_empty"
	end

	if !self.Animations[final] then
		print( "Suburb SendAnimChoose: Check 2: " .. final .. " is not in the Animations table. Stopping.." )
		return false
	end

	return ( spy and final ) or self:SendAnim( final, hold, fmult )
end
local fallback = {
	Mult = 1,
}
function SWEP:SendAnim( act, hold, imult )
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
	local seqc = self:LookupSequence( Suburb.quickie( anim.Source ) )
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence( seqc )
	local mult = vm:SequenceDuration() / (anim.Time or vm:SequenceDuration())
	mult = mult / (anim.Mult or 1)
	mult = mult / (imult or 1)
	vm:SetPlaybackRate( mult )
	local seqdur_p = vm:SequenceDuration()
	local seqdur = (seqdur_p / mult)
	if hold == "idle" then
		hold = false
	else
		self:SetIdleIn( CurTime() + seqdur )
	end

	local stopsight = hold and hold != "reload" and hold != "sgreload" and hold != "sginsert" and hold != "sgfinish" and hold != "cycle"
	local reloadtime = hold and hold != "cycle"
	local loadin = hold == "sgreload" or hold == "reload" or hold == "sginsert"
	local shotgunreloadingtime = hold == "sgreload" or hold == "sginsert"
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
		self:SetReloadingTime( CurTime() + (anim.ReloadingTime or seqdur_p)*imult )
	end
	if stopsight then
		self:SetStopSightTime( CurTime() + (anim.StopSightTime or seqdur_p)*imult )
	end
	if loadin then
		self:SetLoadIn( CurTime() + (anim.LoadIn or seqdur_p)*imult )
	end
	if shotgunreloadingtime then
		self:SetShotgunReloadingTime( CurTime() + (anim.ShotgunReloadingTime or seqdur_p)*imult )
	end
	if cycledelaytime then
		self:SetCycleDelayTime( CurTime() + (anim.CycleDelayTime or seqdur_p)*imult )
	end
	if attacktime then
		self:SetNextMechFire( CurTime() + (anim.AttackTime or seqdur_p)*imult )
	end
	if holstertime then
		self:SetHolster_Time( CurTime() + (anim.HolsterTime or seqdur_p)*imult )
	end
	if shelleject and CLIENT and IsFirstTimePredicted() then
		self.ShellEjectTime = ( CurTime() + (anim.ShellEjectTime*imult) )
	end
	self:SetLoadAmount( anim.AmountToLoad or 300 )

	if anim.Events then
		for i, v in pairs(anim.Events) do
			v.PLAYED = false
			v.STARTTIME = CurTime() + (v.t*imult)
		end
	end
	self:SetCurrentAnim(act)

	if CLIENT then
		self.CurrAnim = act
		self.CurrAnimStart = CurTime()
		self.CurrAnimEnd = CurTime() + seqdur
	end

	return seqdur
end

function SWEP:Think_Shell()
	if !self.ShellEjectTime then return end
	if (CLIENT and IsFirstTimePredicted()) and self.ShellEjectTime != -1 and self.ShellEjectTime <= CurTime() then
		self:Attack_Effects_Shell()
		self.ShellEjectTime = -1
	end
end

local rtmat, rtsurf, rttemp, scofov
local ccvar_cheapscope
if CLIENT then
	scofov = 1
	scomag = 1
	rtmat = GetRenderTarget("suburb_scope", 512, 512, false)
	rtsurf = Material( "suburb/rt" )
	rttemp = {
		origin = vector_origin,
		angles = angle_zero,
		x = 0,
		y = 0,
		w = 512,
		h = 512,
		drawviewmodel = false,
		fov = 90,
		--znear = 1,
		--zfar = 1000,
	}
	
	hook.Add("PreRender", "Suburb_PreRender", function()
		local p = LocalPlayer()
		local wpn = p:GetActiveWeapon()
		local diff = ((4/3)/(ScrW()/ScrH()))
		ccvar_cheapscope = ccvar_cheapscope or GetConVar("uc_cl_cheapscopes")
		if IsValid(wpn) and wpn.Suburb and !ccvar_cheapscope:GetBool() and wpn:GetAim() != 0 and wpn:GetCurrentSight().OpticRT then -- and w:GetUserSight() then
			-- print("Suburb: Dual-render scope is being done.")
			render.ClearRenderTarget( rtmat, color_white )
			render.PushRenderTarget(rtmat)
			cam.Start2D()
				render.Clear( 0, 0, 0, 255 )
				rttemp.origin = p:EyePos()
				rttemp.angles = p:EyeAngles()
				rttemp.fov = Suburb.FOVix( p:GetFOV() * ((scofov/scomag)/diff), 1, 1 )
				render.RenderView( rttemp )
			cam.End2D()
			render.PopRenderTarget()
		end
	end)

	hook.Add("PreDrawViewModels", "Suburb_PreDrawViewModels", function()
		local p = LocalPlayer()
		local wpn = p:GetActiveWeapon()
		ccvar_cheapscope = ccvar_cheapscope or GetConVar("uc_cl_cheapscopes")
		if IsValid(wpn) and wpn.Suburb and ccvar_cheapscope:GetBool() and wpn:GetAim() != 0 and wpn:GetCurrentSight().OpticRT then
			-- print("Suburb: Cheap scope is being done.")
			local w, h = ScrW(), ScrH()
			local rat = w/h

			local weh = Suburb.FOVix( 1, 1, 1 )
			
			render.UpdateScreenEffectTexture()
			render.UpdateFullScreenDepthTexture()
			local screen = render.GetScreenEffectTexture()

			render.ClearRenderTarget( rtmat, color_white )
			render.PushRenderTarget(rtmat)
				render.Clear( 0, 0, 0, 255 )
				local wtf = -((w*rat)-w)*0.5
				local ma = 1/scofov*weh
				local aw = (w-(w*ma))*0.5
				local ah = (h-(h*ma))*0.5
				render.DrawTextureToScreenRect(screen, wtf+(aw*rat), ah, w*rat*ma, h*ma)
			render.PopRenderTarget()
		end
	end)

end

function SWEP:PreDrawViewModel( vm, weapon, ply )
	self:UseBGTable( vm )

	local device = self:GetReloadingAimAlt()
	
	local ipose = self:GetCurrentSight()
	local silly -- = Lerp( math.abs( math.sin( CurTime() * math.pi * 0.5 ) ), 10, 90 )
	cam.Start3D(EyePos(), EyeAngles(), Suburb.FOVix( GetConVar("uc_dev_benchgun"):GetBool() and LocalPlayer():GetFOV() or Lerp( math.ease.InSine( self:GetAimAlt() * device ), self.ViewModelFOV, silly or ipose.ViewModelFOV ) ), nil, nil, nil, nil, 1, 1000 )
	cam.IgnoreZ(true)

	for index, data in pairs( self.Attachments ) do
		if data._Model and data.Bone then
			local AT = Suburb.AttTable[data._Installed]
			assert(AT, "Suburb Think: That attachment doesn't exist!!", index, data._Installed)

			if IsValid(vm) then
				local bm = vm:GetBoneMatrix( vm:LookupBone( data.Bone ) )
				if bm then
					local pos, ang = bm:GetTranslation(), bm:GetAngles()
					local md = data._Model

					local attpos = data.Pos
					if data.Pos0 and data.Pos1 then attpos = LerpVector( data._SlideAmount or 0.5, data.Pos0, data.Pos1 ) end
					for elem, elemdata in pairs( self.Elements ) do
						if elem == "BaseClass" then continue end
						if self.ActivatedElements[elem] then
							if elemdata.AttPos and elemdata.AttPos[index] then
								attpos = elemdata.AttPos[index].Pos
							end
						end
					end

					local bpos, bang, bscale = Vector(), Angle(), Vector( 1, 1, 1 )
					bpos:Add( attpos )
					if AT.ModelOffset then bpos:Add( AT.ModelOffset ) end
					if AT.ModelOffset0 and AT.ModelOffset1 then bpos:Add( LerpVector( data._SlideAmount or 0.5, AT.ModelOffset0, AT.ModelOffset1 ) ) end
					bang:Add( data.Ang )
					if AT.ModelRotate then bang:Add( AT.ModelRotate ) end
					if data.Scale then bscale:Mul( data.Scale ) end
					if AT.ModelScale then bscale:Mul( AT.ModelScale ) end

					ang:RotateAroundAxis( ang:Right(), bang.p )
					ang:RotateAroundAxis( ang:Forward(), bang.y )
					ang:RotateAroundAxis( ang:Up(), bang.r )
					md:SetAngles( ang )

					pos:Add( ang:Right() * bpos.x )
					pos:Add( ang:Forward() * bpos.y )
					pos:Add( ang:Up() * bpos.z )
					md:SetPos( pos )

					local may = Matrix()
					may:SetScale( bscale )
					md:EnableMatrix( "RenderMultiply", may )

					for i, SIGHT in ipairs( self.SightList ) do
						md:SetSubMaterial( SIGHT.SightData.OpticRTMaterialIndex )
						if index != SIGHT.AttIndex then continue end
						if i != self:GetActiveSight() then continue end
						local SIGHT = SIGHT.SightData
						if SIGHT.OpticRT then
							rtsurf:SetTexture("$basetexture", rtmat)

							local a1, a2 = md:GetAttachment( SIGHT.OpticAtt_Center ), md:GetAttachment( SIGHT.OpticAtt_Bottom )
							local y1, y2, h = a1.Pos:ToScreen(), a2.Pos:ToScreen(), ScrH()/2
							y1, y2 = y1.y, y2.y
							scofov = (y2-y1)/h
							scomag = Lerp( SIGHT.SightZoom or 0, SIGHT.OpticRTMagnification, SIGHT.OpticRTMagnificationMax or SIGHT.OpticRTMagnification )
							-- scofov = math.min( 1, scofov )
						
							if SIGHT.OpticRTOverlay and self:GetAim() != 0 then
								render.PushRenderTarget( rtmat )
								cam.Start2D()
									render.ClearDepth()
									if self:GetAim() != 1 then
										local mag = self:GetAim()
										-- render.BlurRenderTarget( rtmat, 4 * mag, 4 * mag, 2 )
									end
									
									-- surface.SetDrawColor( 0, 0, 0, 255*math.Remap(self:GetAim(), 1, 0.5, 0, 1) )
									-- surface.DrawRect( 0, 0, 512, 512 )
								cam.End2D()
								render.PopRenderTarget()
							end
						end
					end
					
					for i, SIGHT in ipairs( self.SightList ) do
						if index != SIGHT.AttIndex then continue end
						if i != self:GetActiveSight() then continue end
						if self:GetAim() != 0 then
							md:SetSubMaterial( SIGHT.SightData.OpticRTMaterialIndex, "suburb/rt" )
						end
					end
					md:SetupBones()
					md:DrawModel()

					-- Handmod
					if index == 12 then
						for _, bone in pairs(Suburb.Handmods_L) do
							local bone_viewmodel = vm:LookupBone(bone)
							local bone_handmod = md:LookupBone(bone)

							if !bone_viewmodel then continue end
							if !bone_handmod then continue end

							local matrix_viewmodel = vm:GetBoneMatrix(bone_viewmodel)
							local matrix_handmod = md:GetBoneMatrix(bone_handmod)
					
							if !matrix_viewmodel then continue end
							if !matrix_handmod then continue end

							local pos_viewmodel = matrix_viewmodel:GetTranslation()
							local ang_viewmodel = matrix_viewmodel:GetAngles()
							local pos_handmod = matrix_handmod:GetTranslation()
							local ang_handmod = matrix_handmod:GetAngles()

							local newtransform = Matrix()

							local pomper = self.CurrAnim
							if pomper and self.Animations[pomper] and self.Animations[pomper].Handmods_L then
								local hmblend = self:HandmodCalc( self.Animations[pomper].Handmods_L, math.TimeFraction( self.CurrAnimStart, self.CurrAnimEnd, CurTime() ), false )
								newtransform:SetTranslation(LerpVector(hmblend, pos_viewmodel, pos_handmod))
								newtransform:SetAngles(LerpAngle(hmblend, ang_viewmodel, ang_handmod))
							else	
								newtransform:SetTranslation(pos_handmod)
								newtransform:SetAngles(ang_handmod)
							end

							vm:SetBoneMatrix(bone_viewmodel, newtransform)
						end
					end
					-- Handmod end
				end
			end
		end
	end

	self:AttHook( "Hook_PreDrawViewModel", vm, weapon, ply )
end

hook.Add("HUDPaint", "Suburb_Test_HUDPaint", function()
	local w, h, p = ScrW(), ScrH(), LocalPlayer()
	local wep = LocalPlayer():GetActiveWeapon()
	if false and IsValid(wep) and wep.Suburb then
		surface.SetDrawColor( color_white )
		
		surface.DrawLine( y1.x - 2, y1.y - 2, y1.x + 2, y1.y + 2 )
		surface.DrawLine( y1.x - 2, y1.y + 2, y1.x + 2, y1.y - 2 )

		surface.DrawLine( y2.x - 2, y2.y - 2, y2.x + 2, y2.y + 2 )
		surface.DrawLine( y2.x - 2, y2.y + 2, y2.x + 2, y2.y - 2 )
	end
end)

local thingy = Material( "pp/motionblur" )
function SWEP:PostDrawViewModel( vm, weapon, ply )
	cam.End3D()

	if self:GetAim() > 0 then
	local device = self:GetReloadingAimAlt()
	local ipose = self:GetCurrentSight()
	cam.Start3D(nil, nil, Suburb.FOVix( GetConVar("uc_dev_benchgun"):GetBool() and LocalPlayer():GetFOV() or Lerp( math.ease.InSine( self:GetAimAlt() * device ), self.ViewModelFOV, silly or ipose.ViewModelFOV ) ), nil, nil, nil, nil, 1, 10000 )
	cam.IgnoreZ(false)
	for index, data in pairs( self.Attachments ) do
		if data._Model then
			local AT = Suburb.AttTable[data._Installed]
			assert(AT, "Suburb Think: That attachment doesn't exist!!", index, data._Installed)
			local md = data._Model
			
			for i, SIGHT in ipairs( self.SightList ) do
				if index != SIGHT.AttIndex then continue end
				if i != self:GetActiveSight() then continue end
				local SIGHT = SIGHT.SightData

				-- stencil shit
				local ref = 56
				render.UpdateScreenEffectTexture()
				render.ClearStencil()
				render.SetStencilEnable(true)
				render.SetStencilCompareFunction(STENCIL_ALWAYS)
				render.SetStencilPassOperation(STENCIL_REPLACE)
				render.SetStencilFailOperation(STENCIL_KEEP)
				render.SetStencilZFailOperation(STENCIL_REPLACE)
				render.SetStencilWriteMask(255)
				render.SetStencilTestMask(255)
				
				render.SetBlend( 0 )
				render.SetStencilReferenceValue(ref)

				md:SetBodyGroups( SIGHT.StencilTest or "" )
				md:DrawModel()

				render.SetBlend( 1 )

				render.SetStencilPassOperation(STENCIL_KEEP)
				render.SetStencilCompareFunction(STENCIL_EQUAL)

				local p = LocalPlayer()
				local ea = EyeAngles()
				ea = ea - p:GetViewPunchAngles()
				local attd = md:GetAttachment(SIGHT.OpticAtt_Center)
				local meow = attd.Ang
				if SIGHT.OpticAtt_Rotate then
					meow = Angle( attd.Ang )
					meow:RotateAroundAxis( meow:Right(), SIGHT.OpticAtt_Rotate.p )
					meow:RotateAroundAxis( meow:Up(), SIGHT.OpticAtt_Rotate.y )
					meow:RotateAroundAxis( meow:Forward(), SIGHT.OpticAtt_Rotate.r )
				end
				local meowe = meow:Forward()
				meowe:Mul( 8192 )
				local tr = {
					start = attd.Pos,
					endpos = attd.Pos + meowe,
					filter = LocalPlayer(),
					mask = 0,
				}
				tr = util.TraceLine( tr )
				tr = tr.HitPos:ToScreen()

				cam.Start2D()
					local colorable = Color( 255, 0, 0, 255 )
					if SIGHT.OpticRT then
						local size = ScrH() * scofov

						surface.SetDrawColor( 255, 0, 0, 255 )
						surface.SetMaterial( SIGHT.OpticRTOverlay )
						local x, y, w, h = tr.x - (size/2), tr.y - (size/2), size, size
						x, y, w, h = math.ceil( x ), math.ceil( y ), math.ceil( w ), math.ceil( h )
						surface.DrawTexturedRect( x, y, w, h )
						surface.SetDrawColor( 0, 0, 0, 255 )

						surface.DrawRect( x, 0, w, y ) -- top
						surface.DrawRect( x, h+y, w, h ) -- bottom

						surface.DrawRect( 0, 0, x, ScrH() ) -- left
						surface.DrawRect( x+w, 0, x, ScrH() ) -- right
					elseif SIGHT.Reflex then
						
						if istable( SIGHT.ReflexOverlay ) then
							for i, DATA in ipairs( SIGHT.ReflexOverlay ) do
								local size = DATA.ReflexSize * ( ScrH() / 720 )
								surface.SetMaterial( DATA.ReflexOverlay )

								local x, y, w, h = tr.x - (size/2), tr.y - (size/2), size, size
								x, y, w, h = math.Round( x ), math.Round( y ), math.Round( w ), math.Round( h )
								surface.SetDrawColor( DATA.ReflexColor == "colorable" and colorable or DATA.ReflexColor or Color( 255, 0, 0, 255 ) )
								surface.DrawTexturedRect( x, y, w, h )
							end
						else
							local size = DATA.ReflexSize * ( ScrH() / 720 )
							surface.SetMaterial( DATA.ReflexOverlay )

							local x, y, w, h = tr.x - (size/2), tr.y - (size/2), size, size
							x, y, w, h = math.Round( x ), math.Round( y ), math.Round( w ), math.Round( h )
							surface.SetDrawColor( DATA.ReflexColor == "colorable" and colorable or DATA.ReflexColor or Color( 255, 0, 0, 255 ) )
							surface.DrawTexturedRect( x, y, w, h )
						end
					end
				cam.End2D()

				render.DepthRange(0, 1)
				render.SetStencilEnable(false)
				-- stencil shit end

				md:SetBodyGroups( "0000" )
			end
		end
	end
	cam.End3D()
	end
end

function SWEP:GetAimAlt()
	return math.ease.InSine( math.ease.OutCirc( math.Clamp( math.TimeFraction( 0.33, 0.95, self:GetAim() ), 0, 1 ) ) )
end

function SWEP:GetReloadingAimAlt()
	return (1-math.ease.InOutSine(self.superaimedin or 0)*0.5)
end

local ccvar_disablecache
function SWEP:BuildSightList()
	ccvar_disablecache = ccvar_disablecache or GetConVar("uc_dev_disablecache")
	if self.SightList and !ccvar_disablecache:GetBool() then return self.SightList end
	self.SightList = {}

	for slotindex, slot in ipairs( self.Attachments ) do
		if !slot._Installed then continue end
		local att = Suburb.AttTable[slot._Installed]
		if !att.Sights then continue end

		slot._SightData = {}
		for sightindex, sight in ipairs( att.Sights ) do
			local copy = table.Copy( sight )
			copy.SightZoom = 0
			copy.AttIndex = i

			copy.Pos, copy.Ang = self:GenerateSightPosition( slot.Pos, slot.Ang, slot.Bone, sight.Pos, sight.Ang )
			table.insert( slot._SightData, copy )
			table.insert( self.SightList, { AttIndex = slotindex, SightIndex = sightindex, SightData = copy } )
		end
	end

	return self.SightList
end

local col_bone = Color( 155, 0, 0 )
local col_sight = Color( 30, 30, 155 )

function SWEP:GenerateSightPosition( pos, ang, bone, upos, uang )
	if CLIENT then
		-- print( "Suburb GenerateSightPosition: Let's generate a sight position" )
		if IsValid(GOAT) then GOAT:Remove() end
		GOAT = ClientsideModel( self.ViewModel )
		GOAT:SetPos( vector_origin )
		GOAT:SetAngles( angle_zero )
		GOAT:SetNoDraw( true )
		GOAT:ResetSequence( "idle" )
		GOAT:SetPlaybackRate( 0 )
		GOAT:SetupBones()

		local mat = GOAT:GetBoneMatrix( GOAT:LookupBone( bone ) )
		if !mat then print( "Suburb GenerateSightPosition: Failed to get the bone matrix" ) return false end
		local m_p, m_a = mat:GetTranslation(), mat:GetAngles()

		GOAT:Remove()

		-- debugoverlay.Axis( vector_origin, angle_zero, 4, 0, true )
		--debugoverlay.Axis( m_p, m_a, 8, 0, true )

		local t_pos, t_ang = m_p, m_a

		-- Slot

		t_ang:RotateAroundAxis( t_ang:Right(),		ang.p )
		t_ang:RotateAroundAxis( t_ang:Forward(),	ang.y )
		t_ang:RotateAroundAxis( t_ang:Up(),			ang.r )
		t_pos:Add( t_ang:Forward() *			pos.y )
		t_pos:Add( t_ang:Right() *				pos.x )
		t_pos:Add( t_ang:Up() *					pos.z )

		-- Sight

		t_ang:RotateAroundAxis( t_ang:Right(),		uang.p )
		t_ang:RotateAroundAxis( t_ang:Forward(),	uang.y )
		t_ang:RotateAroundAxis( t_ang:Up(),			uang.r )
		t_pos:Add( t_ang:Forward() *			upos.y )
		t_pos:Add( t_ang:Up() *					upos.z )
		t_pos:Add( t_ang:Right() *				upos.x )

		
		-- cleanup
		do
			local x,y,z = t_pos.x,t_pos.y,t_pos.z
			t_pos.y = -x
			t_pos.z = -z
			t_pos.x = y

			t_ang.x = -t_ang.x
			t_ang.y = -t_ang.y
			t_ang.z = -t_ang.z
		end

		-- debugoverlay.Axis( t_pos, t_ang, 16, 0, true )

		return t_pos, t_ang
	else
		--print( "Suburb GenerateSightPosition: Why are you, as the server, calling this?" )
	end
end

function SWEP:GetCurrentSight()
	local sightlist = self:BuildSightList()
	if sightlist[self:GetActiveSight()] then
		return sightlist[self:GetActiveSight()].SightData
	end
	return self:GetStat("IronsightPose")
end

function SWEP:TranslateFOV(fov)
	local device = self:GetReloadingAimAlt()
	local mag = 1.1
	local SIGHT = self:GetCurrentSight()
	if SIGHT and SIGHT.Magnification then
		mag = SIGHT.Magnification
		cheapscope = cheapscope or GetConVar("uc_cl_cheapscopes")
		if SIGHT.OpticRTMagnification and CLIENT and cheapscope:GetBool() then
			mag = mag*Lerp( SIGHT.SightZoom, SIGHT.OpticRTMagnification, SIGHT.OpticRTMagnificationMax or SIGHT.OpticRTMagnification )
		end
	end
	return Lerp( self:GetAimAlt(), fov, 90 ) / Lerp( math.ease.InQuad( self:GetAimAlt() * device ), 1, mag )
end

function SWEP:AdjustMouseSensitivity()
	local device = self:GetReloadingAimAlt()
	local mag = 1.1
	local SIGHT = self:GetCurrentSight()
	if SIGHT and SIGHT.Magnification then
		mag = SIGHT.Magnification
		if SIGHT.OpticRTMagnification then
			mag = mag*Lerp( SIGHT.SightZoom, SIGHT.OpticRTMagnification, SIGHT.OpticRTMagnificationMax or SIGHT.OpticRTMagnification )
		end
	end
	local dfov = GetConVar("fov_desired"):GetInt()
	local normalfov = Lerp( self:GetAimAlt(), dfov, 90 ) / dfov
	return (normalfov or 1) / Lerp( math.ease.InSine( self:GetAimAlt() * device ), 1, mag )
end

function SWEP:CalcView( ply, pos, ang, fov )
	if self.QCA_Camera then
		if !(Suburb_CL1 and IsValid(Suburb_CL1)) then
			Suburb_CL1 = ClientsideModel( "models/weapons/c_pistol.mdl" )
			Suburb_CL1.Garbage_Owner = self
			Suburb_CL1.Garbage_PlayerOwner = self:GetOwner()
			Suburb_CL1.Garbage_Name = "Camera Reference"
			Suburb_GC( Suburb_CL1 )
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
		addy:Mul( GetConVar("uc_cl_cammult"):GetFloat() )
		ang:Add( addy )
	end
	return pos, ang, fov
end

-- Handmod calculator
function SWEP:HandmodCalc( inp, per, r )
	local val = 1

	local blend_out		= math.TimeFraction( inp[1], inp[2], per )
	local stationary	= math.TimeFraction( inp[2], inp[3], per )
	local blend_in		= math.TimeFraction( inp[3], inp[4], per )

	if blend_out > 1 or blend_out < 0 then
		blend_out = 0
	end

	if stationary > 1 or stationary < 0 then
		stationary = 0
	else
		stationary = 1
	end

	if blend_in > 1 or blend_in < 0 then
		blend_in = 0
	else
		blend_in = 1-blend_in
	end

	val = val - blend_out
	val = val - stationary
	val = val - blend_in

	return val
end

-- Worldmodel

function SWEP:DrawWorldModel( flags )
	if CLIENT then

	local p = LocalPlayer()
			
	local boneid = p:LookupBone("ValveBiped.Bip01_R_Hand")
	if !boneid then return end
	local matrix = p:GetBoneMatrix(boneid)
	if !matrix then return end

	local offsetVec = Vector(-10, -3.5, -6.5)
	local offsetAng = Angle(0, 0, 180)

	local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

	self:RemoveEffects( EF_BONEMERGE )
	self:RemoveEffects( EF_BONEMERGE_FASTCULL )
	self:SetPos( newPos )
	self:SetAngles( newAng )
	self:DrawModel( flags )

	end
end