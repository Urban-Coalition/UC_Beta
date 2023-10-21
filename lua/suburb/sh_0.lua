
-- The world is born from zero.
-- Except Lua tables!

Suburb.debug = function() return GetConVar("uc_dev_debug"):GetBool() end
Suburb.HUToM = 0.0254

Suburb.Handmods_L = {
    "ValveBiped.Bip01_L_UpperArm",
    "ValveBiped.Bip01_L_Forearm",
    "ValveBiped.Bip01_L_Wrist",
    "ValveBiped.Bip01_L_Ulna",
    "ValveBiped.Bip01_L_Hand",
    "ValveBiped.Bip01_L_Finger4",
    "ValveBiped.Bip01_L_Finger41",
    "ValveBiped.Bip01_L_Finger42",
    "ValveBiped.Bip01_L_Finger3",
    "ValveBiped.Bip01_L_Finger31",
    "ValveBiped.Bip01_L_Finger32",
    "ValveBiped.Bip01_L_Finger2",
    "ValveBiped.Bip01_L_Finger21",
    "ValveBiped.Bip01_L_Finger22",
    "ValveBiped.Bip01_L_Finger1",
    "ValveBiped.Bip01_L_Finger11",
    "ValveBiped.Bip01_L_Finger12",
    "ValveBiped.Bip01_L_Finger0",
    "ValveBiped.Bip01_L_Finger01",
    "ValveBiped.Bip01_L_Finger02"
}

Suburb.Handmods_R = {
    "ValveBiped.Bip01_R_UpperArm",
    "ValveBiped.Bip01_R_Forearm",
    "ValveBiped.Bip01_R_Wrist",
    "ValveBiped.Bip01_R_Ulna",
    "ValveBiped.Bip01_R_Hand",
    "ValveBiped.Bip01_R_Finger4",
    "ValveBiped.Bip01_R_Finger41",
    "ValveBiped.Bip01_R_Finger42",
    "ValveBiped.Bip01_R_Finger3",
    "ValveBiped.Bip01_R_Finger31",
    "ValveBiped.Bip01_R_Finger32",
    "ValveBiped.Bip01_R_Finger2",
    "ValveBiped.Bip01_R_Finger21",
    "ValveBiped.Bip01_R_Finger22",
    "ValveBiped.Bip01_R_Finger1",
    "ValveBiped.Bip01_R_Finger11",
    "ValveBiped.Bip01_R_Finger12",
    "ValveBiped.Bip01_R_Finger0",
    "ValveBiped.Bip01_R_Finger01",
    "ValveBiped.Bip01_R_Finger02"
}

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