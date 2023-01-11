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
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
	return false
end