
-- Made by Fesiug!

CreateClientConVar("newurb_enabled", 0)

local test1 = Material( "solar/gradient_up.png", "")
local test2 = Material( "solar/gradient_down.png", "")
local test3 = Material( "gui/center_gradient", "")

local cw = Color( 224, 240, 245, 255 )
local cs = Color( 25, 62, 77, 127 )
local cs2 = Color( 39, 73, 85, 255 )

local globalweed = 7
local globalweed2 = 2
local globalweed3 = 5

surface.CreateFont( "Solar_A_1", { font = "Consolas", size = 30, weight = 1000 } )
surface.CreateFont( "Solar_A_2", { font = "FOT-Rodin Pro DB", size = 43, weight = 0 } )
surface.CreateFont( "Solar_A_3", { font = "FOT-Rodin Pro DB", size = 26, weight = 0 } )
surface.CreateFont( "Solar_A_4", { font = "FOT-Rodin Pro DB", size = 60, weight = 0 } )
surface.CreateFont( "Solar_A_5", { font = "FOT-Rodin Pro DB", size = 22, weight = 0 } )
surface.CreateFont( "Solar_B_1", { font = "Carbon Bold", size = 120, weight = 0 } )
surface.CreateFont( "Solar_B_2", { font = "Carbon Bold", size = 70, weight = 0 } )
surface.CreateFont( "Solar_C_1", { font = "Consolas", size = 32, weight = 0 } )
surface.CreateFont( "Solar_C_2", { font = "Consolas", size = 20, weight = 0 } )

local moves = {}
moves.fix = Angle( 90, -90, 0 )
moves.health = {}
moves.health.func = function( data ) ------------------------------------------------
	if GetConVar("newurb_enabled"):GetBool() then
	local extra = 20

	local potal = Vector()
	potal:Add( moves.health.pos )
	data.pos:Add( potal.x * ( data.eang:Right() ) )
	data.pos:Add( potal.y * ( data.eang:Forward() ) )
	data.pos:Add( potal.z * ( data.eang:Up() ) )

	local total = Angle()
	total:Set( moves.health.ang )
	data.ang:RotateAroundAxis( data.ang:Up(), total.y )
	data.ang:RotateAroundAxis( data.ang:Right(), total.r )
	data.ang:RotateAroundAxis( data.ang:Forward(), total.p )

	local weed = (data.ang:Up() * globalweed)

	for b=1, 2 do
		if data.p:Armor() == 0 and b==2 then continue end
		cam.Start3D2D( data.pos, data.ang, 0.1 )
			surface.SetMaterial( test2 )
			surface.SetDrawColor( cs2 )
			surface.DrawTexturedRect( (b==2 and 350 or 0), 0, 300, 180 )
		cam.End3D2D()

		for i=1, 2 do
			cam.Start3D2D( data.pos + ( weed * (i/2) ), data.ang, 0.1 )
				local col = i == 1 and cs or cw
				draw.DrawText(
					b==2 and "AP" or "HP",
					"Solar_A_1",
					260 + (b==2 and 350 or 0),
					80+extra,
					col,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
				draw.DrawText(
					b==2 and data.p:Armor() or data.p:Health(),
					"Solar_B_1",
					260 + (b==2 and 350 or 0),
					10+extra,
					col,
					TEXT_ALIGN_RIGHT,
					TEXT_ALIGN_TOP
				)
				surface.SetDrawColor( col )
				surface.DrawRect( 20 + (b==2 and 350 or 0) + 40, 140, 200 * (i==1 and 1 or (b==2 and (data.p:Armor()/data.p:GetMaxArmor()) or (data.p:Health()/data.p:GetMaxHealth()))), 10 )
				surface.DrawRect( 20 + (b==2 and 350 or 0) - 6 + 40, 140, 3, 10 )
				surface.DrawRect( 20 + (b==2 and 350 or 0) + 200 + 3 + 40, 140, 3, 10 )
			cam.End3D2D()
		end
		end
	end
end ------------------------------------------------
moves.health.pos = Vector( -105, 300, -45 )
moves.health.ang = Angle( -20, 0, 0 )

moves.ammo = {}
moves.ammo.func = function( data ) ------------------------------------------------
	if GetConVar("newurb_enabled"):GetBool() then
	local w_clip = false
	local w_ammo = false
	local extra = 20

	local w = data.p:GetActiveWeapon()
	if IsValid(w) then
		if w:Clip1() >= 0 then
			w_clip = w:Clip1()
		end
		if w:GetPrimaryAmmoType() >= 0 then
			w_ammo = data.p:GetAmmoCount( w:GetPrimaryAmmoType() )
		end
	else
		w = false
	end

	local potal = Vector()
	potal:Add( moves.ammo.pos )
	data.pos:Add( potal.x * ( data.eang:Right() ) )
	data.pos:Add( potal.y * ( data.eang:Forward() ) )
	data.pos:Add( potal.z * ( data.eang:Up() ) )

	local total = Angle()
	total:Set( moves.ammo.ang )
	data.ang:RotateAroundAxis( data.ang:Up(), total.y )
	data.ang:RotateAroundAxis( data.ang:Right(), total.r )
	data.ang:RotateAroundAxis( data.ang:Forward(), total.p )

	local weed = (data.ang:Up() * globalweed)
	local fuck = vector_origin--(data.ang:Up() * (math.ease.OutCubic(math.ease.OutBounce((CurTime()%1)))*7))

	if w and w_clip then
		cam.Start3D2D( data.pos, data.ang, 0.1 )
			surface.SetMaterial( test2 )
			surface.SetDrawColor( cs2 )
			surface.DrawTexturedRect( 0, 0, 450, 180 )
		cam.End3D2D()

		for i=1, 2 do
			local col = i == 1 and cs or cw
			cam.Start3D2D( data.pos + ( weed * (i/2) ), data.ang, 0.1 )
				draw.DrawText(
					w_clip,
					"Solar_B_1",
					220,
					10+extra,
					col,
					TEXT_ALIGN_RIGHT,
					TEXT_ALIGN_TOP
				)
				draw.DrawText(
					string.upper( w.GetFiremodeName and w:GetFiremodeName() or "" ),
					"Solar_A_1",
					224,
					80+extra,
					col,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
				draw.DrawText(
					w_ammo,
					"Solar_B_2",
					220,
					18+extra,
					col,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
			cam.End3D2D()
		end
	end
	end
end ------------------------------------------------
moves.ammo.pos = Vector( 95 - (350*0.1), 300, -45 )
moves.ammo.ang = Angle( -20, 0, 0 )

local papi1 = {
	--[[{
		["Title"] = "REAR SIGHT",
		["Subtitle"] = "Optical device that draws the user's sight.",
		["Subtitle2"] = "Integrated Carry Handle",
		["SortOrder"] = 1,
		["Icon"] = Material("entities/att/acwatt_ud_m16_rs_kac.png", "mips smooth")
	},
	{
		["Title"] = "OPTICAL SIGHT",
		["Subtitle"] = "Optical device that draws the user's sight.",
		["Subtitle2"] = "Integrated Carry Handle",
		["SortOrder"] = 1.5,
		["Icon"] = Material("entities/att/acwatt_uc_optic_comp_m2.png", "mips smooth")
	},
	{
		["Title"] = "FRONT SIGHT",
		["Subtitle"] = "Post used to create a line of aim and align the weapon.",
		["Subtitle2"] = "Integrated Front Sight",
		["SortOrder"] = 2,
		["Icon"] = Material("entities/att/acwatt_ud_m16_fs_kac.png", "mips smooth")
	},
	{
		["Title"] = "BARREL",
		["Subtitle"] = "The length of the barrel enhances the range of the projectile.",
		["Subtitle2"] = "20\" Standard Barrel",
		["SortOrder"] = 3,
		["Icon"] = Material("entities/att/acwatt_ud_m16_barrel_20.png", "mips smooth")
	},
	{
		["Title"] = "HANDGUARD",
		["Subtitle"] = "The part you hold on to.",
		["Subtitle2"] = "Standard Ribbed Handguard",
		["SortOrder"] = 4,
		["Icon"] = Material("entities/att/acwatt_ud_m16_hg_ribbed.png", "mips smooth")
	},
	{
		["Title"] = "MUZZLE",
		["Subtitle"] = "Attach a variety of brakes, flash hiders and suppressors.",
		["Subtitle2"] = "Standard Flash Hider",
		["SortOrder"] = 5,
		["Icon"] = Material("entities/att/acwatt_uc_muzzle_fhider1.png", "mips smooth")
	},
	{
		["Title"] = "UPPER RECEIVER",
		["Subtitle"] = "Contains the bolt carrier group.",
		["Subtitle2"] = "Standard 5.56mm Upper",
		["SortOrder"] = 6,
		["Icon"] = Material("entities/att/acwatt_ud_m16_receiver_auto.png", "mips smooth")
	},
	{
		["Title"] = "LOWER RECEIVER",
		["Subtitle"] = "Contains the trigger group and hammer.",
		["Subtitle2"] = "Standard Burst Lower",
		["SortOrder"] = 7,
		["Icon"] = Material("entities/att/acwatt_ud_m16_receiver_default.png", "mips smooth")
	},
	{
		["Title"] = "UNDERBARREL",
		["Subtitle"] = "Attach a variety of foregrips and underslung weapons.",
		["Subtitle2"] = "None",
		["SortOrder"] = 8,
		["Icon"] = Material("entities/att/acwatt_uc_grip_kacvfg.png", "mips smooth")
	},]]
}
local puss = {}
pusx, pusy = 0, 0
local chingas = 720
local selected1 = 1
local lastcurtime1 = 0
local letsgo = 0
moves.test1 = {}
moves.test1.func = function( data ) ------------------------------------------------
	local w = data.p:GetActiveWeapon()
	if IsValid(w) and w.Suburb and w:GetCustomizing() then
	local extra = 75

	local potal = Vector()
	potal:Add( moves.test1.pos )
	data.pos:Add( potal.x * ( data.eang:Right() ) )
	data.pos:Add( potal.y * ( data.eang:Forward() ) )
	data.pos:Add( potal.z * ( data.eang:Up() ) )

	local total = Angle()
	total:Set( moves.test1.ang )
	--	total:Add( Angle( 0, 0, math.sin(CurTime()*2)*5 ) )
	data.ang:RotateAroundAxis( data.ang:Up(), total.y )
	data.ang:RotateAroundAxis( data.ang:Right(), total.r )
	data.ang:RotateAroundAxis( data.ang:Forward(), total.p )

	local weedx = ( data.ang:Right() * 1 )
	local weedy = ( data.ang:Forward() * 1 )
	local weed1 = ( data.ang:Up() * globalweed2 )
	local weed2 = ( data.ang:Up() * globalweed3 )

	cam.Start3D2D( data.pos, data.ang, 0.1 )
		surface.SetMaterial( test2 )
		surface.SetDrawColor( cs2 )
		surface.DrawTexturedRectRotated( chingas/2, chingas/2, chingas, chingas, 90 )
	cam.End3D2D()

	if letsgo > -1 then
		letsgo = math.Approach(letsgo, 1, FrameTime()/0.5)
	end
	if letsgo == 1 then
		letsgo = -1
	end

	local gaap = 70
	local ifuckinghateyou = {}
	for i, v in SortedPairsByMemberValue( w.Attachments, "SortOrder", false ) do
		if i == "BaseClass" then continue end
		local item = {
			Title = string.upper( v.Name ),
			Subtitle = "null",
			Icon = Material("entities/arccw_ud_glock.png", "mips smooth"),
			oslot = v
		}
		table.insert( ifuckinghateyou, i, item )
	end

	--[[if game.SinglePlayer() or (!game.SinglePlayer() and IsFirstTimePredicted()) then
		if data.p:KeyPressed( IN_FORWARD ) then
			selected1 = selected1 - 1
			if selected1 <= 0 then
				selected1 = #ifuckinghateyou
			end
		elseif data.p:KeyPressed( IN_BACK ) then
			selected1 = selected1 + 1
			if selected1 > #ifuckinghateyou then
				selected1 = 1
			end
		end
	
		if data.p:KeyPressed( IN_FORWARD ) or data.p:KeyPressed( IN_BACK ) then
			data.p:EmitSound("garrysmod/ui_hover.wav", nil, 100, 0.5)
		elseif data.p:KeyPressed( IN_ATTACK ) then
			data.p:EmitSound("garrysmod/content_downloaded.wav", nil, 95, 0.5)
		elseif data.p:KeyPressed( IN_ATTACK2 ) then
			data.p:EmitSound("common/weapon_select.wav", nil, 70, 0.5)
		end
		lastcurtime1 = CurTime()
	end]]

	table.Empty(puss)
	for i, v in ipairs( ifuckinghateyou ) do
		local guts = i
		local ami = selected1 == i
		v.oslot.iRaise = math.Approach(v.oslot.iRaise or 0, ami and 1 or 0, FrameTime()/0.2)
		local rain = v.oslot.iRaise
		cam.Start3D2D( data.pos + (weed1), data.ang, 0.1 )
			local crack1 = Color( cs2.r, cs2.g, cs2.b, Lerp( rain, 127, 255 ) )
			local crack2 = Color( cs2.r, cs2.g, cs2.b, Lerp( rain, 0, 255 ) )
			local crack3 = Color( 0, 0, 255, Lerp( rain, 31, 127 ) )
			surface.SetDrawColor( crack3 )
			--surface.DrawRect( 0, 8+((guts)*gaap), 800, 64 )
		cam.End3D2D()

		local wheeler = {}
		-- top left
		do
			local tada = data.pos + (weed1) + (weedx*8*0.1)+(weedx*0.1*guts*gaap)
			tada = tada:ToScreen()
			wheeler["tl"] = {x = tada.x, y = tada.y}
		end

		-- bottom left
		do
			local tada = data.pos + (weed1) + (weedx*(8+64)*0.1)+(weedx*0.1*guts*gaap)
			tada = tada:ToScreen()
			wheeler["bl"] = {x = tada.x, y = tada.y}
		end

		-- top right
		do
			local tada = data.pos + (weed1) + ((weedx*(8)*0.1)+(weedx*0.1*guts*gaap))+ ((weedy*(800)*0.1))
			tada = tada:ToScreen()
			wheeler["tr"] = {x = tada.x, y = tada.y}
		end

		-- bottom right
		do
			local tada = data.pos + (weed1) + ((weedx*(8+64)*0.1)+(weedx*0.1*guts*gaap))+ ((weedy*(800)*0.1))
			tada = tada:ToScreen()
			wheeler["br"] = {x = tada.x, y = tada.y}
		end
		puss[guts] = wheeler

		for i=1, 2 do
			local col = i == 1 and cs2 or cw
			cam.Start3D2D( data.pos + ( weed1 * (i/2) ) + ( weed2 * math.ease.InOutCubic(rain) ), data.ang, 0.1 )
				local crack1 = Color( col.r, col.g, col.b, Lerp( rain, 63, 255 ) )
				local crack2 = Color( col.r, col.g, col.b, Lerp( rain, 0, 255 ) )
				draw.DrawText(
					v["Title"],
					"Solar_A_2",
					159,
					0+8+((guts)*gaap),
					crack1,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
				draw.DrawText(
					--[[ami and v["Subtitle2"] or ]]v["Subtitle"],
					"Solar_A_3",
					160,
					38+8+((guts)*gaap),
					crack2,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
				surface.SetMaterial( v["Icon"] )
				surface.SetDrawColor( crack1 )
				surface.DrawTexturedRect( 80, 8+((guts)*gaap), 54, 54 )
			cam.End3D2D()
		end
		

		for i=1, 2 do
			local col = i == 1 and cs2 or cw
			cam.Start3D2D( data.pos + ( weed1 * (i/2) ) + ( weed2 * math.ease.InOutCubic(rain) ), data.ang, 0.1 )
				local crack1 = Color( col.r, col.g, col.b, Lerp( rain, 63, 255 ) )
				local crack2 = Color( col.r, col.g, col.b, Lerp( rain, 0, 255 ) )
				draw.DrawText(
					v["Title"],
					"Solar_A_2",
					159,
					0+8+((guts)*gaap),
					crack1,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
				draw.DrawText(
					--[[ami and v["Subtitle2"] or ]]v["Subtitle"],
					"Solar_A_3",
					160,
					38+8+((guts)*gaap),
					crack2,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
			cam.End3D2D()
		end
	end
	

	for b=1, 5 do
		for i=1, 2 do
			local col = i == 1 and cs2 or cw
			cam.Start3D2D( data.pos + ( weed1 * (i/2) ) + ( weed1 ), data.ang, 0.1 )
				surface.SetDrawColor( i == 2 and Color( 32, 32, 32, 255 ) or Color( 0, 0, 0, 127 ) )
				surface.DrawRect( 159 - 32, 32 + (b*40), 200 + 32, 35 )
				local crack1 = Color( col.r, col.g, col.b, Lerp( b==1 and 1 or 0, 63, 255 ) )
				local crack2 = Color( col.r, col.g, col.b, Lerp( b==1 and 1 or 0, 0, 255 ) )
				draw.DrawText(
					"ACOG",
					"Solar_C_1",
					159,
					32+(b*40),
					crack1,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
				local bongx, bongy = surface.GetTextSize( "ACOG" )
				draw.DrawText(
					"4x OPTICAL",
					"Solar_C_2",
					159+12+bongx,
					32+(b*40)+(6),
					crack1,
					TEXT_ALIGN_LEFT,
					TEXT_ALIGN_TOP
				)
			cam.End3D2D()
		end
	end

	end
end ------------------------------------------------
moves.test1.pos = Vector( -72/2 - 36, 230, 72/2 )
moves.test1.ang = Angle( -10, 0, 0 )

local papi2 = {
	[1] = {
		["Title"] = "Glock 17",
		["Font"] = "Solar_A_4",
		["Spacing"] = 56,
	},
	[2] = {
		["Title"] = "9x19mm handgun",
		["Font"] = "Solar_A_3",
		["Spacing"] = 36,
	},
	[3] = {
		["Title"] = "Year",
		["Font"] = "Solar_A_5",
		["Spacing"] = 16,
	},
	[4] = {
		["Title"] = "1989",
		["Font"] = "Solar_A_3",
		["Spacing"] = 36,
	},
	[5] = {
		["Title"] = "Mechanism",
		["Font"] = "Solar_A_5",
		["Spacing"] = 16,
	},
	[6] = {
		["Title"] = "Short-recoil",
		["Font"] = "Solar_A_3",
		["Spacing"] = 36,
	},
	[7] = {
		["Title"] = "Country",
		["Font"] = "Solar_A_5",
		["Spacing"] = 16,
	},
	[8] = {
		["Title"] = "Austria",
		["Font"] = "Solar_A_3",
		["Spacing"] = 36,
	},
}
local chingas = 720
local selected2 = 1
local letsgo = 0
moves.test2 = {}
moves.test2.func = function( data ) ------------------------------------------------
	local w = data.p:GetActiveWeapon()
	if IsValid(w) and w.Suburb and w:GetCustomizing() then
	local extra = 75

	local potal = Vector()
	potal:Add( moves.test2.pos )
	data.pos:Add( potal.x * ( data.eang:Right() ) )
	data.pos:Add( potal.y * ( data.eang:Forward() ) )
	data.pos:Add( potal.z * ( data.eang:Up() ) )

	local total = Angle()
	total:Set( moves.test2.ang )
	data.ang:RotateAroundAxis( data.ang:Up(), total.y )
	data.ang:RotateAroundAxis( data.ang:Right(), total.r )
	data.ang:RotateAroundAxis( data.ang:Forward(), total.p )

	local weed1 = ( data.ang:Up() * globalweed2 )
	local weed2 = ( data.ang:Up() * globalweed3 )

	cam.Start3D2D( data.pos, data.ang, 0.1 )
		surface.SetMaterial( test2 )
		surface.SetDrawColor( cs2 )
		surface.DrawTexturedRectRotated( chingas/2, chingas/2, chingas, chingas, 270 )
	cam.End3D2D()

	if data.p:KeyPressed( IN_MOVELEFT ) then
		selected2 = selected2 - 1
		if selected2 <= 0 then
			selected2 = #papi2
		end
	elseif data.p:KeyPressed( IN_MOVERIGHT ) then
		selected2 = selected2 + 1
		if selected2 > #papi2 then
			selected2 = 1
		end
	end
	if data.p:KeyPressed( IN_MOVELEFT ) or data.p:KeyPressed( IN_MOVERIGHT ) then
		--data.p:EmitSound("garrysmod/ui_hover.wav", nil, 100, 0.5)
	end

	if letsgo > -1 then
		letsgo = math.Approach(letsgo, 1, FrameTime()/0.5)
	end
	if letsgo == 1 then
		letsgo = -1
	end

	local gaap = 0
	for i, v in ipairs( papi2 ) do
		v.iRaise = math.Approach(v.iRaise or 0, selected2 == i and 1 or 0, FrameTime()/0.2)
		cam.Start3D2D( data.pos + (weed1*0.5), data.ang, 0.1 )
			local crack1 = cs2--Color( cs2.r, cs2.g, cs2.b, Lerp( v.iRaise, 127, 255 ) )
			draw.DrawText(
				v["Title"],
				v["Font"],
				720-159,
				89+((i-1)+gaap),
				crack1,
				TEXT_ALIGN_RIGHT,
				TEXT_ALIGN_TOP
			)
		cam.End3D2D()
		cam.Start3D2D( data.pos + (weed1), data.ang, 0.1 )
			local crack1 = cw--Color( cw.r, cw.g, cw.b, Lerp( v.iRaise, 127, 255 ) )
			draw.DrawText(
				v["Title"],
				v["Font"],
				720-159,
				89+((i-1)+gaap),
				crack1,
				TEXT_ALIGN_RIGHT,
				TEXT_ALIGN_TOP
			)
		cam.End3D2D()
		gaap = gaap + v["Spacing"]
	end
	end
end ------------------------------------------------
moves.test2.pos = Vector( -72/2 + 36, 230, 72/2 )
moves.test2.ang = Angle( -10, 0, 0 )

hook.Add("HUDPaint", "Solar", function()
	local p = LocalPlayer()

	local eang = EyeAngles()
	local ang = EyeAngles()
	ang = Angle( ang.x, ang.y, ang.z )

	local pos = EyePos()
	pos = Vector( pos.x, pos.y, pos.z )

	local total = Angle()
	total:Add( moves.fix )
	ang:RotateAroundAxis( ang:Up(), total.y )
	ang:RotateAroundAxis( ang:Right(), total.r )
	ang:RotateAroundAxis( ang:Forward(), total.p )

	local pre_pos = pos
	pos = Vector( pos.x, pos.y, pos.z )
	local pre_ang = ang
	ang = Angle( ang.x, ang.y, ang.z )

	-- pre_pos = Vector()
	-- pre_ang = Angle()
	-- pos = Vector()
	-- eang = Angle()
	-- ang = Angle()

	cam.IgnoreZ(true)
	cam.Start3D( nil, nil, 40 )
		local sheet = { p = p, pos = pos, ang = ang, eang = eang, pre_pos = pre_pos, pre_ang = pre_ang }
		for i, v in pairs( moves ) do
			if !v.func then continue end
			v.func( sheet )
			pos:Set(pre_pos)
			ang:Set(pre_ang)
		end
	cam.End3D()
	cam.IgnoreZ(false)
end)

hook.Add("HUDPaint", "blah", function()
	--surface.SetDrawColor(0,0,0,250)
	--surface.DrawRect(0, 0, ScrW(), ScrH())
end)

if CLIENT then
	concommand.Add("newurb_menu", function( ply, cmd, args)
		newurb_menu( ply, cmd, args )
	end)
	function newurb_menu( ply, cmd, args )
		if SuburbCustDerma then SuburbCustDerma:Remove() end
		menu = vgui.Create("DFrame")
		SuburbCustDerma = menu
		menu:SetSize(ScrW(), ScrH())
		menu:Center()
		menu:SetTitle("Derma Frame")
		menu:MakePopup()
		menu:SetKeyboardInputEnabled( false )

		local buttons = {}
		for i, v in pairs(puss) do
			local button = vgui.Create("DButton", menu)
			button:SetText("")
			button:SetPos(v["tl"].x, v["tl"].y)
			button:SetSize(v["tr"].x-v["tl"].x, v["br"].y-v["tl"].y)
			button.Index = i
			buttons[i] = button
			lastselect1 = 0
			function button:Paint( w, h )
				--surface.SetDrawColor( self:IsHovered() and Color(0, 0, 0, 2) or Color(0, 0, 0, 1) )
				--surface.DrawRect(0, 0, w, h)
			end
			function button:Think()
				if self.Index != lastselect1 then
					if self:IsHovered() then
						selected1 = self.Index
						LocalPlayer():EmitSound("arc9/newui/uimouse_hover.ogg", nil, 100, 0.5, CHAN_STATIC)
						LocalPlayer():EmitSound("arc9/newui/uisweep_bass.ogg", nil, 100, 0.2, CHAN_STATIC)
					end
					lastselect1 = selected1
				end
			end
			function button:DoClick()
				LocalPlayer():EmitSound("arc9/newui/uimouse_click_return.ogg", nil, 100, 0.5, CHAN_STATIC)
			end
			function button:DoRightClick()
				LocalPlayer():EmitSound("arc9/newui/uimouse_click_tab.ogg", nil, 100, 0.5, CHAN_STATIC)
			end
		end

		function menu:Paint( w, h )
		end

		function menu:Think()
			for i, button in ipairs(buttons) do
				v = puss[button.Index]
				button:SetPos(v["tl"].x, v["tl"].y)
				button:SetSize(v["tr"].x-v["tl"].x, v["br"].y-v["tl"].y)
			end
		end
	end
end



local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	-- ["CHudCrosshair"] = true,
	-- ["CHudCloseCaption"] = true,
	-- ["CHudDamageIndicator"] = true,
	-- ["CHudGeiger"] = true,
	-- ["CHudMessage"] = true,
	-- ["CHudPoisonDamageIndicator"] = true,
	-- ["CHudSecondaryAmmo"] = true,
	-- ["CHudSquadStatus"] = true,
	-- ["CHudTrain"] = true,
	-- ["CHudVehicle"] = true,
	-- ["CHudZoom"] = true,
	-- ["CHUDQuickInfo"] = true,
	-- ["CHudSuitPower"] = true,
}

hook.Add( "HUDShouldDraw", "SolarHUD", function( name )
	if GetConVar("newurb_enabled"):GetBool() and ( hide[ name ] ) then return false end
end )