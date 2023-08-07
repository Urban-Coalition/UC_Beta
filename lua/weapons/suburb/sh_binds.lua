
local fmdebounce = false

hook.Add( "StartCommand", "Suburb_StartCommand", function( ply, cmd )
	if ply and IsValid(ply) then
		if IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon().Suburb then
			local wep = ply:GetActiveWeapon()
			if wep:GetHolster_Time() != 0 and wep:GetHolster_Time() <= CurTime() then
				if IsValid(wep:GetHolster_Entity()) then
					cmd:SelectWeapon(wep:GetHolster_Entity())
				end
			end

			if !cmd:KeyDown(IN_USE) then
				if cmd:KeyDown(IN_ZOOM) then
					if !fmdebounce then
						cmd:SetImpulse(150)
						fmdebounce = true
					end
				else
					fmdebounce = false
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
					wep:ToggleRadio()
				end
			end
			if SERVER and ply:FlashlightIsOn() then ply:Flashlight() end
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
		if !LocalPlayer():KeyDown(IN_USE) then
			LocalPlayer():ConCommand("impulse 151")
			return true
		end
	end
end)

if CLIENT then
	local CCP_BG = Color( 0, 0, 0, 200 )
	local CCP_BUTTON = Color( 200, 200, 200, 127 )
	local CCP_BUTTONHOVER = Color( 255, 255, 255, 255 )
	local CCP_T = Color( 255, 255, 255, 255 )

	local CCP_S_1 = Color( 180, 195, 255, 255 )
	local CCP_S_2 = Color( 255, 105, 105, 255 )
	local function ss(size)
		return size * (ScrH() / 480)
	end
	surface.CreateFont( "ccpanel_tb_8", { font = "Verdana", size = ss(8), weight = 0 } )
	surface.CreateFont( "ccpanel_tb_10", { font = "Verdana", size = ss(10), weight = 0 } )
	surface.CreateFont( "ccpanel_tb_12", { font = "Verdana", size = ss(12), weight = 0 } )
	surface.CreateFont( "ccpanel_tb_16", { font = "Verdana", size = ss(16), weight = 0 } )

	function CCPanel()
		local ply = LocalPlayer()
		local wep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()

		if ST_Slot then ST_Slot:Remove() end
		ST_Slot = vgui.Create("DFrame")
		ST_Slot:SetTitle("Test cust frame")
		ST_Slot:SetPos( ss(10), ss(10) )
		ST_Slot:SetSize( ss(160), ss(240) )
		ST_Slot:MakePopup()
		ST_Slot:SetKeyboardInputEnabled( false )
		
		function ST_Slot:Paint( w, h )
			surface.SetDrawColor( CCP_BG )
			surface.DrawRect( 0, 0, w, h )
		end

		local scroller = vgui.Create( "DScrollPanel", ST_Slot )
		scroller:Dock( FILL )

		for i, slot in SortedPairsByMemberValue( wep.Attachments, "SortOrder", false ) do
			if i == "BaseClass" then continue end

			local butt = scroller:Add( "DButton" )
			butt:SetSize( 10, ss(24) )
			butt:Dock( TOP )
			butt:DockMargin( 0, 0, 0, ss(4) )

			function butt:Paint( w, h )
				surface.SetDrawColor( CCP_BUTTON )
				surface.DrawRect( 0, 0, w, h )

				if self:IsHovered() then
					surface.SetDrawColor( CCP_BUTTONHOVER )
					surface.DrawOutlinedRect( 0, 0, w, h, ss(2) )
				end

				surface.SetTextColor( CCP_T )

				surface.SetFont( "ccpanel_tb_8" )
				surface.SetTextPos( ss(4), ss(4) )
				surface.DrawText( slot.Name )

				local lookup = Suburb.AttTable[slot._Installed]
				local attname = "---"
				if slot._Installed then
					assert(lookup, "Suburb: That attachment doesn't exist!")
					attname = lookup.ShortName or lookup.Name
				end
				surface.SetFont( "ccpanel_tb_12" )
				surface.SetTextPos( ss(4), ss(10) )
				surface.DrawText( attname )
				return true
			end

			function butt:DoClick()
				return CCPanel_AttsList( ST_Slot, i, slot )
			end
			function butt:DoRightClick()
				if slot._Installed then
					wep:CL_Att_Attach( i, "" )
				end
			end

			scroller:Add( butt )
		end
	end

	function CCPanel_AttsList( god, index, data )
		local ply = LocalPlayer()
		local wep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()

		if ST_Atts then ST_Atts:Remove() end
		ST_Atts = vgui.Create("DFrame")
		ST_Atts:SetTitle("Attachment list")
		do
			local x, y, w, h = god:GetBounds()
			ST_Atts:SetPos( x + w + ss(5), y )
		end
		ST_Atts:SetSize( ss(180), ss(200) )
		ST_Atts:MakePopup()
		ST_Atts:SetKeyboardInputEnabled( false )

		function ST_Atts:Think()
			if !IsValid(ST_Slot) then
				-- wtf am i doing here?
				ST_Atts:Remove()
			end
		end
		
		function ST_Atts:Paint( w, h )
			surface.SetDrawColor( CCP_BG )
			surface.DrawRect( 0, 0, w, h )
		end

		local scroller = vgui.Create( "DScrollPanel", ST_Atts )
		scroller:Dock( FILL )

		for i, v in pairs( Suburb.AttTable ) do
			if !v.SortOrder then v.SortOrder = 0 end
		end
		for i, v in SortedPairsByMemberValue( Suburb.AttTable, "SortOrder", true ) do
			if i == "BaseClass" then continue end

			local wepsl = wep.Attachments[index]
			local wepslot, attslot = wep.Attachments[index].Slot, v.Slot
			if !wepslot then
				SDeP( "Suburb CCPanel_AttsList: Index #" .. index .. " has no wepslot" )
			end
			if !attslot then
				SDeP( "Suburb CCPanel_AttsList: Attachment " .. i .. " has no attslot" )
			end
			if !wepslot or !attslot or !Quickcheck( wepslot, attslot ) then continue end

			local butt = scroller:Add( "DButton" )
			butt:SetSize( 10, ss(24) )
			butt:Dock( TOP )
			butt:DockMargin( 0, 0, 0, ss(4) )
			butt.AttName = i

			butt.SlideAmount = 0.5

			function butt:Paint( w, h )
				surface.SetDrawColor( CCP_BUTTON )
				surface.DrawRect( 0, 0, w, h )
				
				local inst = wepsl._Installed == i
				local slidable = wepsl.Pos0 and wepsl.Pos1
				if inst and slidable and (self:IsHovered() or self:IsDown()) then
					surface.SetDrawColor( 255, 255, 255, 63 )
					surface.DrawRect( 0, 0, w * self.SlideAmount, h )

					if self:IsDown() then
						local segments = 8
						for i=1, segments-1 do
							surface.SetDrawColor( 255, 255, 255, 200 )
							surface.DrawRect( (w*(i/segments))-ss(1/2), (h/2)-ss(8/2), ss(1), ss(8) )
						end
					end
				end

				if inst or butt:IsHovered() then
					surface.SetDrawColor( CCP_BUTTONHOVER )
					surface.DrawOutlinedRect( 0, 0, w, h, ss(inst and 3 or 2) )
				end

				surface.SetTextColor( CCP_T )

				surface.SetFont( "ccpanel_tb_8" )
				surface.SetTextPos( ss(4), ss(4) )
				surface.DrawText( v.ShortNameSubtitle or v.Name )

				surface.SetFont( "ccpanel_tb_12" )
				surface.SetTextPos( ss(4), ss(10) )
				surface.DrawText( v.ShortName )

				-- local siz = 0
				-- if v.ShortName then
				-- 	surface.SetFont( "ccpanel_tb_8" )
				-- 	siz = surface.GetTextSize( v.Name )
				-- 	surface.SetTextPos( w - ss(4) - siz, ss(4) )
				-- 	surface.DrawText( v.Name )
				-- end
				-- 
				-- if v.ShortNameSubtitle then
				-- 	surface.SetFont( "ccpanel_tb_8" )
				-- 	siz = surface.GetTextSize( v.ShortNameSubtitle )
				-- 	surface.SetTextPos( w - ss(4) - siz, ss(12) )
				-- 	surface.DrawText( v.ShortNameSubtitle )
				-- end
				return true
			end

			function butt:DoClick()
				if wepsl._Installed != i then
					wep:CL_Att_Attach( index, i )
				end
			end
			function butt:DoRightClick()
				wep:CL_Att_Attach( index, "" )
			end
			function butt:Think()
				local ref = ST_Stat
				local hov = butt:IsHovered()
				local slidable = wepsl.Pos0 and wepsl.Pos1
				if slidable and hov then
					local segments = 8
					self.SlideAmount = math.Round( math.Remap( input.GetCursorPos(), butt:LocalToScreen(0), butt:LocalToScreen(butt:GetWide()), 0, 1 )*segments, 0 )/segments
					if butt:IsDown() then
						if wepsl._SlideAmount != self.SlideAmount then
							wep:EmitSound( "weapons/arccw/fiveseven/fiveseven_slideback.wav", 50, Lerp( self.SlideAmount, 85, 115 ), 0.75, CHAN_STATIC )
						end
						wepsl._SlideAmount = self.SlideAmount
					end
					if IsValid(ref) then
						ref.AttName = i
					else
						CCPanel_AttStat( i )
					end
				end
			end
			scroller:Add( butt )
		end
	end

	function CCPanel_AttStat( name )
		local ply = LocalPlayer()

		if ST_Stat then ST_Stat:Remove() end
		ST_Stat = vgui.Create("DFrame")
		ST_Stat.AttName = "ud_m16_lr_auto"
		ST_Stat:SetTitle("Attachment statistics")
		ST_Stat:SetSize( ss(180), ss(200) )
		do
			local w, h = ScrW(), ScrH()
			ST_Stat:SetPos( w - ss(10) - ss(180), ss(10) )
		end
		ST_Stat:MakePopup()
		ST_Stat:SetKeyboardInputEnabled( false )

		function ST_Stat:Think()
			if !IsValid(ST_Atts) then
				-- wtf am i doing here?
				ST_Stat:Remove()
			end
		end
		
		function ST_Stat:Paint( w, h )
			surface.SetDrawColor( CCP_BG )
			surface.DrawRect( 0, 0, w, h )
		end

		local scroller = vgui.Create( "DScrollPanel", ST_Stat )
		scroller:Dock( FILL )

		local butt = scroller:Add( "DPanel" )
		butt:SetSize( 10, ss(200) )
		butt:Dock( FILL )
		butt:DockMargin( 0, 0, 0, 0 )
		butt:SetBackgroundColor( CCP_BG )

		function butt:Paint( w, h )
			surface.SetDrawColor( CCP_BG )
			surface.DrawRect( 0, 0, w, h )

			local att = Suburb.AttTable[ST_Stat.AttName]
			assert( att, "Suburb ST_Stat: That attachment doesn't exist!: " .. ST_Stat.AttName )

			surface.SetTextColor( CCP_T )
			surface.SetFont( "ccpanel_tb_12" )
			local tw = surface.GetTextSize( att.Name )
			surface.SetTextPos( ss(180/2) - (tw/2), ss(8) )
			surface.DrawText( att.Name )

			if att.ShortName then
				surface.SetFont( "ccpanel_tb_8" )
				local tw = surface.GetTextSize( att.ShortName )
				surface.SetTextPos( ss(180/2) - (tw/2), ss(20) )
				surface.DrawText( att.ShortName )
			end

			local boost = 32
			for item, ass in SortedPairsByMemberValue( AutoStats, 3, true ) do
				if !att[item] then continue end
				if att.HideAutoStats and att.HideAutoStats[item] then continue end

				local orig = self:GetTable()[i] or -math.huge
				surface.SetFont( "ccpanel_tb_10" )
				surface.SetTextColor( ass[2]( att[item], self ) and CCP_S_1 or CCP_S_2 )
				local tex = ass[1]( att[item] )
				local tw = surface.GetTextSize( tex )
				surface.SetTextPos( ss(180/2) - (tw/2), ss(boost) )
				surface.DrawText( tex )
				boost = boost + 12
			end
		end

		scroller:Add( butt )
	end

end

-- 1: String Format
-- 2: Is positive better?
-- 3: Sort order, bigger numbers are higher
AutoStats = {
	-- 900
	["Override_Capacity"] = {
		function( data ) return string.format( "%+g%% clip size", math.Round((data-1)*100) ) end,
		function( data, orig ) return data<=0 end,
		999,
	},
	["Mult_Capacity"] = {
		function( data ) return string.format( "%+g%% clip size", math.Round((data-1)*100) ) end,
		function( data, orig ) return data>1 end,
		998,
	},

	-- 800
	["Mult_Delay"] = {
		function( data ) return string.format( "%+G%% firing speed", math.Round((1-data)*100) ) end,
		function( data ) return data<=1 end,
		899,
	},
	["Mult_PostBurstDelay"] = {
		function( data ) return string.format( "%+G%% firing burst speed", math.Round((1-data)*100) ) end,
		function( data ) return data<=1 end,
		898,
	},

	-- 700
	["Mult_ReloadTime"] = {
		function( data ) return string.format( "%+G%% reload time", math.Round((data-1)*100) ) end,
		function( data ) return data<=1 end,
		799,
	},
	["Mult_SightTime"] = {
		function( data ) return string.format( "%+G%% sight time", math.Round((data-1)*100) ) end,
		function( data ) return data<=1 end,
		798,
	},
	["Mult_SprintTime"] = {
		function( data ) return string.format( "%+G%% sight time", math.Round((data-1)*100) ) end,
		function( data ) return data<=1 end,
		797,
	},

	-- 500
	["Mult_Range"] = {
		function( data ) return string.format( "%+G%% effective range", math.Round((data-1)*100) ) end,
		function( data ) return data>1 end, -- Consider inverse falloff weapons
		579,
	},
	["Mult_RangeMin"] = {
		function( data ) return string.format( "%+G%% minimum range", math.Round((data-1)*100) ) end,
		function( data ) return data>1 end, -- Consider inverse falloff weapons
		578,
	},

	-- 400
	["Mult_Accuracy"] = {
		function( data ) return string.format( "%+G%% precision", math.Round((data-1)*100) ) end,
		function( data ) return data<1 end,
		499,
	},
	["Mult_Dispersion"] = {
		function( data ) return string.format( "%+G%% dispersion", math.Round((data-1)*100) ) end,
		function( data ) return data<1 end,
		489,
	},
	["Mult_Dispersion_Move"] = {
		function( data ) return string.format( "%+G%% dispersion while moving", math.Round((data-1)*100) ) end,
		function( data ) return data<1 end,
		488,
	},
	["Mult_Dispersion_Air"] = {
		function( data ) return string.format( "%+G%% dispersion while midair", math.Round((data-1)*100) ) end,
		function( data ) return data<1 end,
		487,
	},
	["Mult_Dispersion_Crouch"] = {
		function( data ) return string.format( "%+G%% dispersion while ducking", math.Round((data-1)*100) ) end,
		function( data ) return data<1 end,
		486,
	},
	["Mult_Dispersion_Sights"] = {
		function( data ) return string.format( "%+G%% dispersion while sights", math.Round((data-1)*100) ) end,
		function( data ) return data<1 end,
		485,
	},
}

function SWEP:ToggleCustomize()
	if self:GetCustomizing() then
		self:SetCustomizing( false )
		if CLIENT then
			if ST_Slot then ST_Slot:Remove() end
			if ST_Atts then ST_Atts:Remove() end
			if ST_Stat then ST_Stat:Remove() end
		end
	else
		self:SetCustomizing( true )
		if CLIENT then CCPanel() end
	end
end

-- Tell the server we want to attach something
function SWEP:CL_Att_Attach( index, name )
	if SERVER then print("Suburb CL_Att_Attach: wrong realm on cl att attach") end
	net.Start("Suburb_ATT_Install")
		net.WriteEntity( self )
		net.WriteUInt( index, 8 )
		net.WriteString( name )
	net.SendToServer()
end

function fesytest( index, name )
	net.Start("Suburb_ATT_Install")
		net.WriteEntity( Entity(1):GetActiveWeapon() )
		net.WriteUInt( index, 8 )
		net.WriteString( name )
	net.SendToServer()
end

if SERVER then
	net.Receive("Suburb_ATT_Install", function( len, ply )
		local wep = net.ReadEntity()
		local index = net.ReadUInt( 8 )
		local name = net.ReadString()

		assert( wep, "Suburb Suburb_ATT_Install: Nothing sent for weapon" )
		assert( index, "Suburb Suburb_ATT_Install: Nothing sent for index" )
		assert( name, "Suburb Suburb_ATT_Install: Nothing sent for attname" )

		-- Eventually we're gonna want to always go through TestCompatibility for reasons listed in it
		if name == "" or wep:TestCompatibility( ply, index, name ) then
			net.Start( "Suburb_ATT_Confirm" )
				net.WriteEntity( wep )
				net.WriteUInt( index, 8 )
				net.WriteString( name )
			net.Send( ply )
			if name == "" then 
				wep.Attachments[index]._Installed = nil
			else
				wep.Attachments[index]._Installed = name
			end
			wep:RegenStats()
		end
	end)
else
	net.Receive("Suburb_ATT_Confirm", function( len )
		local wep = net.ReadEntity()
		local index = net.ReadUInt( 8 )
		local name = net.ReadString()

		SDeP( "Suburb Suburb_ATT_Confirm: Server told me to attach " .. name .. " for index #" .. index, wep )
		if name == "" then 
			wep:EmitSound( "weapons/arccw/uninstall.wav" )
			wep.Attachments[index]._Installed = nil
		else
			wep:EmitSound( "weapons/arccw/install.wav" )
			wep.Attachments[index]._Installed = name
		end
		wep:RegenStats()
	end)
end

function SWEP:TestCompatibility( ply, index, attname )
	SDeP( "Suburb: Server testing: ", self, index .. " -- " .. attname )
	local indet = self.Attachments[index]
	local namet = Suburb.AttTable[attname]

	assert( ply, "Suburb TestCompatibility: Nothing sent for player..." )
	assert( index, "Suburb TestCompatibility: Nothing sent in index..." )
	assert( attname, "Suburb TestCompatibility: Nothing sent in name..." )

	assert( self:GetOwner() == ply, "Suburb TestCompatibility: You do not own the weapon you're trying to customize!" )
	assert( namet, "Suburb TestCompatibility: The server doesn't recognize this attachment!" )

	local wepslot, attslot = indet.Slot, namet.Slot
	assert( wepslot, "Suburb TestCompatibility: The weapon 'slot' doesn't have a Slot!" )
	assert( attslot, "Suburb TestCompatibility: The attachment doesn't have a Slot!" )

	assert( indet._Installed != attname, "Suburb TestCompatibility: You already have this installed." )

	-- Todo: Add checks for if slot is internal/cannot be removed,
	-- or for slots that must have a default attachment (cannot just be empty)

	if Quickcheck( wepslot, attslot ) then
		SDeP( "Suburb TestCompatibility: Slot fit!" )
		return true
	else
		SDeP( "Suburb TestCompatibility: Slot didn't fit!" )
		return false
	end
end

-- Quickcheck
-- Check if a thing has alike things
function Quickcheck( wepslot, attslot )
	if isstring(wepslot) then -- String slot1

		if isstring(attslot) then		-- String slot2
			return wepslot == attslot
		else							-- Table slot2
			for i, v in pairs( attslot ) do
				if attslot[wepslot] then
					return true
				else continue end
				return false
			end
		end

	else -- Table slot1

		if isstring(attslot) then		-- String slot2
			return wepslot[attslot]
		else							-- Table slot2
			for w_i, w_v in pairs(wepslot) do
				for a_i, a_v in pairs(attslot) do
					if (w_i == a_i) then return true end
				end
			end
			return false
		end

	end
end


do -- Attachment radio

function SWEP:ToggleRadio()
	if !CLIENT then return end
	if IsValid(AR_Menu) then
		AR_Menu:Remove()
	else
		AR_OpenMenu()
	end
end

local CCP_BG = Color( 0, 0, 0, 200 )
local CCP_BUTTON = Color( 200, 200, 200, 127 )
local CCP_BUTTONHOVER = Color( 255, 255, 255, 255 )
local CCP_TEXT = Color( 255, 255, 255, 255 )

local function ss(size)
	return size * (ScrH() / 480)
end

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

function AR_OpenMenu()
	local ply = LocalPlayer()
	local wep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()
	local sw, sh = ScrW(), ScrH()

	if AR_Menu then AR_Menu:Remove() end
	AR_Menu = vgui.Create("DFrame")
	AR_Menu:SetSize( sh, sh )
	AR_Menu:Center()
	AR_Menu:MakePopup()
	AR_Menu:SetKeyboardInputEnabled( false )

	function AR_Menu:Paint( w, h )
		surface.SetDrawColor( CCP_BG )
		surface.DrawRect( 0, 0, w, h )
	end

	local x, y = sh/2, sh/2
	local interval = 360/#items
	for index, item in ipairs(items) do
		local de = 0 - ( index * interval ) + interval
		de = math.rad( de + 180 )
		local dist = ss( Lerp( math.TimeFraction( 3, 6, #items ), 60, 100 ) )
		local ox, oy = math.sin( de ) * dist * 1.8, math.cos( de ) * dist
		local rx, ry = x + ox, y + oy
		local bx, by = ss( 180 ), ss( 18 )
		local r2x, r2y = rx - (bx/2), ry - (by/2)

		local button = AR_Menu:Add( "DButton" )
		button:SetPos( r2x, r2y )
		button:SetSize( bx, by )
		button:SetText( item.Name )

		item.Selected = 1

		function button:Paint( w, h )
			self:NoClipping( true )

			surface.SetDrawColor( self:IsHovered() and CCP_BUTTONHOVER or CCP_BUTTON )
			surface.DrawRect( 0, 0, w, h )
			
			local boost = 18+2
			if item.Options then
				for hindex, option in ipairs(item.Options) do
					local sel = item.Selected == hindex
					option = (sel and ">> " or "") .. option .. (sel and " <<" or "")
					surface.SetFont( "ccpanel_tb_12" )
					surface.SetTextColor( CCP_TEXT )
					local tw = surface.GetTextSize( option )
					surface.SetTextPos( (w/2) - (tw/2), ss(boost) )
					surface.DrawText( option )
					boost = boost + 12
				end
			end
		end

		function button:DoClick()
			if !item.Options then return end
			item.Selected = item.Selected + 1
			if item.Selected > #item.Options then
				item.Selected = 1
			end
		end

		function button:DoRightClick()
			if !item.Options then return end
			item.Selected = item.Selected - 1
			if item.Selected <= 0 then
				item.Selected = #item.Options
			end
		end

	end
end

end -- Attachment radio