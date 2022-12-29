
CreateClientConVar("atp", 0, true, false)

local stance = 0

local pose_stand = { 24, -64, 64 }
local pose_duck = { 24, -48, 48 }

hook.Add("CalcView", "Awesomethirdperson", function( ply, pos, angles, fov )
	if GetConVar("atp"):GetBool() then
		local tang = angles
		local tpos = Vector()

		local tmod = { 0, 0, 0 }
		tmod[1] = Lerp( stance, pose_stand[1], pose_duck[1] )
		tmod[2] = Lerp( stance, pose_stand[2], pose_duck[2] )
		tmod[3] = Lerp( stance, pose_stand[3], pose_duck[3] )

		tpos:Add( tang:Right() * tmod[1] )
		tpos:Add( tang:Forward() * tmod[2] )
		tpos:Add( tang:Up() * tmod[3] )
		tpos:Add( ply:GetPos() )

		local view = {
			origin = tpos,
			angles = tang,
			fov = 75,
			drawviewer = true
		}

		stance = math.Approach( stance, ( ply:KeyDown( IN_DUCK ) ) and 1 or 0, FrameTime() / 0.2 )

		return view
	end
end)