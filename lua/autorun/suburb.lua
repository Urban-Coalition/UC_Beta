
Suburb = {}

for _, v in pairs(file.Find("suburb/sh_*", "LUA")) do
	AddCSLuaFile( "suburb/" .. v )
	include( "suburb/" .. v )
	print( "Suburb: Loaded shared script " .. v )
end

for _, v in pairs(file.Find("suburb/cl_*", "LUA")) do
	AddCSLuaFile( "suburb/" .. v )
	if CLIENT then
		include( "suburb/" .. v )
		print( "Suburb: Loaded client script " .. v )
	end
end

if SERVER or game.SinglePlayer() then
	for _, v in pairs(file.Find("suburb/sv_*", "LUA")) do
		include( "suburb/" .. v )
		print( "Suburb: Loaded server script " .. v )
	end
end