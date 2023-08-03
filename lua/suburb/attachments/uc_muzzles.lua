
-- Urban Coalition: Muzzles

-- Short
local att = {}
att.Name = "Magpul PTS AAC Masada Suppressor"
att.ShortName = "Masada Suppressor"
att.ShortNameSubtitle = "SUPPRESSOR"
att.Slot = "muzzle_suppressor"

local path = ")weapons/arccw_ud/m16/"
att.Override_Sound_Blast = {
    { s = path .. "fire-sup-01.ogg" },
    { s = path .. "fire-sup-02.ogg" },
    { s = path .. "fire-sup-03.ogg" },
    { s = path .. "fire-sup-04.ogg" },
    { s = path .. "fire-sup-05.ogg" },
    { s = path .. "fire-sup-06.ogg" }
}
local common = ")/arccw_uc/common/"
att.Override_Sound_TailEXT = {
    { s = common .. "sup-tail-01.ogg" },
    { s = common .. "sup-tail-02.ogg" },
    { s = common .. "sup-tail-03.ogg" },
    { s = common .. "sup-tail-04.ogg" },
    { s = common .. "sup-tail-05.ogg" },
    { s = common .. "sup-tail-06.ogg" },
    { s = common .. "sup-tail-07.ogg" },
    { s = common .. "sup-tail-08.ogg" },
    { s = common .. "sup-tail-09.ogg" },
    { s = common .. "sup-tail-10.ogg" }
}
att.Override_Sound_TailINT = {
    { s = common .. "fire-dist-int-pistol-light-01.ogg" },
    { s = common .. "fire-dist-int-pistol-light-02.ogg" },
    { s = common .. "fire-dist-int-pistol-light-03.ogg" },
    { s = common .. "fire-dist-int-pistol-light-04.ogg" },
    { s = common .. "fire-dist-int-pistol-light-05.ogg" },
    { s = common .. "fire-dist-int-pistol-light-06.ogg" }
}

att.Model = "models/weapons/arccw/atts/uc_magpul_masada.mdl"
att.ModelScale = Vector(1, 1, 1)
Suburb_GenAtt(att, "uc_muzzle_masada")