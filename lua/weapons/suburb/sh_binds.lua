
hook.Add( "StartCommand", "Suburb_StartCommand", function( ply, cmd )
	if ply and IsValid(ply) then
		if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().Suburb then
			ply:SetCanZoom( false )
			local wep = ply:GetActiveWeapon()
			if wep:GetHolster_Time() != 0 and wep:GetHolster_Time() <= CurTime() then
				if IsValid(wep:GetHolster_Entity()) then
					cmd:SelectWeapon(wep:GetHolster_Entity())
				end
			end

			if cmd:KeyDown(IN_ZOOM) then
				if !wep:GetFiremodeDebounce() then
					cmd:SetImpulse(150)
					wep:SetFiremodeDebounce(true)
				end
			else
				wep:SetFiremodeDebounce(false)
			end

			if cmd:GetImpulse() == 100 then
				cmd:SetImpulse(152)
			end

			if cmd:GetImpulse() == 150 then
				wep:SwitchFiremode()
			end

			if cmd:GetImpulse() == 151 then
				wep:ToggleCustomize()
			end

			if cmd:GetImpulse() == 152 then
				if ply.AttachmentRadial then
					ply.AttachmentRadial = false
				else
					ply.AttachmentRadial = true
				end
			end
			if SERVER and ply:FlashlightIsOn() then ply:Flashlight() end
		else
			ply:SetCanZoom( true )
		end
	end
end)

hook.Add( "PlayerBindPress", "Suburb_PlayerBindPress", function( ply, bind, pressed, code )
	if ply and IsValid(ply) then
		if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().Suburb then
			local wep = ply:GetActiveWeapon()
			if bind == "pooper" then
				return true
			end
		end
	end
end)

hook.Add("OnContextMenuOpen", "Suburb_OnContextMenuOpen", function()
	local ply = LocalPlayer()
	local w = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()
	if w and w.Suburb then
		LocalPlayer():ConCommand("impulse 151")
		return true
	end
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