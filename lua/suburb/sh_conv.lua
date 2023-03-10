
-- Convars

CreateConVar( "uc_dev_debug", 0, FCVAR_REPLICATED, "Spit debug information" )


if CLIENT then
	CreateClientConVar("uc_dev_aimcorrect", 0, false, false)
	CreateClientConVar("uc_cl_aimtoggle", 0, true, true)
	CreateClientConVar("newurb_enabled", 0)
end