function SPred()
	return !game.SinglePlayer() and !IsFirstTimePredicted()
end

function SWEP:Think()
	local p = self:GetOwner()
	if IsValid(p) then
		local vm = p:GetViewModel()
		if IsValid(vm) then
			for i=1, 32 do
				vm:SetBodygroup( i-1, 0 )
				vm:SetSkin(0)
			end
		end
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

		self:SetUserSight( p:KeyDown( IN_ATTACK2 ) )
		local canaim = (self:GetStopSightTime() <= CurTime()) and !spint
		self:SetAim( math.Approach( self:GetAim(), self:GetUserSight() and canaim and 1 or 0, FrameTime() / (canaim and self.SightTime or 0.2) ) )

		if self:GetLoadIn() != 0 and self:GetLoadIn() <= CurTime() then
			local needtoload = math.min( self.Primary.ClipSize - self:Clip1(), self:Ammo1() )
			self:SetClip1(self:Clip1() + needtoload)
			self:GetOwner():RemoveAmmo( needtoload, self.Primary.Ammo )
			self:SetLoadIn( 0 )
		end

		if !p:KeyDown( IN_ATTACK ) then
			self:SetBurstCount( 0 )
		end
		if p:GetViewModel() and SPred() then
			p:GetViewModel():SetPoseParameter( "sights", self:GetAim() )
		end
		if CLIENT then
			self.superaimedin = math.Approach( self.superaimedin or 0, (self:GetReloadingTime() > CurTime()) and 1 or 0, FrameTime() / 0.5 )
		end

		local movem = p:GetAbsVelocity():Length2D()
		movem = math.TimeFraction( 110, 170, movem )
		movem = math.Clamp( movem, 0, 1 )
		self:SetDISP_Air( math.Approach( self:GetDISP_Air(), p:OnGround() and 0 or 1, FrameTime() / 0.15 ) )
		self:SetDISP_Move( math.Approach( self:GetDISP_Move(), movem, FrameTime() / 0.15 ) )
		self:SetDISP_Crouch( math.Approach( self:GetDISP_Crouch(), p:Crouching() and 1 or 0, FrameTime() / 0.4 ) )
		
		local spmp = (SERVER and game.SinglePlayer()) or (CLIENT and IsFirstTimePredicted())
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