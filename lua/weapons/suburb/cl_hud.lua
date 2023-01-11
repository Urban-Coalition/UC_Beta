
local col_1 = Color(255, 255, 255, 200)
local col_2 = Color(0, 0, 0, 200)
local col_3 = Color(255, 127, 127, 255)
local col_4 = Color(255, 222, 222, 255)
local mat_dot = Material("solar/xhair/dot.png", "mips smooth")
local mat_long = Material("solar/xhair/long.png", "mips smooth")
local mat_dot_s = Material("solar/xhair/dot_s.png", "mips smooth")
local mat_long_s = Material("solar/xhair/long_s.png", "mips smooth")
local spacer_long = 2 -- screenscaled
local gap = 0
local size = 16

local function ss(size)
	return size * (ScrH() / 480)
end

function SWEP:DoDrawCrosshair()
	local ply = self:GetOwner()
	
	local s, w, h = ss, ScrW(), ScrH()
	local pl_x, pl_y = w/2, h/2
	local ps_x, ps_y = pl_x, pl_y

	local dispersion = math.rad(self:GetDispersion())
	cam.Start3D()
		local lool = ( EyePos() + ( EyeAngles():Forward() ) + ( dispersion * EyeAngles():Up() ) ):ToScreen()
	cam.End3D()

	local gau = (ScrH()/2)
	gau = ( gau - lool.y )
	gap = gau

	gap = gap + ( self:GetAim() * s(40) )

	local touse1 = col_1
	local touse2 = col_2
	for i=1, 2 do
		local cooler = i == 1 and touse2 or touse1
		local poosx, poosy = i == 1 and ps_x or pl_x, i == 1 and ps_y or pl_y
		local mat1 = i == 1 and mat_long_s or mat_long
		local mat2 = i == 1 and mat_dot_s or mat_dot
		surface.SetDrawColor( cooler.r, cooler.g, cooler.b, cooler.a * ( 1 - self:GetAim() ) )
		if self.XHairMode == "rifle" then
			surface.SetMaterial( mat1 )
			surface.DrawTexturedRectRotated( poosx - s(spacer_long) - gap, poosy, s(16), s(16), 0 )
			surface.DrawTexturedRectRotated( poosx + s(spacer_long) + gap, poosy, s(16), s(16), 0 )

			surface.SetMaterial( mat2 )
			surface.DrawTexturedRectRotated( poosx, poosy - gap, s(16), s(16), 0 )
			surface.DrawTexturedRectRotated( poosx, poosy + gap, s(16), s(16), 0 )
		elseif self.XHairMode == "smg" then
			surface.SetMaterial( mat1 )
			surface.DrawTexturedRectRotated( poosx, poosy + gap + s(spacer_long), s(16), s(16), 90 )
			surface.DrawTexturedRectRotated( poosx - (math.sin(math.rad(45))*gap) - (math.sin(math.rad(45))*s(spacer_long)), poosy - (math.sin(math.rad(45))*gap) - (math.sin(math.rad(45))*s(spacer_long)), s(16), s(16), -45 )
			surface.DrawTexturedRectRotated( poosx + (math.sin(math.rad(45))*gap) + (math.sin(math.rad(45))*s(spacer_long)), poosy - (math.sin(math.rad(45))*gap) - (math.sin(math.rad(45))*s(spacer_long)), s(16), s(16), 45 )

			surface.SetMaterial( mat2 )
			surface.DrawTexturedRectRotated( poosx, poosy, s(16), s(16), 0 )
		else -- pistol
			surface.SetMaterial( mat2 )
			surface.DrawTexturedRectRotated( poosx - gap, poosy, s(size), s(size), 0 )
			surface.DrawTexturedRectRotated( poosx + gap, poosy, s(size), s(size), 0 )

			surface.SetMaterial( mat2 )
			surface.DrawTexturedRectRotated( poosx, poosy - gap, s(size), s(size), 0 )
			surface.DrawTexturedRectRotated( poosx, poosy + gap, s(size), s(size), 0 )
		end
	end
	return true
end



local c1 = Color(255, 255, 255)
function SWEP:DrawHUD()
	if GetConVar("developer"):GetBool() then
		surface.SetDrawColor( c1 )
		surface.SetTextColor( c1 )
		surface.SetFont("Trebuchet18")

		surface.SetTextPos( 64 + 4, (64) - 18 - 2 )
		surface.DrawText("ReloadingTime")
		surface.DrawRect( 64, 64, ( self:GetReloadingTime() - CurTime() ) * 100, 8 )

		surface.SetTextPos( 64 + 4, (64+(48*1)) - 18 - 2 )
		surface.DrawText("LoadIn")
		surface.DrawRect( 64, (64+(48*1)), ( self:GetLoadIn() - CurTime() ) * 100, 8 )

		surface.SetTextPos( 64 + 4, (64+(48*2)) - 18 - 2 )
		surface.DrawText("Fire")
		surface.DrawRect( 64, (64+(48*2)), ( self:GetNextFire() - CurTime() ) * 100, 8 )

		surface.SetTextPos( 64 + 4, (64+(48*3)) - 18 - 2 )
		surface.DrawText("IdleIn")
		surface.DrawRect( 64, (64+(48*3)), ( self:GetIdleIn() - CurTime() ) * 100, 8 )

		for i, v in pairs(self.Attachments) do
			if i == "BaseClass" then continue end
			local x, y = ScrW()/2, (64+(48*(i-1)))
			surface.SetTextPos( x, y )
			surface.DrawText( i .. ": " .. v.Name )
			surface.SetTextPos( x + 16, y + 16 )
			surface.DrawText( "- " .. (v.Installed or "none") )
		end
	end
end