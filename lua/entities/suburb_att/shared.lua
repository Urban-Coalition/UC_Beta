AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.RenderGroup = RENDERGROUP_VIEWMODEL
ENT.RenderMode = RENDERMODE_ENVIROMENTAL

function ENT:Initialize()
	print( tostring(self) .. " initialized" )

	self:DrawShadow(false)
	self:SetRenderMode(self.RenderMode)

	self:DestroyShadow()
end