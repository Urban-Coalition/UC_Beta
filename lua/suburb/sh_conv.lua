
-- Convars

if SERVER then
	util.AddNetworkString( "suburb_cl_reloadatts" )
else
	net.Receive("suburb_cl_reloadatts", function()
		Suburb_ReloadAtts()
	end)
end

concommand.Add( "uc_dev_reloadatts", function()
	Suburb_ReloadAtts()
	if SERVER then
		net.Start("suburb_cl_reloadatts")
		net.Send( player.GetAll() )
	end
end)


if CLIENT then
	-- Clientside stuff
	CreateClientConVar("uc_cl_cammult", 1, true, false)
	CreateClientConVar("uc_cl_aimtoggle", 0, true, true, "Toggle aim.")
	CreateClientConVar("uc_cl_aimtoggle_reload", 0, true, true, "Exit sights after reloading?")
	CreateClientConVar("uc_cl_aimtoggle_sprint", 1, true, true, "Exit sights after sprinting?")
	CreateClientConVar("uc_cl_cheapscopes", 0, true, false, "Cheap scopes that zoom in your entire viewport instead of redrawing it.")
	CreateClientConVar("uc_cl_cheapmuzzles", 0, true, false, "Cheap HL2 muzzle effects.")

	CreateClientConVar("uc_x_col", "255 255 255 255", true, false, "Crosshair color.")
	CreateClientConVar("uc_x_col_shad", "0 0 0 255", true, false, "Crosshair shadowcolor.")

	-- Debug & developer
	CreateClientConVar("uc_dev_aimcorrect", 0, false, false, "Sway the gun around to get SWEP.SwayCorrection correct yourself")
	CreateClientConVar("uc_dev_debug", 0, false, false, "Spit debug information")

	-- HUD
	CreateClientConVar("solar", 1)
	CreateClientConVar("solar_all", 0)
	CreateClientConVar("solar_armor", 0) -- Power or shield
end