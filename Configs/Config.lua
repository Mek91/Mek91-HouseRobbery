---------------------------------------------------------------------------------------------------------------------------
Mek91_HR = {}
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.Core = exports['qb-core']:GetCoreObject()
Mek91_HR.OnPlayerLoaded = "QBCore:Client:OnPlayerLoaded"
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.Language = EN -- | TR | EN | Select Language.
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.MinimumPolice = 3 -- Write Minimum Police Amount!
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.AddItem = true -- Should it be added as an item ? true = on
Mek91_HR.LockPickName = "lockpick" -- You will write the name of the black money item here and add it to the inventory.
---------------------------------------------------------------------------------------------------------------------------
Mek91_HR.Npc = {
    ["NpcList"] = { -- https://docs.fivem.net/docs/game-references/ped-models here you can choose the one you want...
        "a_f_o_salton_01",
        "a_m_m_beach_01",
        "a_m_m_genfat_01",
        "a_m_m_tranvest_01",
        "a_m_o_ktown_01",
        "a_m_y_hipster_02",
        "a_m_y_musclbeac_02",
        "a_m_y_stwhi_02",
        "csb_roccopelosi",
        "g_f_y_vagos_01",
        "g_m_importexport_01",
        "mp_f_chbar_01",
        "s_f_y_baywatch_01"
    },

    ["Weapons"] = { -- https://wiki.rage.mp/index.php?title=Weapons here you can choose the one you want...
        "weapon_assaultrifle_mk2",
        "weapon_sawnoffshotgun",
        "weapon_minismg",
        "weapon_pistol",
        "weapon_revolver_mk2",
        "weapon_combatmg",
        "weapon_microsmg"
    }
}
---------------------------------------------------------------------------------------------------------------------------
-- VERSION:         1.0.0
-- Discord:         mek91
-- Discord Server:  https://discord.gg/pGTVYrzM7U
-- Github:          https://github.com/Mek91
-- YouTube:         https://www.youtube.com/@mek91
---------------------------------------------------------------------------------------------------------------------------
-- LIBS: qb-core | qb-target | qb-progressbar | qb-skillbar or tgiann-skillbar |
---------------------------------------------------------------------------------------------------------------------------