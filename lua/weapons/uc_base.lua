
SWEP.Base = "weapon_base"
SWEP.PrintName = "Testing Weapon"
SWEP.Spawnable = true
SWEP.Category = "Urban Coalition"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true
SWEP.ViewModelFOV = 54

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Ammo = "none"
SWEP.Primary.Automatic = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = true

local yep = {
	[""] = {},
}

function SWEP:SetupNetworkVars()
	for i, v in pairs(yep) do
		for k, p in ipairs() do
		end
	end
end

function SWEP:PrimaryAttack()
	return true
end

function SWEP:SecondaryAttack()
	return true
end