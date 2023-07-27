
-- Spawnmenu settings menu

G_NUMSLIDER = function(list, text, convar, dec, min, max )
	local button = vgui.Create( "DNumSlider", list )
	button:SetText( text )
	button:SetDark( 1 )
	button:SetMin( min or 0 )
	button:SetMax( max or 2 )
	button:SetDecimals( dec or 1 )
	button:SetConVar( convar )
	button:Dock( TOP )
	button:DockMargin( 0, 5, 0, 5 )

	return button
end

G_CHECKBOX = function(list, text, convar, padx, pady)
	local button = vgui.Create( "DCheckBoxLabel", list )
	button:SetText(text)
	button:SetDark(1)
	button:SetConVar(convar)
	button:Dock( TOP )
	button:DockMargin( padx or 0, pady or 5, 0, pady or 5 )

	return button
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

	return button
end

G_LABEL = function(list, text, padx, pady)
	local button = vgui.Create( "DLabel", list )
	button:SetText(text)
	button:SetDark(1)
	button:Dock( TOP )
	button:DockMargin( padx or 0, pady or 2, padx or 0, pady or 2 )
	button:SetWrap( true )
	button:SetAutoStretchVertical( true )

	return button
end

G_BUTTON = function(list, text)
	local button = vgui.Create( "DButton", list )
	button:SetText(text)
	button:SetDark(1)
	button:Dock( TOP )
	button:DockMargin( 0, 5, 0, 5 )

	return button
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
			G_CHECKBOX(llist, "'Hellfire'", "uc_cl_hellfire")
			G_HELP(llist, "Muzzleflash projection onto the walls and onto your friends!")
			G_NUMSLIDER(llist, "'Hellfire' Intensity", "uc_cl_hellfire_intensity", nil, 0, 1)
			G_HELP(llist, "Multiplier for intensity of the muzzleflash projection.")
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
			
			local cat_2 = vgui.Create( "DCollapsibleCategory", llist )
			cat_2:SetLabel( "Colors" )
			cat_2:SetExpanded( false )
			cat_2:Dock( TOP )
			cat_2:DockMargin( 5, 5, 5, 0 )

			local llist_2 = vgui.Create( "DIconLayout", cat_2 )
			cat_2:SetContents( llist_2 )
			llist_2:Dock( FILL )
			llist_2:SetSpaceX( 10 )
			llist_2:SetSpaceY( 10 )
			llist_2:DockPadding( 5, 2, 5, 2 )

			G_LABEL(llist_2, "Crosshair Color")

			local colorpicker = vgui.Create( "DColorMixer", llist_2 )
			colorpicker:Dock( TOP )
			colorpicker:DockPadding( 0, 2, 0, 2 )
			colorpicker:SetPalette(false)
			colorpicker:SetAlphaBar(false)
			colorpicker:SetSize( 1000, 73 )
			do
				local touse1 = GetConVar("uc_x_col"):GetString()
				touse1 = string.Explode( " ", touse1 )
				colorpicker:SetColor( Color( touse1[1], touse1[2], touse1[3] ) )
			end
			function colorpicker:ValueChanged( col )
				RunConsoleCommand( "uc_x_col", col.r .. " " .. col.g .. " " .. col.b )
			end

			G_LABEL(llist_2, "Crosshair Shadow")

			local colorpicker = vgui.Create( "DColorMixer", llist_2 )
			colorpicker:Dock( TOP )
			colorpicker:DockPadding( 0, 2, 0, 2 )
			colorpicker:SetPalette(false)
			colorpicker:SetAlphaBar(false)
			colorpicker:SetSize( 1000, 73 )
			do
				local touse1 = GetConVar("uc_x_col_shad"):GetString()
				touse1 = string.Explode( " ", touse1 )
				colorpicker:SetColor( Color( touse1[1], touse1[2], touse1[3] ) )
			end
			function colorpicker:ValueChanged( col )
				RunConsoleCommand( "uc_x_col_shad", col.r .. " " .. col.g .. " " .. col.b )
			end
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
	["developer"]	= { text = "Developer",	func = function(panel)
		panel:AddControl("header", { description = "Development settings & utilities for Urban Coalition / Suburb weapons." })

		do
			local cat = vgui.Create( "DCollapsibleCategory", panel )
			cat:SetLabel( "Additional Information" )
			panel:AddPanel( cat )

			local llist = vgui.Create( "DIconLayout", panel )
			cat:SetContents( llist )
			llist:Dock( FILL )
			llist:SetSpaceX( 10 )
			llist:SetSpaceY( 10 )
			llist:DockPadding( 5, 2, 5, 2 )

			G_CHECKBOX(llist, "Debug Information", "uc_dev_debug")
			G_HELP(llist, "Enable debug overlays & messages.")
		end
		do
			local cat = vgui.Create( "DCollapsibleCategory", panel )
			cat:SetLabel( "Development" )
			panel:AddPanel( cat )

			local llist = vgui.Create( "DIconLayout", panel )
			cat:SetContents( llist )
			llist:Dock( FILL )
			llist:SetSpaceX( 10 )
			llist:SetSpaceY( 10 )
			llist:DockPadding( 5, 2, 5, 2 )

			local button = G_BUTTON(llist, "Reload Attachments")
			function button:DoClick()
				RunConsoleCommand("uc_dev_reloadatts")
			end

			local button = G_BUTTON(llist, "Reload Spawnmenu")
			function button:DoClick()
				RunConsoleCommand("spawnmenu_reload")
			end

			local button = G_BUTTON(llist, "Reload Languages")
			function button:DoClick()
				RunConsoleCommand("uc_dev_reloadlang")
			end
		end
	end },
}

hook.Add("PopulateToolMenu", "Suburb_Options", function()
    for menu, data in pairs(menus) do
        spawnmenu.AddToolMenuOption("Options", "Suburb", "suburb_menu_" .. menu, data.text, "", "", data.func)
    end
end)