function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local wpn = data:GetEntity()

	if !IsValid(wpn) then return end

	local muzzle = wpn.MuzzleEffect

	local att = data:GetAttachment() or 1

	local Owner = wpn:GetOwner()
	if Owner != LocalPlayer() then
	    return
	end

	local mdl = LocalPlayer():GetViewModel()
	if !IsValid(mdl) then return end

	pos = (mdl:GetAttachment(att) or {}).Pos
	ang = (mdl:GetAttachment(att) or {}).Ang

	if muzzle then
		ParticleEffectAttach(muzzle, PATTACH_POINT_FOLLOW, mdl, att)
	end

	if !pos then return end

	local light = DynamicLight(self:EntIndex())
	local clr = Color(244, 209, 66)
	if (light) then
		light.Pos = pos
		light.r = clr.r
		light.g = clr.g
		light.b = clr.b
		light.Brightness = 2
		light.Decay = 2500
		light.Size = Owner == LocalPlayer() and 256 or 128
		light.DieTime = CurTime() + 0.1
	end
	
	local emitter = ParticleEmitter(pos)
	if true then -- distort
		local particle = emitter:Add("sprites/heatwave", pos)

		if particle then
			particle:SetVelocity( ang:Forward() )
			particle:SetLifeTime( 0 )
			particle:SetDieTime( 2/24 )
			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.random( 12, 36 ) )
			particle:SetEndSize( 0 )
			particle:SetRoll(math.Rand(0, 360))
			particle:SetRollDelta(math.Rand(-2, 2))
			particle:SetAirResistance( 0 )
			particle:SetGravity( Vector(0, 0, 40) )
			particle:SetColor( 255, 255, 255 )
		end
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end