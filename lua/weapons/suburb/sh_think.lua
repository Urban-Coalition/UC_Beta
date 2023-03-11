function SWEP:Think()
	local p = self:GetOwner()
	if !IsValid(p) then
		p = false
	end
	if p then
		local ht = self.HoldTypeHip
		if self:GetAim() > 0.2 then
			ht = self.HoldTypeSight
		end
		local spint = p:IsSprinting() or self:GetSprintPer() > 0.5
		if spint then
			ht = self.HoldTypeSprint
		end
		self:SetSprintPer( math.Approach( self:GetSprintPer(), p:IsSprinting() and 1 or 0, FrameTime() / self.SprintTime ) )
		self:SetHoldType( ht )
		self:SetWeaponHoldType( ht )

		--self:SetUserSight( p:KeyDown( IN_ATTACK2 ) )
		if self:GetOwner():GetInfoNum("uc_cl_aimtoggle", 0) == 0 then
			self:SetUserSight( self:GetOwner():KeyDown(IN_ATTACK2) )
		else
			if self:GetOwner():GetInfoNum("uc_cl_aimtoggle_reload", 0) == 1 and self:GetReloadingTime() > CurTime() then
				self:SetUserSight( false )
			elseif self:GetOwner():GetInfoNum("uc_cl_aimtoggle_sprint", 1) == 1 and spint then
				self:SetUserSight( false )
			elseif self:GetOwner():KeyPressed(IN_ATTACK2) then
				self:SetUserSight( !self:GetUserSight() )
			end
		end
		local canaim = (self:GetStopSightTime() <= CurTime()) and !spint
		self:SetAim( math.Approach( self:GetAim(), self:GetUserSight() and canaim and 1 or 0, FrameTime() / (canaim and self.SightTime or 0.2) ) )

		local trdown = p:KeyDown(IN_ATTACK)
		if !trdown then
			self:SetBurstCount( 0 )
		end
		if p:GetViewModel() then
			p:GetViewModel():SetPoseParameter( "sights", self:GetAim() )
		end
		if CLIENT then
			self.superaimedin = math.Approach( self.superaimedin or 0, (self:GetReloadingTime() > CurTime()) and 1 or 0, FrameTime() / 0.5 )
		end

		local pred = (game.SinglePlayer() and SERVER) or (!game.SinglePlayer())
		if true then
			if self:GetShotgunReloading() then
				if self:GetShotgunReloadingTime() <= CurTime() then
					if trdown or self:Ammo1() <= 0 or self:Clip1() == self:GetMaxClip1() then
						self:SetReloadingTime( CurTime() )
						self:SetLoadIn( 0 )
						if self.ManualAction and self:GetCycleCount() >= self.ManualAction then
							self:SendAnimChoose("sgreload_finish_empty", "sgfinish")
							self:SetCycleCount( 0 )
						else
							self:SendAnimChoose("sgreload_finish", "sgfinish")
						end
						self:SetShotgunReloading(false)
					else
						self:SendAnimChoose("sgreload_insert", "sginsert")
					end
				end
			elseif self.ManualAction and self:GetCycleDelayTime() <= CurTime() and self:GetCycleCount() >= self.ManualAction and self:Clip1() > 0 and !trdown then
				self:SetCycleCount(0)
				self:SendAnimChoose("cycle", "cycle")
			end
		end

		self:Think_Shell()

		if self:GetLoadIn() != 0 and self:GetLoadIn() <= CurTime() then
			local needtoload = math.min( self.Primary.ClipSize - self:Clip1(), self:GetLoadAmount(), self:Ammo1() )
			self:SetLoadIn( 0 )
			assert( (self:Clip1() + needtoload) > 0, "loading under 0 rounds??" .. (self:Clip1() + needtoload) )
			self:SetClip1(self:Clip1() + needtoload)
			self:GetOwner():RemoveAmmo( needtoload, self.Primary.Ammo )
		end

		local movem = p:GetAbsVelocity():Length2D()
		movem = math.TimeFraction( 110, 170, movem )
		movem = math.Clamp( movem, 0, 1 )
		self:SetDISP_Air( math.Approach( self:GetDISP_Air(), p:OnGround() and 0 or 1, FrameTime() / 0.15 ) )
		self:SetDISP_Move( math.Approach( self:GetDISP_Move(), movem, FrameTime() / 0.33 ) )
		self:SetDISP_Crouch( math.Approach( self:GetDISP_Crouch(), p:Crouching() and 1 or 0, FrameTime() / 0.4 ) )
		
		local spmp = (SERVER and game.SinglePlayer()) or ( !game.SinglePlayer() and CLIENT and IsFirstTimePredicted() )
		if self.RecoilTable and spmp then
			local blah = Angle()
			blah:Set( p:EyeAngles() )
			for i, assign in pairs(self.RecoilTable) do
				blah.p = blah.p - math.Approach( 0, assign.dir.p, FrameTime() * assign.speed )
				blah.y = blah.y - math.Approach( 0, assign.dir.y, FrameTime() * assign.speed )
				assign.dir.p = math.Approach( assign.dir.p, 0, FrameTime() * assign.speed )
				assign.dir.y = math.Approach( assign.dir.y, 0, FrameTime() * assign.speed )
				if assign.dir.p == 0 and assign.dir.y == 0 then
					self.RecoilTable[i] = nil
				end
			end
			p:SetEyeAngles( blah )
		end
		if self:GetIdleIn() > 0 and self:GetIdleIn() <= CurTime() then
			self:SendAnimChoose( "idle", "idle" )
			self:SetPlaybackRate( 1 )
			self:SetIdleIn( -1 )
		end
	end

	local pomper = self:GetCurrentAnim()
	if pomper != "" and self.Animations[pomper] then
		pomper = self.Animations[pomper]
		if pomper.Events then
			for i, v in pairs(pomper.Events) do
				if !v.PLAYED and v.STARTTIME and v.STARTTIME <= CurTime() then
					self:EmitSound( Suburb.quickie(v.s), v.l or 60, v.p or 100, v.v or 1, v.c or CHAN_STATIC )
					v.PLAYED = true
				end
			end
		end
	end
end