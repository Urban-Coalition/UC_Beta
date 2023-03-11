
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

local s = function( size )
	return math.Round( size * ( ScrH() / 480 ) )
end
surface.CreateFont( "SolarI_1", { font = "FOT-Rodin Pro DB", size = s(18), weight = 0 } )
surface.CreateFont( "SolarIG_1", { font = "FOT-Rodin Pro DB", size = s(18), weight = 0, blursize = 1 } )
surface.CreateFont( "SolarI_2", { font = "Consolas", size = s(14), weight = 0 } )
surface.CreateFont( "SolarIG_2", { font = "Consolas", size = s(14), weight = 0, blursize = 1 } )
surface.CreateFont( "SolarI_5", { font = "FOT-Rodin Pro DB", size = s(14), weight = 0 } )
surface.CreateFont( "SolarIG_5", { font = "FOT-Rodin Pro DB", size = s(14), weight = 0, blursize = 1 } )
surface.CreateFont( "SolarI_6", { font = "Trebuchet MS", size = s(14), weight = 600 } )


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
		Name = "Alt. Weapon",
	},
	{
		Name = "Thermal Sight",
		Options = {
			"WHOT",
			"BHOT",
			"OFF",
		},
	},
	{
		Name = "Combo Module",
		Options = {
			"LASER + LIGHT",
			"LASER",
			"LIGHT",
			"OFF",
		},
	},
	{
		Name = "Grenade Launcher",
		Options = {
			"HIGH EXPLOSIVE",
			"BUCKSHOT",
			"SMOKE",
		},
	},
	{
		Name = "Stock",
		Options = {
			"EXTENDED",
			"COLLAPSED",
		},
	},
}

local hints = {
	{
		Action = "Switch to Alternative",
		Combo = {
			{ "E" }
		},
	},
	{
		Action = "Switch Firemodes",
		Combo = {
			{ "X" },
		},
	},
	{
		Action = "Attachment Radial",
		Combo = {
			{ "F" },
		},
	},
	{
		Action = "Customize",
		Combo = {
			{ "C" },
		},
	},
}

function SWEP:DrawHUD()
	local sw, sh = ScrW(), ScrH()
	local x, y = sw/2, sh/2
	if LocalPlayer().AttachmentRadial then -- Attachment toggle select
		local interval = 360/#items
		for i, item in ipairs(items) do
			local de = 0 - ( i * interval ) + interval
			de = math.rad( de + 180 )
			local dist = s( Lerp( math.TimeFraction( 3, 6, #items ), 60, 100 ) )
			local ox, oy = math.sin( de ) * dist * 1.8, math.cos( de ) * dist
			local rx, ry = x + ox, y + oy
			local bx, by = s( 180 ), s( 18 )
			local r2x, r2y = rx - (bx/2), ry - (by/2)

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

			for e=1, 3 do
				draw.Text( {
					text = tostring(i),
					font = e != 3 and "SolarIG_1" or "SolarI_1",
					color = e != 3 and cs2 or cw,
					pos = { r2x + s(2), ry - s(10) + s( (e == 1 and 0.5) or (e == 2 and -0.1) or 0) },
					xalign = TEXT_ALIGN_LEFT,
					yalign = TEXT_ALIGN_BOTTOM,
				} )
			end
				
			if item.Options then
				for h, k in ipairs(item.Options) do
					surface.SetFont("SolarI_2")
					local tx = surface.GetTextSize(k)
					surface.SetMaterial( grad_up )
					surface.SetDrawColor( cs_h )
					surface.DrawTexturedRect( rx - (tx/2) - s(4), ry + s(12) + s( (h-1) * 12 ), tx + s(8), s(11) )

					for i=1, 3 do
						draw.Text( {
							text = k,
							font = i != 3 and "SolarIG_2" or "SolarI_2",
							color = i != 3 and cs2 or cw,
							pos = { rx, ry + s(17) + s( (i == 1 and 0.5) or (i == 2 and -0.1) or 0) + s( (h-1) * 12 ) },
							xalign = TEXT_ALIGN_CENTER,
							yalign = TEXT_ALIGN_CENTER,
						} )
					end
				end
			end

		end
	end

	if false then -- Hint system
		local bx, by = s( 180 ), s( 18 )
		local shad = s( 1 )
		local cx = s( 4 )
		local ms = s( 12 )
		
		local offset = 0
		for i, item in ipairs(hints) do
			surface.SetDrawColor( cs2 )
			surface.DrawRect( cx, cx + offset, bx, by )

			surface.SetMaterial( grad_up )
			surface.SetDrawColor( cs )
			surface.DrawTexturedRect( cx, cx + (by/2) + offset, bx, by/2 )
			
			for e=1, 3 do
				draw.Text( {
					text = item.Action,
					font = e != 3 and "SolarIG_5" or "SolarI_5",
					color = e != 3 and cs2 or cw,
					pos = { cx + s(4), cx + offset + (by/2) + s( (e == 1 and 0.5) or (e == 2 and -0.1) or 0) },
					xalign = TEXT_ALIGN_LEFT,
					yalign = TEXT_ALIGN_CENTER,
				} )
			end
			
			local o1x = bx-s(8)
			local knot = s(10)
			local kisser = (#item.Combo-1)*knot*-1
			for g, combo in ipairs(item.Combo) do
				surface.SetDrawColor( cw )
				local msw = ms
				if combo.calc then
					surface.SetFont( "SolarI_6" )
					msw = surface.GetTextSize( combo[1] ) + s(2)
				end
				surface.DrawOutlinedRect( cx + o1x + kisser - (msw/2), offset + (by/2) + cx - (ms/2), msw, ms )
				draw.Text( {
					text = combo[1],
					font = "SolarI_6",
					color = cw,
					pos = { cx + o1x + kisser, offset + (by/2) + cx },
					xalign = TEXT_ALIGN_CENTER,
					yalign = TEXT_ALIGN_CENTER,
				} )
				o1x = o1x + knot
			end

			offset = offset + by+cx
		end
	end

	if false and self:GetAim() > 0 then
		render.RenderView( {
			origin = EyePos(),
			angles = EyeAngles(),
			x = (sw-sh)/2, y = 0,
			w = sh, h = ScrH(),
			aspect = 1,
			fov = 90,
			drawviewmodel = false,
		} )
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

		surface.SetTextPos( xa + 4, (64+(48*4)) - 18 - 2 )
		surface.DrawText("ShotgunReloadingTime")
		surface.DrawRect( xa, (64+(48*4)), ( self:GetShotgunReloadingTime() - CurTime() ) * 100, 8 )

		surface.SetTextPos( xa + 4, (64+(48*5)) - 18 - 2 )
		surface.DrawText("ShotgunReloading")
		surface.DrawRect( xa, (64+(48*5)), ( self:GetShotgunReloading() and 1 or 0 ) * 100, 8 )

		surface.SetTextPos( xa + 4, (64+(48*6)) - 18 - 2 )
		surface.DrawText("CycleCount")
		surface.DrawRect( xa, (64+(48*6)), ( self:GetCycleCount() ) * 100, 8 )

		surface.SetTextPos( xa + 4, (64+(48*7)) - 18 - 2 )
		surface.DrawText("CycleDelayTime")
		surface.DrawRect( xa, (64+(48*7)), ( self:GetCycleDelayTime() - CurTime() ) * 100, 8 )

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