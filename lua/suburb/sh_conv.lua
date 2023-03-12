
-- Convars

CreateConVar( "uc_dev_debug", 0, FCVAR_REPLICATED, "Spit debug information" )


if CLIENT then
	
	-- Clientside stuff
	CreateClientConVar("uc_cl_cammult", 1, true, false)
	CreateClientConVar("uc_cl_aimtoggle", 0, true, true, "Toggle aim.")
	CreateClientConVar("uc_cl_aimtoggle_reload", 0, true, true, "Exit sights after reloading?")
	CreateClientConVar("uc_cl_aimtoggle_sprint", 1, true, true, "Exit sights after sprinting?")
	CreateClientConVar("uc_dev_aimcorrect", 0, false, false)
	CreateClientConVar("uc_dev_debug", 0, false, false)
	CreateClientConVar("uc_cl_cheapscopes", 0, true, false, "Cheap scopes that zoom in your entire viewport instead of redrawing it.")
	CreateClientConVar("uc_cl_cheapmuzzles", 0, true, false, "Cheap HL2 muzzle effects.")

	-- HUD
	CreateClientConVar("solar", 1)
	CreateClientConVar("solar_all", 0)
	CreateClientConVar("solar_armor", 0) -- Power or shield
end