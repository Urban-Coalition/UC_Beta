
-- Convars

CreateConVar( "uc_dev_debug", 0, FCVAR_REPLICATED, "Spit debug information" )


if CLIENT then
	
	-- Clientside stuff
	CreateClientConVar("uc_cl_cammult", 1, true, false)
	CreateClientConVar("uc_cl_aimtoggle", 0, true, true)
	CreateClientConVar("uc_dev_aimcorrect", 0, false, false)

	-- HUD
	CreateClientConVar("solar", 1)
	CreateClientConVar("solar_all", 0)
	CreateClientConVar("solar_armor", 0) -- Power or shield
end