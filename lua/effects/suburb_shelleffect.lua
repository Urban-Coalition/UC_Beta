
EFFECT.Sounds = {}
EFFECT.Pitch = 90
EFFECT.Scale = 1.5
EFFECT.PhysScale = 1
EFFECT.Model = "models/shells/shell_57.mdl"
EFFECT.Material = nil
EFFECT.JustOnce = true
EFFECT.AlreadyPlayedSound = false
EFFECT.ShellTime = 2

EFFECT.SpawnTime = 0

local ShellSoundsTable = {
	"suburb/casings/casing_556_1.wav",
	"suburb/casings/casing_556_2.wav",
	"suburb/casings/casing_556_3.wav",
	"suburb/casings/casing_556_4.wav"
}

local MediumShellSoundsTable = {
	"suburb/casings/casing_308_1.wav",
	"suburb/casings/casing_308_2.wav",
	"suburb/casings/casing_308_3.wav",
	"suburb/casings/casing_308_4.wav"
}

local PlinkShellSoundsTable = {
	"suburb/casings/casing_22_1.wav",
	"suburb/casings/casing_22_2.wav",
	"suburb/casings/casing_22_3.wav",
	"suburb/casings/casing_22_4.wav"
}

local PistolShellSoundsTable = {
	"suburb/casings/casing_9mm_1.wav",
	"suburb/casings/casing_9mm_2.wav",
	"suburb/casings/casing_9mm_3.wav",
	"suburb/casings/casing_9mm_4.wav"
}

local ShotgunShellSoundsTable = {
	"suburb/casings/casing_12ga_1.wav",
	"suburb/casings/casing_12ga_2.wav",
	"suburb/casings/casing_12ga_3.wav",
	"suburb/casings/casing_12ga_4.wav"
}

function EFFECT:Init(data)

	local att = data:GetAttachment()
	local ent = data:GetEntity()
	local mag = data:GetMagnitude()

	local mdl = LocalPlayer():GetViewModel()

	if LocalPlayer():ShouldDrawLocalPlayer() then
		mdl = ent.WMModel or ent
	end

	if !IsValid(ent) then self:Remove() return end

	local owner = ent:GetOwner()
	if owner != LocalPlayer() then
		mdl = ent.WMModel or ent
	end

	if owner != LocalPlayer() and !(true or GetConVar("arccw_shelleffects"):GetBool()) then self:Remove() return end
	if !IsValid(mdl) then self:Remove() return end
	if !mdl:GetAttachment(att) then self:Remove() return end

	local origin, ang = mdl:GetAttachment(att).Pos, mdl:GetAttachment(att).Ang

	ang:RotateAroundAxis(ang:Right(), -90 + (ent.ShellRotate or 0))

	local dubm = ent.ShellRotateAngle or angle_zero
	ang:RotateAroundAxis(ang:Right(), dubm[1])
	ang:RotateAroundAxis(ang:Up(), dubm[2])
	ang:RotateAroundAxis(ang:Forward(), dubm[3])

	local dir = ang:Up()

	local st = 0.5

	if ent then
		self.Model = ent.ShellModel
		self.Material = ent.ShellMaterial
		self.Scale = ent.ShellScale
		self.PhysScale = ent.ShellPhysScale or 1
		self.Pitch = ent.ShellPitch or 100
		self.Sounds = ent.ShellSounds or "autocheck"
		self.ShellTime = (ent.ShellTime or self.ShellTime or 0) + st

		if self.Sounds == "autocheck" and ent:GetPrimaryAmmoType() then
			local t = ent:GetPrimaryAmmoType()
			if t == game.GetAmmoID("buckshot") then
				self.Sounds = ShotgunShellSoundsTable
			elseif t == game.GetAmmoID("pistol") then
				self.Sounds = PistolShellSoundsTable
			elseif t == game.GetAmmoID("plinking") then
				self.Sounds = PlinkShellSoundsTable
			elseif t == game.GetAmmoID("ar2") or t == game.GetAmmoID("357") or t == game.GetAmmoID("AlyxGun")  then
				self.Sounds = MediumShellSoundsTable
			else
				self.Sounds = ShellSoundsTable
			end
		end
	end

	self:SetPos(origin)
	self:SetModel(self.Model)
	self:SetModelScale(self.Scale)
	self:DrawShadow(true)
	self:SetAngles(ang)

	if self.Material then
		self:SetMaterial(self.Material)
	end

	local pb_vert = 2 * self.Scale * self.PhysScale
	local pb_hor = 0.5 * self.Scale * self.PhysScale

	self:PhysicsInitBox(Vector(-pb_vert,-pb_hor,-pb_hor), Vector(pb_vert,pb_hor,pb_hor))

	self:SetCollisionGroup(COLLISION_GROUP_INTERACTIVE_DEBRIS)

	local phys = self:GetPhysicsObject()

	local plyvel = Vector(0, 0, 0)

	if IsValid(owner) then
		plyvel = owner:GetAbsVelocity()
	end


	phys:Wake()
	phys:SetDamping(0, 0)
	phys:SetMass(1)
	phys:SetMaterial("gmod_silent")

	phys:SetVelocity((dir * mag * math.Rand(1, 2)) + plyvel)

	phys:AddAngleVelocity(VectorRand(-5000, 5000))
	phys:AddAngleVelocity(ang:Up() * 2500 * math.Rand(0.5, 2))

	self.HitPitch = self.Pitch + math.Rand(-5,5)

	self.emitter = ParticleEmitter( self:GetPos() )

	for i=1, 3 do
		local particle = self.emitter:Add("particles/smokey", self:GetPos() )

		if (particle) then
			particle:SetVelocity( ang:Up()*Lerp(i/3, 20, 80) )
			particle:SetLifeTime( 0 )
			particle:SetDieTime( 1 )
			particle:SetStartAlpha( 12 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( 4 )
			particle:SetEndSize( 3 )
			particle:SetRoll( math.rad( math.Rand( 0, 360 ) ) )
			particle:SetRollDelta( math.Rand( -1, 1 ) )
			particle:SetLighting( true )
			particle:SetAirResistance( 216 )
			particle:SetGravity( Vector( 0, 0, -50 ) )
			particle:SetColor( 140, 140, 140 )
		end
	end

	self.SpawnTime = CurTime()
end

function EFFECT:PhysicsCollide()
	if self.AlreadyPlayedSound and self.JustOnce then return end

	sound.Play(self.Sounds[math.random(#self.Sounds)], self:GetPos(), 65, self.HitPitch, 1)

	self.AlreadyPlayedSound = true

	self:Remove()
end

local lastpoof = 0

function EFFECT:Think()
	if (self.SpawnTime + self.ShellTime) <= CurTime() then
		if !IsValid(self) then return end
		self:SetRenderFX( kRenderFxFadeFast )
		if (self.SpawnTime + self.ShellTime + 1) <= CurTime() then
			if !IsValid(self:GetPhysicsObject()) then return end
			self:GetPhysicsObject():EnableMotion(false)
			if (self.SpawnTime + self.ShellTime + 1.5) <= CurTime() then
				self:Remove()
				return
			end
		end
	end
	
	if (self.SpawnTime+0.5) > CurTime() and lastpoof <= CurTime() then
		for i = 1, 4 do
			local particle = self.emitter:Add("particles/smokey", self:GetPos() )

			local ca = 140
			if (particle) then
				particle:SetVelocity( VectorRand( -10, 10 ) )
				particle:SetLifeTime( 0 )
				particle:SetDieTime( .7 )
				particle:SetStartAlpha( 12 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 2 )
				particle:SetEndSize( 3 )
				particle:SetRoll( math.rad( math.Rand( 0, 360 ) ) )
				particle:SetRollDelta( math.Rand( -1, 1 ) )
				particle:SetLighting( true )
				particle:SetAirResistance( 96 )
				particle:SetGravity( Vector( 0, 0, 40 ) )
				particle:SetColor( ca, ca, ca )
			end
		end
		lastpoof = CurTime() + 0.016
	end

	return true
end

function EFFECT:Render()
	if !IsValid(self) then return end
	self:DrawModel()
end