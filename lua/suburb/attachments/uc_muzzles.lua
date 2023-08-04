
-- Urban Coalition: Muzzles

-- Short
local att = {}
att.Name = "Magpul PTS AAC Masada Suppressor"
att.ShortName = "Masada Suppressor"
att.ShortNameSubtitle = "SUPPRESSOR"
att.Slot = "muzzle_suppressor"

att.Hook_Sound_Blast = UC.func.sound_blast
att.Hook_Sound_TailEXT = UC.func.sound_tailext
att.Hook_Sound_TailINT = UC.func.sound_tailint

att.Model = "models/weapons/arccw/atts/uc_magpul_masada.mdl"
att.ModelScale = Vector(1, 1, 1)
Suburb_GenAtt(att, "uc_muzzle_masada")