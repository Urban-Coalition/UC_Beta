
hook.Add("HandlePlayerLanding", "FESNOLAND", function( ply, velocity, onGround )
	ply:AnimSetGestureSequence( GESTURE_SLOT_JUMP, 0 )
	return true
end)

hook.Add("HandlePlayerJumping", "FESNOJUMP", function( ply, velocity )
	ply:AnimSetGestureSequence( GESTURE_SLOT_JUMP, 0 )
	return true
end)