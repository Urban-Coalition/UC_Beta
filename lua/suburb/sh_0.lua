
-- The world is born from zero.
-- Except Lua tables!

Suburb.debug = function() return GetConVar("uc_dev_debug"):GetBool() end
Suburb.HUToM = 0.0254

function SDe()
	return GetConVar("uc_dev_debug"):GetInt()
end

function SDeP( ... )
	if SDe()>0 then
		return print( ... )
	end
end

local function ScaleFOVByWidthRatio( fovDegrees, ratio )
	local halfAngleRadians = fovDegrees * ( 0.5 * math.pi / 180 )
	local t = math.tan( halfAngleRadians )
	t = t * ratio
	local retDegrees = ( 180 / math.pi ) * math.atan( t )
	return retDegrees * 2
end

function Suburb.FOVix( fov, cw, ch )
	return ScaleFOVByWidthRatio( fov, (cw or (ScrW and ScrW()) or 4)/(ch or (ScrH and ScrH()) or 3)/(4/3) )
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