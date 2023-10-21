
-- Urban Coalition: Muzzles

local att = {}
att.Name = "Magpul PTS AAC Masada Suppressor"
att.ShortName = "Masada Suppressor"
att.ShortNameSubtitle = "SUPPRESSOR"
att.Slot = "muzzle_suppressor"

att.Hook_Sound_Blast = UC.func.sound_blast
att.Hook_Sound_TailEXT = UC.func.sound_tailext
att.Hook_Sound_TailINT = UC.func.sound_tailint
att.Override_MuzzleEffect = "muzzleflash_suppressed"

att.Model = "models/weapons/arccw/atts/uc_magpul_masada.mdl"
att.ModelScale = Vector(1, 1, 1)

-- TODO: Suppressors should be gassy and make spent shells fly out with a bit of variance.
att.Add_SightTime = (4/60)
Suburb_GenAtt(att, "uc_muzzle_masada")

local att = {}
att.Name = "Muzzle Break"
att.ShortName = "Muzzle Break"
att.ShortNameSubtitle = "BREAK"
att.Slot = "muzzle_suppressor"

att.Override_MuzzleEffect = "muzzleflash_pistol_cleric"

att.Model = "models/weapons/arccw/atts/uc_magpul_masada.mdl"
att.ModelScale = Vector(1, 1, 1)

att.Add_SightTime = (2/60)
Suburb_GenAtt(att, "uc_muzzle_break")