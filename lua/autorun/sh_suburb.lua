
if CLIENT then
	CreateClientConVar("uc_dev_aimcorrect", 0, false, false)
	CreateClientConVar("uc_cl_aimtoggle", 0, true, true)
end

CreateConVar( "uc_dev_debug", 0, FCVAR_REPLICATED, "Spit debug information" )

Suburb = {}

Suburb.debug = function() return GetConVar("uc_dev_debug"):GetBool() end
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


Suburb.HUToM = 0.0254

UC = {}
UC.sounds = {}
Ssnd = UC.sounds

local p0 = ")arccw_uc/common/"
UC.sounds.rottle = {
	p0.."cloth_1.ogg",
	p0.."cloth_2.ogg",
	p0.."cloth_3.ogg",
	p0.."cloth_4.ogg",
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

local function ScaleFOVByWidthRatio( fovDegrees, ratio )
	local halfAngleRadians = fovDegrees * ( 0.5 * math.pi / 180 )
	local t = math.tan( halfAngleRadians )
	t = t * ratio
	local retDegrees = ( 180 / math.pi ) * math.atan( t )
	return retDegrees * 2
end

function Suburb.FOVix( fov )
	return ScaleFOVByWidthRatio( fov, (ScrW and ScrW() or 4)/(ScrH and ScrH() or 3)/(4/3) )
end

function Suburb.getdamagefromrange( dmg_near, dmg_far, range_near, range_far, dist )
	local min, max = range_near, range_far
	local range = dist
	local XD = 0
	if range < min then
		XD = 0
	else
		XD = math.Clamp((range - min) / (max - min), 0, 1)
	end

	return math.ceil( Lerp( XD, dmg_near, dmg_far ) )
end


function Suburb.quickie(en)
	if istable(en) then
		return table.Random(en)
	else
		return en
	end
end