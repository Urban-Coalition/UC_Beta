
-- Urban Coalition: Muzzles

-- Short
local att = {}
att.Name = "Magpul PTS AAC Masada Suppressor"
att.ShortName = "Masada Suppressor"
att.ShortNameSubtitle = "SUPPRESSOR"
att.Slot = "muzzle_suppressor"

function att.Hook_Sound_Blast( wep, result, default )
	return wep.Sound_Blast_Supp
end
function att.Hook_Sound_TailEXT( wep, result, default )
	return wep.Sound_TailEXT_Supp
end
function att.Hook_Sound_TailINT( wep, result, default )
	return wep.Sound_TailINT_Supp
end

att.Model = "models/weapons/arccw/atts/uc_magpul_masada.mdl"
att.ModelScale = Vector(1, 1, 1)
Suburb_GenAtt(att, "uc_muzzle_masada")