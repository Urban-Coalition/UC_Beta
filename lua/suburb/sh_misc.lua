
-- Misc stuff that wouldn't fit anywhere else.

UC = {}
UC.sounds = {}
UC.func = {}
Ssnd = UC.sounds

local p0 = ")arccw_uc/common/"
local p1 = ")weapons/arccw_ud/glock/"
UC.sounds.rottle = {
	p0.."cloth_1.ogg",
	p0.."cloth_2.ogg",
	p0.."cloth_3.ogg",
	p0.."cloth_4.ogg",
	p0.."cloth_5.ogg",
	p0.."cloth_6.ogg",
	p0.."rattle.ogg",
}
UC.sounds.rattle = {
	p0.."rattle1.ogg",
	p0.."rattle2.ogg",
	p0.."rattle3.ogg",
}
UC.sounds.rattlepistol = {
	p0.."pistol_rattle_1.ogg",
	p0.."pistol_rattle_2.ogg",
	p0.."pistol_rattle_3.ogg",
}
UC.sounds.draw_pistol = {
	p1 .. "draw.ogg",
}
UC.sounds.draw_rifle = {
}
UC.sounds.draw_shotgun = {
}
UC.sounds.draw_heavy = {
}
UC.sounds.holster_pistol = {
}
UC.sounds.holster_rifle = {
}
UC.sounds.holster_shotgun = {
}
UC.sounds.holster_heavy = {
}
UC.sounds.supptailext = {
    { s = p0.."sup-tail-01.ogg" },
    { s = p0.."sup-tail-02.ogg" },
    { s = p0.."sup-tail-03.ogg" },
    { s = p0.."sup-tail-04.ogg" },
    { s = p0.."sup-tail-05.ogg" },
    { s = p0.."sup-tail-06.ogg" },
    { s = p0.."sup-tail-07.ogg" },
    { s = p0.."sup-tail-08.ogg" },
    { s = p0.."sup-tail-09.ogg" },
    { s = p0.."sup-tail-10.ogg" }
}
UC.sounds.supptailint = {
    { s = p0.."fire-dist-int-pistol-light-01.ogg" },
    { s = p0.."fire-dist-int-pistol-light-02.ogg" },
    { s = p0.."fire-dist-int-pistol-light-03.ogg" },
    { s = p0.."fire-dist-int-pistol-light-04.ogg" },
    { s = p0.."fire-dist-int-pistol-light-05.ogg" },
    { s = p0.."fire-dist-int-pistol-light-06.ogg" }
}

function UC.func.sound_blast( wep, result, default )
	return wep.Sound_Blast_Supp
end
function UC.func.sound_tailext( wep, result, default )
	return wep.Sound_TailEXT_Supp
end
function UC.func.sound_tailint( wep, result, default )
	return wep.Sound_TailINT_Supp
end

-- Garbage collector


if CLIENT then
suburb_garbagelist = suburb_garbagelist or {}
function Suburb_GC( item )
	table.insert( suburb_garbagelist, item )
	SDeP( "Added #" .. #suburb_garbagelist .. (item.Garbage_Name and (", " .. item.Garbage_Name) or "") .. " to the garbage list." )
end
local function collect()
	local ti = string.FormattedTime( CurTime() )
	SDeP( string.format( "[%02i:%02i:%02i] ", ti.h, ti.m, ti.s ) .. "Suburb is garbage collecting... " )
	local destroyed = 0
	for index, item in pairs( suburb_garbagelist ) do
		if !IsValid( item ) then
			SDeP( "#" .. index .. ": This item isn't valid, removing from list." )
			suburb_garbagelist[index] = nil
			continue
		end
		SDeP( "#" .. index .. (item.Garbage_Name and (", " .. item.Garbage_Name) or "") )
		if item.Garbage_Owner and !IsValid( item.Garbage_Owner ) then
			SDeP( "\tInvalid owner." )
		elseif item.Garbage_PlayerOwner and !IsValid( item.Garbage_PlayerOwner ) then
			SDeP( "\tInvalid player owner." )
		elseif item.Garbage_PlayerOwner and item.Garbage_Owner:GetOwner() != item.Garbage_PlayerOwner then
			SDeP( "\tOwner doesn't own this anymore." )
		else
			SDeP( "\tThis item is safe." )
			continue
		end
		SDeP( "\tRemoved!" )
		suburb_garbagelist[index] = nil
		item:Remove()
		destroyed = destroyed + 1
	end
	SDeP( "Suburb found " .. destroyed .. " objects to destroy." )
end

if timer.Exists( "Suburb_GarbageCollector" ) then timer.Remove( "Suburb_GarbageCollector" ) end
timer.Create( "Suburb_GarbageCollector", 30, 0, function()
	collect()
end)

end


-- Precache system

local sndtabs = {
	"Sound_Blast",
	"Sound_Mech",
	"Sound_TailEXT",
	"Sound_TailINT",
	"Sound_TailEXT_Supp",
	"Sound_TailINT_Supp",
}

local function DataCheck( w )
	if IsValid(w) and w.Suburb then
		print( "Suburb DataCheck: Testing " .. tostring(w) .. "..." )
		local bag = {}

		table.insert( bag, w.ViewModel )
		table.insert( bag, w.WorldModel )

		for i, liist in ipairs( sndtabs ) do
			if w[liist] then
				for index, event in ipairs( w[liist] ) do
					print( event.s )
				end
			end
		end

	end
end

if SERVER then
	concommand.Add("uc_test_datacheck_sv", function( ply ) DataCheck( ply ) end)
else
	concommand.Add("uc_test_datacheck_cl", function( ply ) DataCheck( ply ) end)
end
