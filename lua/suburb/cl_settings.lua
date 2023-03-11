
-- Spawnmenu settings menu

G_NUMSLIDER = function(list, text, convar, dec)
	local button = vgui.Create( "DNumSlider", list )
	button:SetText( text )
	button:SetDark( 1 )
	button:SetMin( 0 )
	button:SetMax( 2 )
	button:SetDecimals( dec or 1 )
	button:SetConVar( convar )
	button:Dock( TOP )
	button:DockMargin( 0, 5, 0, 5 )
end

G_CHECKBOX = function(list, text, convar, padx, pady)
	local button = vgui.Create( "DCheckBoxLabel", list )
	button:SetText(text)
	button:SetDark(1)
	button:SetConVar(convar)
	button:Dock( TOP )
	button:DockMargin( padx or 0, pady or 5, 0, pady or 5 )
end

G_HELP = function(list, text)
	local button = vgui.Create( "DLabel", list )
	button:SetText(text)
	button:SetDark(1)
	button:Dock( TOP )
	button:DockMargin( 24, -6, 32, 0 )
	button:SetWrap( true )
	button:SetAutoStretchVertical( true )
	button:SetTextColor( button:GetSkin().Colours.Tree.Hover )
end

local menus = {
	["client"]	= { text = "Client",	func = function(panel)
		panel:AddControl("header", { description = "Clientside settings for Urban Coalition / Suburb weapons." })

		do
			local cat = vgui.Create( "DCollapsibleCategory", panel )
			cat:SetLabel( "Preferences" )
			panel:AddPanel( cat )

			local llist = vgui.Create( "DIconLayout", panel )
			cat:SetContents( llist )
			llist:Dock( FILL )
			llist:SetSpaceX( 10 )
			llist:SetSpaceY( 10 )
			llist:DockPadding( 5, 2, 5, 2 )

			G_CHECKBOX(llist, "Toggle Aim", "uc_cl_aimtoggle")
			G_HELP(llist, "Tap once to aim and tap again to exit.")
			G_CHECKBOX(llist, "Exit Sights when Reloading", "uc_cl_aimtoggle_reload", 5, 2)
			G_CHECKBOX(llist, "Exit Sights when Sprinting", "uc_cl_aimtoggle_sprint", 5, 2)
			G_NUMSLIDER(llist, "Camera Multiplier", "uc_cl_cammult")
			G_HELP(llist, "Multiplier for camera movement from weapon animations.")
		end
		do
			local cat = vgui.Create( "DCollapsibleCategory", panel )
			cat:SetLabel( "HUD" )
			panel:AddPanel( cat )

			local llist = vgui.Create( "DIconLayout", panel )
			cat:SetContents( llist )
			llist:Dock( FILL )
			llist:SetSpaceX( 10 )
			llist:SetSpaceY( 10 )
			llist:DockPadding( 5, 2, 5, 2 )

			G_CHECKBOX(llist, "Enable HUD", "solar")
			G_CHECKBOX(llist, "for all weapons", "solar_all", 5, 2)
		end
		do
			local cat = vgui.Create( "DCollapsibleCategory", panel )
			cat:SetLabel( "Performance" )
			panel:AddPanel( cat )

			local llist = vgui.Create( "DIconLayout", panel )
			cat:SetContents( llist )
			llist:Dock( FILL )
			llist:SetSpaceX( 10 )
			llist:SetSpaceY( 10 )
			llist:DockPadding( 5, 2, 5, 2 )

			G_CHECKBOX(llist, "Cheap Scopes", "uc_cl_cheapscopes")
			G_HELP(llist, "Scopes will zoom in your entire view instead of dual-rendering.")
			G_CHECKBOX(llist, "Cheap Muzzle Effects", "uc_cl_cheapmuzzles")
			G_HELP(llist, "Low-quality muzzle effects.")
		end
	end },
}

hook.Add("PopulateToolMenu", "Suburb_Options", function()
    for menu, data in pairs(menus) do
        spawnmenu.AddToolMenuOption("Options", "Suburb", "suburb_menu_" .. menu, data.text, "", "", data.func)
    end
end)