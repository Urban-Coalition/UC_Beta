
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

local s = ScreenScale
surface.CreateFont( "SolarI_1", { font = "FOT-Rodin Pro DB", size = s(10), weight = 0 } )
surface.CreateFont( "SolarIG_1", { font = "FOT-Rodin Pro DB", size = s(10), weight = 0, blursize = 1 } )
surface.CreateFont( "SolarI_2", { font = "Consolas", size = s(9), weight = 0 } )
surface.CreateFont( "SolarIG_2", { font = "Consolas", size = s(9), weight = 0, blursize = 1 } )
surface.CreateFont( "SolarI_3", { font = "FOT-Rodin Pro DB", size = s(8), weight = 0 } )

local c1 = Color(255, 255, 255)

local cw = Color( 224, 240, 245, 255 )
local cs = Color( 25, 62, 77, 255 )
local cs_h = Color( 25, 62, 77, 127 )
local cs2 = Color( 43, 79, 92, 255 )
local cs2_h = Color( 43, 79, 92, 127 )


local grad_up = Material( "solar/gradient_up.png", "")
local grad_down = Material( "solar/gradient_down.png", "")
local grad_left = Material( "solar/gradient_left.png", "")
local grad_right = Material( "solar/gradient_right.png", "")

local items = {
	{
		Name = "SWITCH TO ALTERNATIVE",
	},
	{
		Name = "THERMAL SIGHT",
		Options = {
			"WHOT",
			"BHOT",
			"OFF",
		},
	},
	{
		Name = "COMBO MODULE",
		Options = {
			"LASER + LIGHT",
			"LASER",
			"LIGHT",
			"OFF",
		},
	},
	{
		Name = "GRENADE LAUNCHER",
		Options = {
			"HIGH EXPLOSIVE",
			"BUCKSHOT",
			"SMOKE",
		},
	},
	{
		Name = "STOCK",
		Options = {
			"EXTENDED",
			"COLLAPSED",
		},
	},
}

function SWEP:DrawHUD()
	if false then -- Attachment toggle select
		local x, y = ScrW()/2, ScrH()/2

		local interval = 360/#items
		for i, item in ipairs(items) do
			local de = 0 - ( i * interval ) + interval
			de = math.rad( de + 180 )
			local dist = s( Lerp( math.TimeFraction( 3, 8, #items ), 50, 90 ) )
			local ox, oy = math.sin( de ) * dist * 1.8, math.cos( de ) * dist
			local rx, ry = x + ox, y + oy

			--surface.SetDrawColor( color_white )
			--surface.DrawLine( x, y, rx, ry )
			
			local bx, by = s( 110 ), s( 12 )
			local shad = s( 1 )

			local r2x, r2y = rx - (bx/2), ry - (by/2)

			surface.SetMaterial( grad_up )
			surface.SetDrawColor( cs_h )
			surface.DrawTexturedRect( r2x, r2y, bx + shad, by + shad )

			surface.SetDrawColor( cs2 )
			surface.DrawRect( r2x, r2y, bx, by )

			surface.SetMaterial( grad_up )
			surface.SetDrawColor( cs )
			surface.DrawTexturedRect( r2x, r2y + (by/2), bx, by/2 )

			for e=1, 3 do
				draw.Text( {
					text = item.Name or "no name??",
					font = e != 3 and "SolarIG_1" or "SolarI_1",
					color = e != 3 and cs2 or cw,
					pos = { rx, ry + s( (e == 1 and 0.5) or (e == 2 and -0.1) or 0) },
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				} )
			end
				
			if item.Options then for h, k in ipairs(item.Options) do
				surface.SetFont("SolarI_2")
				local tx = surface.GetTextSize(k)
				surface.SetMaterial( grad_up )
				surface.SetDrawColor( cs_h )
				surface.DrawTexturedRect( rx - (tx/2) - s(2), ry + s(6) + s( (h-1) * 9 ), tx + s(4), s(10) )

				for i=1, 3 do
					draw.Text( {
						text = k,
						font = i != 3 and "SolarIG_2" or "SolarI_2",
						color = i != 3 and cs2 or cw,
						pos = { rx, ry + s(11) + s( (i == 1 and 0.5) or (i == 2 and -0.1) or 0) + s( (h-1) * 9 ) },
						xalign = TEXT_ALIGN_CENTER,
						yalign = TEXT_ALIGN_CENTER,
					} )
				end
			end

			for e=1, 3 do
				draw.Text( {
					text = tostring(i),
					font = e != 3 and "SolarIG_1" or "SolarI_1",
					color = e != 3 and cs2 or cw,
					pos = { r2x + s(2), ry - s(8) + s( (e == 1 and 0.5) or (e == 2 and -0.1) or 0) },
					xalign = TEXT_ALIGN_LEFT,
					yalign = TEXT_ALIGN_BOTTOM,
				} )
			end
		end end
	end

	if GetConVar("developer"):GetBool() then
		surface.SetDrawColor( c1 )
		surface.SetTextColor( c1 )
		surface.SetFont("Trebuchet18")

		local xa = ScrW()*0.1
		surface.SetTextPos( xa + 4, (64) - 18 - 2 )
		surface.DrawText("ReloadingTime")
		surface.DrawRect( xa, 64, ( self:GetReloadingTime() - CurTime() ) * 100, 8 )

		surface.SetTextPos( xa + 4, (64+(48*1)) - 18 - 2 )
		surface.DrawText("LoadIn")
		surface.DrawRect( xa, (64+(48*1)), ( self:GetLoadIn() - CurTime() ) * 100, 8 )

		surface.SetTextPos( xa + 4, (64+(48*2)) - 18 - 2 )
		surface.DrawText("Fire")
		surface.DrawRect( xa, (64+(48*2)), ( self:GetNextFire() - CurTime() ) * 100, 8 )

		surface.SetTextPos( xa + 4, (64+(48*3)) - 18 - 2 )
		surface.DrawText("IdleIn")
		surface.DrawRect( xa, (64+(48*3)), ( self:GetIdleIn() - CurTime() ) * 100, 8 )

		for i, v in pairs(self.Attachments) do
			if i == "BaseClass" then continue end
			local x, y = ScrW()*0.8, (64+(48*(i-1)))
			surface.SetTextPos( x, y )
			surface.DrawText( i .. ": " .. v.Name )
			surface.SetTextPos( x + 16, y + 16 )
			surface.DrawText( "- " .. (v.Installed or "none") )
		end
	end
end