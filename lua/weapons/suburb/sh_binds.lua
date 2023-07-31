
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
					if ply.AttachmentRadial then
						ply.AttachmentRadial = false
					else
						ply.AttachmentRadial = true
					end
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
	local function ss(size)
		return size * (ScrH() / 480)
	end
	surface.CreateFont( "ccpanel_tb_8", { font = "Verdana", size = ss(8), weight = 0 } )
	surface.CreateFont( "ccpanel_tb_12", { font = "Verdana", size = ss(12), weight = 0 } )
	surface.CreateFont( "ccpanel_tb_16", { font = "Verdana", size = ss(16), weight = 0 } )

	function CCPanel()
		local ply = LocalPlayer()
		local wep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()

		if SuburbTest then SuburbTest:Remove() end
		SuburbTest = vgui.Create("DFrame")
		SuburbTest:SetTitle("Test cust frame")
		SuburbTest:SetPos( ss(10), ss(10) )
		SuburbTest:SetSize( ss(160), ss(240) )
		SuburbTest:MakePopup()
		SuburbTest:SetKeyboardInputEnabled( false )
		
		function SuburbTest:Paint( w, h )
			surface.SetDrawColor( CCP_BG )
			surface.DrawRect( 0, 0, w, h )
		end

		local scroller = vgui.Create( "DScrollPanel", SuburbTest )
		scroller:Dock( FILL )

		for i, v in SortedPairsByMemberValue( wep.Attachments, "SortOrder", false ) do
			if i == "BaseClass" then continue end

			local butt = scroller:Add( "DButton" )
			butt:SetSize( 10, ss(24) )
			butt:Dock( TOP )
			butt:DockMargin( 0, 0, 0, ss(4) )

			function butt:Paint( w, h )
				surface.SetDrawColor( CCP_BUTTON )
				surface.DrawRect( 0, 0, w, h )

				if butt:IsHovered() then
					surface.SetDrawColor( CCP_BUTTONHOVER )
					surface.DrawOutlinedRect( 0, 0, w, h, ss(2) )
				end

				surface.SetTextColor( CCP_T )

				surface.SetFont( "ccpanel_tb_8" )
				surface.SetTextPos( ss(4), ss(4) )
				surface.DrawText( v.Name )

				local lookup = Suburb.AttTable[v._Installed]
				local attname = "---"
				if v._Installed then
					assert(lookup, "Suburb: That attachment doesn't exist!")
					attname = lookup.ShortName or lookup.Name
				end
				surface.SetFont( "ccpanel_tb_12" )
				surface.SetTextPos( ss(4), ss(10) )
				surface.DrawText( attname )
				return true
			end

			function butt:DoClick()
				return CCPanel_AttsList( SuburbTest, i, v )
			end
			function butt:DoRightClick()
				wep:CL_Att_Attach( i, "" )
			end

			scroller:Add( butt )
		end
	end

	function CCPanel_AttsList( god, index, data )
		local ply = LocalPlayer()
		local wep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()

		if SuburbTestAtts then SuburbTestAtts:Remove() end
		SuburbTestAtts = vgui.Create("DFrame")
		SuburbTestAtts:SetTitle("Attachment list")
		do
			local x, y, w, h = god:GetBounds()
			SuburbTestAtts:SetPos( x + w + ss(5), y )
		end
		SuburbTestAtts:SetSize( ss(180), ss(200) )
		SuburbTestAtts:MakePopup()
		SuburbTestAtts:SetKeyboardInputEnabled( false )
		
		function SuburbTestAtts:Paint( w, h )
			surface.SetDrawColor( CCP_BG )
			surface.DrawRect( 0, 0, w, h )
		end

		local scroller = vgui.Create( "DScrollPanel", SuburbTestAtts )
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

			function butt:Paint( w, h )
				surface.SetDrawColor( CCP_BUTTON )
				surface.DrawRect( 0, 0, w, h )

				local inst = wepsl._Installed == i
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

				local siz = 0

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
				wep:CL_Att_Attach( index, i )
			end
			function butt:DoRightClick()
				wep:CL_Att_Attach( index, "" )
			end
			scroller:Add( butt )
		end
	end

end

function SWEP:ToggleCustomize()
	if self:GetCustomizing() then
		self:SetCustomizing( false )
		if CLIENT then
			if SuburbTest then SuburbTest:Remove() end
			if SuburbTestAtts then SuburbTestAtts:Remove() end
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