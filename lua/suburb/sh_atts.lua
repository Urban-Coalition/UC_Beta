
Suburb.AttTable = {}

function Suburb_ReloadAtts()
	-- Wipe the attachment list.
	table.Empty( Suburb.AttTable )

	-- Start generating every attachment
	Suburb_LoadAtts()

	-- Tell all clients to regenerate their gun's stats
	--[[ for i, ent in ipairs( ents.GetAll() ) do
		if ent.Suburb then
			ent:RegenStats()
		end
	end ]]
end

local attpath = "suburb/attachments/"
function Suburb_LoadAtts()
	print( "Suburb is generating attachments..." )
	local r_files, r_dirs = file.Find( attpath .. "*", "LUA" )
	for _, item in ipairs( r_files ) do
		AddCSLuaFile( attpath .. item )
		include( attpath .. item )
	end
	print( "Suburb finished generating attachments." )
end

function Suburb_GenAtt( tabl, name )
	assert( name, "No name given!" )
	assert( isstring(name), "Name given is not a string!" )
	assert( tabl, "Table is nil!" )
	assert( istable(tabl), "Table given is not a table!" )
	print( " - " .. name .. " -- " .. tabl.Name or "[no nice name]" )

	-- Occassionally problematic.
	-- if Suburb.AttTable[name] then
	-- 	table.Empty( Suburb.AttTable[name] )
	-- end
	Suburb.AttTable[name] = tabl
end

if SERVER then
	util.AddNetworkString( "Suburb_ATT_Install" )
	util.AddNetworkString( "Suburb_ATT_Confirm" )
	util.AddNetworkString( "Suburb_ATT_Toggle" )
end

-- Deprecate this QUICK. SOON.
function QT( ... )
	local args = { ... }
	local tabb = {}
	for i, v in ipairs( args ) do
		tabb[v] = true
	end
	return tabb
end

--[[
if SERVER then
	Suburb.test = function( err )
		net.Start( "Suburb_ATT_Install" )
			net.WriteUInt( err or 0, 2 )
		net.Send( player.GetAll() )
	end
else
	net.Receive( "Suburb_ATT_Install", function( len, ply )
		local code = net.ReadUInt( 2 )
		assert(code, "No response code?!")
		if code == 0 then
			chat.AddText( "ATT: Installation successful!" )
		elseif code == 1 then
			chat.AddText( "ATT: Unknown error" )
		elseif code == 2 then
			chat.AddText( "ATT: Cannot install onto this slot" )
		elseif code == 3 then
			chat.AddText( "ATT: You don't own this attachment" )
		end
	end )
end
]]