
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

		if cmd:GetImpulse() == 151 then
			wep:ToggleCustomize()
		end
	end
end)

hook.Add("OnContextMenuOpen", "Suburb_OnContextMenuOpen", function()
	LocalPlayer():ConCommand("impulse 151")
	return true
end)

function SWEP:ToggleCustomize()
	if SuburbCustDerma then SuburbCustDerma:Remove() end
	if self:GetCustomizing() then
		self:SetCustomizing( false )
	else
		self:SetCustomizing( true )
		self:GetOwner():ConCommand("newurb_menu")
	end
end