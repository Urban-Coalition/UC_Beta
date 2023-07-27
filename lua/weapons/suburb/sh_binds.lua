
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

function CCPanel()
	local ply = LocalPlayer()
	local wep = IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon()

	if SuburbTest then SuburbTest:Remove() end
	SuburbTest = vgui.Create("DFrame")
	SuburbTest:SetTitle("Test cust frame")
	SuburbTest:SetPos( 200, 200 )
	SuburbTest:SetSize( 250, 400 )
	SuburbTest:MakePopup()
	SuburbTest:SetKeyboardInputEnabled( false )

	local scroller = vgui.Create( "DScrollPanel", SuburbTest )
	scroller:Dock( FILL )

	for i, v in SortedPairsByMemberValue( wep.Attachments, "SortOrder", false ) do
		if i == "BaseClass" then continue end

		local butt = scroller:Add( "DButton" )
		butt:SetText( v.Name )
		butt:SetSize( 10, 40 )
		butt:Dock( TOP )
		butt:DockMargin( 0, 0, 0, 5 )

		local wepslot = wep.Attachments[i].Slot
		if !wepslot then
			print( "No wepslot, wtf")
			continue
		end

		local label2 = vgui.Create( "DLabel", butt )
		local slotdebug = ""
		local merde = 0
		if istable(v.Slot) then
			for i, k in pairs(v.Slot) do
				if merde != #v.Slot then
					slotdebug = slotdebug .. ", "
				end
				slotdebug = slotdebug .. i
				merde = merde + 1
			end
		else
			slotdebug = v.Slot
		end
		label2:SetText( slotdebug )
		label2:SetDark( true )
		label2:SetPos( 5, 5+15 )
		label2:SetSize( 600, 20 )

		function butt:DoClick()
			return CCPanel_AttsList( SuburbTest, i, v )
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
		SuburbTestAtts:SetPos( x + w + 10, y )
	end
	SuburbTestAtts:SetSize( 200, 300 )
	SuburbTestAtts:MakePopup()
	SuburbTestAtts:SetKeyboardInputEnabled( false )

	local scroller = vgui.Create( "DScrollPanel", SuburbTestAtts )
	scroller:Dock( FILL )

	for i, v in pairs( Suburb.AttTable ) do
		if i == "BaseClass" then continue end

		local wepslot, attslot = wep.Attachments[index].Slot, v.Slot
		if !wepslot then
			print( "No wepslot, wtf")
		end
		if !attslot then
			print( "No attslot, wtf")
		end
		if !wepslot or !attslot or !Quickcheck( wepslot, attslot ) then continue end

		local butt = scroller:Add( "DButton" )
		butt:SetText( v.Name )
		butt:SetSize( 10, 40 )
		butt:Dock( TOP )
		butt:DockMargin( 0, 0, 0, 5 )

		--local label1 = vgui.Create( "DLabel", butt )
		--label1:SetText( v.Name )
		--label1:SetDark( true )
		--label1:SetPos( 5, 5 )
		--label1:SetSize( 600, 20 )

		local label2 = vgui.Create( "DLabel", butt )
		local slotdebug = ""
		local merde = 0
		if istable(v.Slot) then
			for i, k in pairs(v.Slot) do
				if merde != #v.Slot then
					slotdebug = slotdebug .. ", "
				end
				slotdebug = slotdebug .. i
				merde = merde + 1
			end
		else
			slotdebug = v.Slot
		end
		label2:SetText( slotdebug )
		label2:SetDark( true )
		label2:SetPos( 5, 5+15 )
		label2:SetSize( 600, 20 )

		function butt:DoClick()
			wep:CL_Att_Attach( index, i )
		end
		scroller:Add( butt )
	end
end

function SWEP:ToggleCustomize()
	if CLIENT then
		CCPanel()
	end
	do return end
	if SuburbCustDerma then SuburbCustDerma:Remove() end
	if self:GetCustomizing() then
		self:SetCustomizing( false )
	else
		self:SetCustomizing( true )
		self:GetOwner():ConCommand("newurb_menu")
	end
end

-- Tell the server we want to attach something
function SWEP:CL_Att_Attach( index, name )
	if SERVER then print("Suburb: wrong realm on cl att attach") end
	net.Start("Suburb_ATT_Install")
		net.WriteEntity( self )
		net.WriteUInt( index, 8 )
		net.WriteString( name )
	net.SendToServer()
	-- self.Attachments[index].Installed = name
end

function fesytest( index, name )
	net.Start("Suburb_ATT_Install")
		net.WriteEntity( Entity(1):GetActiveWeapon() )
		net.WriteUInt( index, 8 )
		net.WriteString( name )
	net.SendToServer()
end

net.Receive("Suburb_ATT_Install", function( len, ply )
	local wep = net.ReadEntity()
	local inde = net.ReadUInt( 8 )
	local indet = wep.Attachments[inde]
	local name = net.ReadString()
	local namet = Suburb.AttTable[name]
	print( "Suburb: Server testing: ", wep, inde .. " -- " .. name )

	assert( wep, "Suburb: Nothing sent in weapon..." )
	assert( inde, "Suburb: Nothing sent in index..." )
	assert( name, "Suburb: Nothing sent in name..." )

	assert( wep:GetOwner() == ply, "Suburb: You do not own the weapon you're trying to customize!" )
	assert( namet, "Suburb: The server doesn't recognize this attachment!" )

	local wepslot, attslot = indet.Slot, namet.Slot
	assert( wepslot, "Suburb: The weapon doesn't have a slot!" )
	assert( attslot, "Suburb: The attachment doesn't have a slot!" )

	if Quickcheck( wepslot, attslot ) then
		print( "Suburb: Slot fit, correctly attached!" )
	else
		print( "Suburb: Slot didn't fit, failed to attach!" )
	end
end)

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
			print( "Suburb: UNFINIHSED !!!!! both are table, work on it hard hat, forced on, PROBLEMS !!!!!!!!!!!!!!")
			return true --UNFINIHSED
		end

	end
end