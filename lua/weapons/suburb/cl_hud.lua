
local col_1 = Color(255, 255, 255, 200)
local col_2 = Color(0, 0, 0, 200)
local col_3 = Color(255, 127, 127, 255)
local col_4 = Color(255, 222, 222, 255)
local mat_dot = Material("solar/xhair/dot.png", "mips smooth")
local mat_long = Material("solar/xhair/long.png", "mips smooth")
local mat_dot_s = Material("solar/xhair/dot_s.png", "mips smooth")
local mat_long_s = Material("solar/xhair/long_s.png", "mips smooth")
local clm = {
	[5] = {},
	[10] = {},
	[15] = {},
	[20] = {},
	[25] = {},
	[30] = {},
}
for size, data in pairs(clm) do
	data.a = Material("solar/xhair/clump_" .. size .. ".png", "mips smooth")
	data.b = Material("solar/xhair/clump_" .. size .. "_s.png", "mips smooth")
end
local spacer_long = 2 -- screenscaled
local gap = 0
local size = 16

local function ss(size)
	return size * (ScrH() / 480)
end

function SWEP:DoDrawCrosshair()
	local ply = self:GetOwner()
	
	local s, w, h = ss, ScrW(), ScrH()

	local tr = util.TraceLine({
		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():EyePos() + (LocalPlayer():EyeAngles():Forward() * 8192 * 4),
		filter = LocalPlayer(),
		ignoreworld = true,
	})
	tr = tr.HitPos:ToScreen()
	local tw, th = tr.x, tr.y

	local pl_x, pl_y = tw, th--w/2, h/2
	local ps_x, ps_y = pl_x, pl_y

	local dispersion = math.rad(self:GetDispersion())
	local accuracy = math.rad(self:GetStat("Accuracy"))
	cam.Start3D()
		local lool = ( EyePos() + ( EyeAngles():Forward() * 8192 * 4 ) + ( dispersion * EyeAngles():Up() * 8192 * 4 ) ):ToScreen()
		local lool2 = ( EyePos() + ( EyeAngles():Forward() * 8192 * 4 ) + ( accuracy * EyeAngles():Up() * 8192 * 4 ) ):ToScreen()
	cam.End3D()

	local gap = (ScrH()/2)
	gap = ( gap - lool.y )

	local gap_a = (ScrH()/2)
	gap_a = ( gap_a - lool2.y )

	if SDe()>0 then
		local tr = {
			start = LocalPlayer():EyePos(),
			filter = LocalPlayer(),
			ignoreworld = true,
		}
		tr.endpos = LocalPlayer():EyePos() + (LocalPlayer():EyeAngles():Forward() * 8192) + (LocalPlayer():EyeAngles():Right() * 8192 * -4)
		local tr_l = util.TraceLine(tr).HitPos:ToScreen()
		local l_tw, l_th = tr_l.x, tr_l.y

		tr.endpos = LocalPlayer():EyePos() + (LocalPlayer():EyeAngles():Forward() * 8192) + (LocalPlayer():EyeAngles():Right() * 8192 * 4)
		local tr_r = util.TraceLine(tr).HitPos:ToScreen()
		local r_tw, r_th = tr_r.x, tr_r.y

		tr.endpos = LocalPlayer():EyePos() + (LocalPlayer():EyeAngles():Forward() * 8192) + (LocalPlayer():EyeAngles():Up() * 8192 * 4)
		local tr_u = util.TraceLine(tr).HitPos:ToScreen()
		local u_tw, u_th = tr_u.x, tr_u.y
		
		tr.endpos = LocalPlayer():EyePos() + (LocalPlayer():EyeAngles():Forward() * 8192) + (LocalPlayer():EyeAngles():Up() * 8192 * -4)
		local tr_d = util.TraceLine(tr).HitPos:ToScreen()
		local d_tw, d_th = tr_d.x, tr_d.y

		surface.SetDrawColor( 255, 0, 0 )
		surface.DrawLine( l_tw, l_th, r_tw, r_th )
		surface.DrawLine( u_tw, u_th, d_tw, d_th )
		surface.DrawCircle( tw, th, gap, 255, 255, 255, 255 )
		surface.DrawCircle( tw, th, gap_a, 0, 255, 255, 255 )
	end

	local touse1 = GetConVar("uc_x_col"):GetString()
	touse1 = string.Explode( " ", touse1 )
	touse1 = Color( touse1[1], touse1[2], touse1[3] )
	local touse2 = GetConVar("uc_x_col_shad"):GetString()
	touse2 = string.Explode( " ", touse2 )
	touse2 = Color( touse2[1], touse2[2], touse2[3] )
	for i=1, 2 do
		local f = i==1
		local cooler = f and touse2 or touse1
		local poosx, poosy = f and ps_x or pl_x, f and ps_y or pl_y
		local mat1 = f and mat_long_s or mat_long
		local mat2 = f and mat_dot_s or mat_dot
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

			local mat3
			local maka = 14
			local statty = math.Remap( gap_a/ScrH(), 0, 0.05, 0, 1 )
			statty = math.Clamp( statty, 0, 1 )
			if		statty > (6/7) then
				mat3 = f and clm[5].b or clm[5].a
			elseif	statty > (5/7) then
				mat3 = f and clm[10].b or clm[10].a
			elseif	statty > (4/7) then
				mat3 = f and clm[15].b or clm[15].a
			elseif	statty > (3/7) then
				mat3 = f and clm[20].b or clm[20].a
			elseif	statty > (2/7) then
				mat3 = f and clm[25].b or clm[25].a
			else -- if	statty > (1/7) then
				mat3 = f and clm[30].b or clm[30].a
			end
			surface.SetMaterial( mat3 )
			surface.SetDrawColor( cooler.r, cooler.g, cooler.b, cooler.a * ( 1 - self:GetAim() ) * (1/10) )
			surface.DrawTexturedRectRotated( poosx, poosy, s(gap_a*2), s(gap_a*2), 0 )
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

	if SDe()>0 then
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

	if false then -- REMOVE IN THE FUTURE
		surface.SetDrawColor( 0, 0, 0, 255 )
		local sx, sy = 10, 10
		local zx, zy = 800, 400

		for i=1, 5 do
			bwah = (1/i) * 200
			surface.SetDrawColor( bwah, bwah, bwah, 127 )
			surface.DrawRect( sx, math.Round(sy + (zy * ((i-1)/i)), 0), zx, math.Round(zy * (1/i), 0) )
		end

		for i=1, 5 do
			surface.SetFont( "TargetID" )
			surface.SetTextColor( 255, 255, 255, 127 )
			surface.SetTextPos( sx + 4, math.Round(sy + (zy * ((i-1)/i)), 0) + 4 )
			surface.DrawText( i+1 )
		end
	end
end