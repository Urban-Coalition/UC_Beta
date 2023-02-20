

function SWEP:SwitchFiremode(prev)
	-- lol?
	local nextfm = self:GetFiremode() + 1
	if #self.Firemodes < nextfm then
		nextfm = 1
	end
	if self:GetFiremode() != nextfm then
		self:SetFiremode(nextfm)
		if !IsFirstTimePredicted() then return end
		if SERVER then SuppressHostEvents( self:GetOwner() ) end
			self:EmitSound("suburb/firemode.ogg", 60, 100, 0.5, CHAN_STATIC)
			if CLIENT then self:GetOwner():ChatPrint( "Switched to " .. self:GetFiremodeName() ) end
		if SERVER then SuppressHostEvents( NULL ) end
	end
end

function SWEP:GetFiremodeName(cust)
	local ftn = self:GetFiremodeTable(cust or self:GetFiremode())
	if ftn.Name then
		ftn = ftn.Name
	elseif ftn.Mode == math.huge then
		ftn = "Automatic"
	elseif ftn.Mode == 1 then
		ftn = "Semi-automatic"
	else
		ftn = ftn.Mode .. "-round burst"
	end

	return ftn
end

function SWEP:GetFiremodeTable(cust)
	return self.Firemodes[cust or self:GetFiremode()] or false
end

function SWEP:PrimaryAttack()
	if CurTime() < self:GetNextFire() then
		return false
	end
	if CurTime() < self:GetReloadingTime() then
		return false
	end
	if self:GetSprintPer() > 0.2 then
		return false
	end
	if self:Clip1() <= 0 then
		self:Reload()
		return false
	end
	if self:GetBurstCount() >= self:GetFiremodeTable().Mode then
		return false
	end
	if self.ManualAction and self:GetCycleCount() >= self.ManualAction then
		return false
	end
	if CurTime() < self:GetCycleDelayTime() then
		return false
	end

	self:SetNextFire( CurTime() + self.Delay )
	self:SetClip1( self:Clip1() - 1 )
	self:SetBurstCount( self:GetBurstCount() + 1 )
	if self.ManualAction then
		self:SetCycleCount( self:GetCycleCount() + 1 )
	end
	self:SetTotalShotCount( self:GetTotalShotCount() + 1 )

	self:Attack_Sound()
	self:Attack_Effects()
	self:SendAnimChoose( "fire" )

	local spmp = (SERVER and game.SinglePlayer()) or (CLIENT and IsFirstTimePredicted())
	local p = self:GetOwner()
	if IsValid(p) then
		if !self.RecoilTable then
			self.RecoilTable = {}
		end
		if spmp then
			local randy = util.SharedRandom( "Suburb_RecoilSide", -1, 1 )
			local recoil = {}
			recoil.dir = Angle( self.RecoilUp * (self.RecoilDrift), randy * self.RecoilSide * (self.RecoilDrift) )
			recoil.speed = self.RecoilDecay
			table.insert( self.RecoilTable, recoil )
			local recoil = {}
			recoil.dir = Angle( self.RecoilUp * (1-self.RecoilDrift), randy * self.RecoilSide * (1-self.RecoilDrift) )
			recoil.speed = math.huge
			table.insert( self.RecoilTable, recoil )
			p:ViewPunch( Angle( self.RecoilUp * 0.2, self.RecoilSide * randy * -0.2, self.RecoilSwing * randy ) )
		end
	end
	
	local dir = p:EyeAngles()
	local dir_disp = Angle( dir.p, dir.y, 0 ):Forward()
	self:ApplyRandomSpread( dir_disp, 1*(self:GetDispersion()/90) )

	for i=1, self.Pellets or 1 do
		local p = self:GetOwner()
		local dir_acc = dir_disp:Angle():Forward()
		self:ApplyRandomSpread( dir_acc, 1*(self.Accuracy/90), i )

		self:FireBullets({
			Attacker = IsValid(p) and p or self,
			Damage = 0,
			Force = self.Force,
			Tracer = 1,
			Dir = dir_acc,
			Src = p:EyePos(),
			Spread = vector_origin,
			Callback = function( atk, tr, dmg )
				local ent = tr.Entity

				if self.CustomCallback then self:CustomCallback( atk, tr, dmg ) end

				dmg:SetDamage( self.DamageNear )
				dmg:SetDamageType( DMG_BULLET )

				dmg:SetDamage( Suburb.getdamagefromrange( self.DamageNear, self.DamageFar, self.RangeNear / Suburb.HUToM, self.RangeFar / Suburb.HUToM, atk:GetPos():Distance(tr.HitPos) ) )
			end
		})
	end

	return true
end

function SWEP:ApplyRandomSpread( dir, spread, pellet )
	local radius = util.SharedRandom("Suburb_RandSpread1", 0, 1, pellet )
	local theta = util.SharedRandom("Suburb_RandSpread2", 0, math.rad(360), pellet )
	local bulletang = dir:Angle()
	local forward, right, up = bulletang:Forward(), bulletang:Right(), bulletang:Up()
	local x = radius * math.sin(theta)
	local y = radius * math.cos(theta)

	dir:Set(dir + right * spread * x + up * spread * y)
end

function SWEP:SecondaryAttack()
	return true
end

local function starvingchildren( self, detail, volumemult, level, chan )
	return self:EmitSound( detail.s, level, (detail.p and math.Rand( detail.p, detail.pm or detail.p )) or 100, (detail.v or 1) * volumemult, chan )
end

function SWEP:Attack_Sound()
	local shotthing1 = CHAN_USER_BASE+50 -- 150+((self:GetTotalShotCount()+0)%4)
	local shotthing2 = CHAN_USER_BASE+51 -- 154+((self:GetTotalShotCount()+1)%4)
	local shotthing3 = CHAN_VOICE2 -- 158+((self:GetTotalShotCount()+2)%4)
	local shotthing4 = CHAN_STREAM -- 162+((self:GetTotalShotCount()+3)%4)

	if #self.Sound_Blast > 0 then
		self.Sound_Blast["BaseClass"] = nil
		local detail = self.Sound_Blast[math.Round(util.SharedRandom("Suburb_SoundBlast1", 1, #self.Sound_Blast))]
		starvingchildren( self, detail, 1, 90, shotthing1 )
	end

	if #self.Sound_Mech > 0 then
		self.Sound_Mech["BaseClass"] = nil
		local detail = self.Sound_Mech[math.Round(util.SharedRandom("Suburb_SoundBlast2", 1, #self.Sound_Mech))]
		starvingchildren( self, detail, Lerp( self:GetAim(), 0.5, 1 ), 70, shotthing2 )
	end

	local innyouty = self:InnyOuty()

	if #self.Sound_TailEXT > 0 then
		self.Sound_TailEXT["BaseClass"] = nil
		local detail = self.Sound_TailEXT[math.Round(util.SharedRandom("Suburb_SoundBlast3", 1, #self.Sound_TailEXT))]
		starvingchildren( self, detail, innyouty, 160, shotthing3 )
	end

	if #self.Sound_TailINT > 0 then
		self.Sound_TailINT["BaseClass"] = nil
		local detail = self.Sound_TailINT[math.Round(util.SharedRandom("Suburb_SoundBlast4", 1, #self.Sound_TailINT))]
		starvingchildren( self, detail, 1-innyouty, 160, shotthing4 )
	end
end

function SWEP:Attack_Effects()
	if SPred() then return end

	local ed = EffectData()
	ed:SetEntity(self)
	ed:SetAttachment(self.QCA_Muzzle or 1)

	util.Effect("suburb_muzzleeffect", ed)
end

function SWEP:Attack_Effects_Shell()
	local eff = "suburb_shelleffect"

	local owner = self:GetOwner()
	if !IsValid(owner) then return end

	local vm = self

	if !owner:IsNPC() then owner:GetViewModel() end

	local att = vm:GetAttachment(self.QCA_Case or 2)

	if !att then return end

	local pos, ang = att.Pos, att.Ang

	local ed = EffectData()
	ed:SetOrigin(pos)
	ed:SetAngles(ang)
	ed:SetAttachment(self.QCA_Case or 2)
	ed:SetScale(1)
	ed:SetEntity(self)
	ed:SetNormal(ang:Forward())
	ed:SetMagnitude(100)

	local efov = {}
	efov.eff = eff
	efov.fx  = ed

	util.Effect(eff, ed)
end

function SWEP:GetDispersion()
	local disp = self.Dispersion

	disp = disp + ( self:GetDISP_Air() * self.Dispersion_Air )
	disp = disp + ( self:GetDISP_Move() * self.Dispersion_Move )

	disp = Lerp( self:GetDISP_Crouch(), disp, disp * self.Dispersion_Crouch )
	disp = Lerp( self:GetAim(), disp, disp * self.Dispersion_Sights )

	return disp
end



-- Indoor outdoor sound stuff


local tracestuff = {
	{
		Distance = Vector(0, 0, 1024),
		Influence = 1,
	}, -- Up
	{
		Distance = Vector(0, 1024, 1024),
		Influence = 1,
	}, -- Up Forward
	{
		Distance = Vector(0, -1024, 1024),
		Influence = 1,
	}, -- Up Back
	{
		Distance = Vector(0, 768, 0),
		Influence = 0.35,
	}, -- Forward
	{
		Distance = Vector(0, -1024, 0),
		Influence = 0.35,
	}, -- Back
	{
		Distance = Vector(768, 768, 0),
		Influence = 0.35,
	}, -- Right
	{
		Distance = Vector(-768, 768, 0),
		Influence = 0.35,
	}, -- Left
	{
		Distance = Vector(-768, -768, 0),
		Influence = 0.35,
	}, -- Left Back
	{
		Distance = Vector(768, -768, 0),
		Influence = 0.35,
	}, -- Right Back
}

local tracebase = {
    start = 0,
    endpos = 0,
    filter = NULL,
}

function SWEP:InnyOuty()
	local vol = 0
	local wo = self:GetOwner()
	local wop = wo:EyePos()
	local woa = Angle(0, wo:EyeAngles().y, 0)
	local t_influ = 0

	for _, tin in ipairs(tracestuff) do
		tracebase.start = wop
		offset = Vector()
		offset = offset + (tin.Distance.x * woa:Right())
		offset = offset + (tin.Distance.y * woa:Forward())
		offset = offset + (tin.Distance.z * woa:Up())
		tracebase.endpos = wop + offset
		tracebase.filter = wo
		t_influ = t_influ + (tin.Influence or 1)
		local result = util.TraceLine(tracebase)
		if GetConVar("developer"):GetInt() > 1 then
			debugoverlay.Line(wop - (vector_up * 4), result.HitPos - (vector_up * 4), 1, Color((_ / 4) * 255, 0, (1 - (_ / 4)) * 255))
			debugoverlay.Text(result.HitPos - (vector_up * 4), math.Round((result.HitSky and 1 or result.Fraction) * 100) .. "%", 1)
		end
		vol = vol + (result.HitSky and 1 or result.Fraction) * tin.Influence
	end

	vol = vol / t_influ
	if GetConVar("developer"):GetInt() > 1 then
		print(vol)
	end

	return vol
end