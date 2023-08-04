
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