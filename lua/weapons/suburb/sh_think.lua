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

		if CLIENT then
			for i, data in pairs( self.Elements ) do
				if data.Model and data.Bone and !data.iRep then
					local am = ents.CreateClientside( "suburb_att" )
					am:SetModel( data.Model )
					am:Spawn()
					data.iRep = am
				end
			end
		end

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
		if pred then
			if self:GetShotgunReloading() then
				if self:GetShotgunReloadingTime() <= CurTime() then
					if self:Ammo1() <= 0 or self:Clip1() >= (self:GetMaxClip1() + (self:NeedCycle() and 0 or self.ChamberSize) ) then
						self:SetReloadingTime( CurTime() )
						self:SetLoadIn( 0 )
						if self:NeedCycle() then
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
			elseif self.ManualAction and self:GetCycleDelayTime() <= CurTime() and self:NeedCycle() and self:Clip1() > 0 and !trdown then
				self:SetCycleCount(0)
				self:SendAnimChoose("cycle", "cycle")
			end
		end

		self:Think_Shell()

		if self:GetLoadIn() != 0 and self:GetLoadIn() <= CurTime() then
			local needtoload = math.min( self.Primary.ClipSize - self:Clip1(), self:Ammo1() )
			local sgr = self:GetShotgunReloading()
			if (!sgr or sgr and !self:NeedCycle()) then needtoload = needtoload + math.Clamp( self:Clip1(), 0, self.ChamberSize ) end
			needtoload = math.min(self:GetLoadAmount(), needtoload)
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

function SWEP:RegenStats()
	-- Clear the activated elements list
	table.Empty( self.ActivatedElements )

	-- Set elements and whatever
	for index, data in ipairs(self.Attachments) do
		if index == "BaseClass" then continue end

		if data._Installed then
			local AT = Suburb.AttTable[data._Installed]
			assert(AT, "Suburb Think: That attachment doesn't exist!!", index, data._Installed)

			if CLIENT then
				if AT.Model then
					if !data._Model then
						data._Model = ClientsideModel(AT.Model)
						data._Model:SetNoDraw( true )
					else
						if data._Model:GetModel() != AT.Model then
							data._Model:SetModel(AT.Model)
						end
					end
				elseif !AT.Model and data._Model then
					data._Model:Remove()
					data._Model = nil
				end
			end

			if AT.ActivateElements then
				for i, v in ipairs(AT.ActivateElements) do
					self.ActivatedElements[v] = true
				end
			end

			if data.ActivateElements then
				for i, v in ipairs(data.ActivateElements) do
					self.ActivatedElements[v] = true
				end
			end
		else
			if CLIENT and data._Model then
				data._Model:Remove()
				data._Model = nil
			end
		end
	end
	self:AttHook( "Hook_PreRegenBGTab" )

	-- Put it into effect I think
	local vm = self:GetOwner()
	if IsValid(vm) then vm = vm:GetViewModel() end
	if IsValid(vm) then
		local bgtab = { [0] = 0 }
		if self.DefaultBodygroups then
			for i, v in ipairs( string.Explode( " ", self.DefaultBodygroups ) ) do
				bgtab[i-1] = v
			end
		end
		if self.Elements then
			for inde, elem in pairs(self.Elements) do
				if inde == "BaseClass" then continue end
				if !self.ActivatedElements[inde] then continue end
				if elem.Bodygroups then
					for slot, set in pairs(elem.Bodygroups) do
						bgtab[slot] = set
					end
				end
			end
		end
		-- Call bgtab modifying function
		self:AttHook( "Hook_RegenBGTab", bgtab )
		self.BGTable = bgtab
	end
end

function SWEP:UseBGTable( vm )
	if !self.BGTable then return false end
	for i=0, 31 do
		local tt = self.BGTable[i] or 0
		vm:SetBodygroup( i, tt )
	end
	vm:SetSkin( self.DefaultSkin or 0 )
end

function SWEP:GetEffectiveSources()
	local sources = {}
	table.insert( sources, self:GetTable() )
	for index, attslot in ipairs(self.Attachments) do
		if index == "BaseClass" then continue end
		if attslot._Installed then
			assert( Suburb.AttTable[attslot._Installed], "Suburb GetEffectiveSources: That attachment does not exist!: ", attslot._Installed )
			table.insert( sources, Suburb.AttTable[attslot._Installed] )
		end
	end
	return sources
end

function SWEP:AttHook( name, ... )
	for index, att in ipairs(self:GetEffectiveSources()) do
		if att[name] then
			att[name]( self, ... )
		end
	end
end