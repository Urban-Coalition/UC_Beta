
Suburb.AttTable = {}

function Suburb_ReloadAtts()
	-- Wipe the attachment list.
	table.Empty( Suburb.AttTable )

	-- Start generating every attachment

	-- Tell all clients to regenerate their gun's stats
end

function Suburb_LoadAtts()
end

function Suburb_GenAtt( tabl, name )
	assert( name, "No name given!" )
	assert( isstring(name), "Name given is not a string!" )
	assert( tabl, "Table is nil!" )
	assert( istable(tabl), "Table given is not a table!" )
	print( tabl, tabl.Name or "", name )
end

if SERVER then
	util.AddNetworkString( "Suburb_ATT_Install" )
	util.AddNetworkString( "Suburb_ATT_Toggle" )
end

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