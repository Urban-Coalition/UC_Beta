

function SWEP:SwitchFiremode(prev)
	-- lol?
	local nextfm = self:GetFiremode() + 1
	if #self.Firemodes < nextfm then
		nextfm = 1
	end
	if self:GetFiremode() != nextfm then
		self:SetFiremode(nextfm)
		if SERVER then
			SuppressHostEvents( self:GetOwner() )
		end
		self:EmitSound("weapons/smg1/switch_single.wav", 60, 100, 0.5, CHAN_STATIC)
		if SERVER then
			SuppressHostEvents( NULL )
		end
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

hook.Add( "StartCommand", "Suburb_StartCommand", function( ply, cmd )
	if ply and IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().Suburb then
		local wep = ply:GetActiveWeapon()
		if wep:GetHolster_Time() != 0 and wep:GetHolster_Time() <= CurTime() then
			if IsValid(wep:GetHolster_Entity()) then
				cmd:SelectWeapon(wep:GetHolster_Entity())
			end
		end

		if cmd:GetImpulse() == 150 then
			wep:SwitchFiremode()
		end
	end
end)

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

	self:SetNextFire( CurTime() + self.Delay )
	self:SetClip1( self:Clip1() - 1 )
	self:SetBurstCount( self:GetBurstCount() + 1 )
	self:SetTotalShotCount( self:GetTotalShotCount() + 1 )

	self:Attack_Sound()
	self:SendAnimChoose( "fire" )

	local dispersion = self:GetDispersion()
	for i=1, self.Pellets or 1 do
		local p = self:GetOwner()
		
		local fsa = p:EyeAngles()
		local dir = Angle( fsa.p, fsa.y, 0 )
		local shared_rand = CurTime() + (i-1)
		local x = util.SharedRandom(shared_rand, -0.5, 0.5) + util.SharedRandom(shared_rand + 1, -0.5, 0.5)
		local y = util.SharedRandom(shared_rand + 2, -0.5, 0.5) + util.SharedRandom(shared_rand + 3, -0.5, 0.5)
		dir = dir:Forward() + (x * math.rad(dispersion) * dir:Right()) + (y * math.rad(dispersion) * dir:Up())
		self:FireBullets({
			Attacker = IsValid(p) and p or self,
			Damage = 0,
			Force = self.Force,
			Tracer = 0,
			Dir = dir,
			Src = p:EyePos(),
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

function SWEP:SecondaryAttack()
	return true
end

local function starvingchildren( self, detail, chan )
	return self:EmitSound( detail.s, detail.l or 80, (detail.p and math.Rand( detail.p, detail.pm or detail.p )) or 100, detail.v or 1, chan )
end

function SWEP:Attack_Sound()
	local shotthing1 = 150+((self:GetTotalShotCount()+0)%4)
	local shotthing2 = 154+((self:GetTotalShotCount()+1)%4)
	local shotthing3 = 158+((self:GetTotalShotCount()+2)%4)
	local shotthing4 = 162+((self:GetTotalShotCount()+3)%4)

	if #self.Sound_Blast > 0 then
		self.Sound_Blast["BaseClass"] = nil
		local detail = self.Sound_Blast[math.Round(util.SharedRandom("Suburb_SoundBlast1", 1, #self.Sound_Blast))]
		starvingchildren( self, detail, shotthing1 )
	end

	if #self.Sound_Mech > 0 then
		self.Sound_Mech["BaseClass"] = nil
		local detail = self.Sound_Mech[math.Round(util.SharedRandom("Suburb_SoundBlast2", 1, #self.Sound_Mech))]
		starvingchildren( self, detail, shotthing2 )
	end

	if #self.Sound_TailEXT > 0 then
		self.Sound_TailEXT["BaseClass"] = nil
		local detail = self.Sound_TailEXT[math.Round(util.SharedRandom("Suburb_SoundBlast3", 1, #self.Sound_TailEXT))]
		starvingchildren( self, detail, shotthing3 )
	end

	if #self.Sound_TailINT > 0 then
		self.Sound_TailINT["BaseClass"] = nil
		local detail = self.Sound_TailINT[math.Round(util.SharedRandom("Suburb_SoundBlast4", 1, #self.Sound_TailINT))]
		--starvingchildren( self, detail, shotthing4 )
	end
end

function SWEP:GetDispersion()
	local disp = self.Dispersion

	disp = disp + ( self:GetDISP_Air() * self.Dispersion_Air )
	disp = disp + ( self:GetDISP_Move() * self.Dispersion_Move )

	disp = Lerp( self:GetDISP_Crouch(), disp, disp * self.Dispersion_Crouch )
	disp = Lerp( self:GetAim(), disp, disp * self.Dispersion_Sights )

	return disp
end