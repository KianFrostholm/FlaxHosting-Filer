--[[
────────────────────────────────────────────────────────────────────────────────
─██████──██████─████████───██████──────────██████─████████████───██████████████─
─██░░██──██░░██─██░░░░██───██░░██████████──██░░██─██░░░░░░░░████─██░░░░░░░░░░██─
─██░░██──██░░██─████░░██───██░░░░░░░░░░██──██░░██─██░░████░░░░██─██░░██████████─
─██░░██──██░░██───██░░██───██░░██████░░██──██░░██─██░░██──██░░██─██░░██─────────
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██░░██████████─
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██░░░░░░░░░░██─
─██░░██──██░░██───██░░██───██░░██──██░░██──██░░██─██░░██──██░░██─██████████░░██─
─██░░░░██░░░░██───██░░██───██░░██──██░░██████░░██─██░░██──██░░██─────────██░░██─
─████░░░░░░████─████░░████─██░░██──██░░░░░░░░░░██─██░░████░░░░██─██████████░░██─
───████░░████───██░░░░░░██─██░░██──██████████░░██─██░░░░░░░░████─██░░░░░░░░░░██─
─────██████─────██████████─██████──────────██████─████████████───██████████████─
────────────────────────────────────────────────────────────────────────────────
Discord: https://discord.gg/ECUxET82SD
Youtube: https://www.youtube.com/channel/UCaBZGvYryg09IS-uaSHyfPw
Github: https://github.com/V1NDs
]]--

cfg = {}

--Liste med components: https://wiki.rage.mp/index.php?title=Weapons_Components.
cfg.attachments = {
    [1] = {
        item = "silencer",
        itemName = "Lyddæmper",
        description = "Gør dit våben mere stille når du skyder",
        weight = 0.5,
        components = {
            "COMPONENT_AT_PI_SUPP_02",
            "COMPONENT_AT_PI_SUPP",
            "COMPONENT_AT_AR_SUPP_02",
            "COMPONENT_AT_SR_SUPP",
            "COMPONENT_AT_AR_SUPP",
            "COMPONENT_AT_SR_SUPP_03"
        }
    },

    [2] = {
        item = "flashlight",
        itemName = "Våbenlygte",
        description = "Lygte til dit våben, så du kan se i mørket",
        weight = 0.35,
        components = {
            "COMPONENT_AT_PI_FLSH",
            "COMPONENT_AT_PI_FLSH_03",
            "COMPONENT_AT_PI_FLSH_02",
            "COMPONENT_AT_AR_FLSH"
        }
    },

    [3] = {
        item = "extendedclip",
        itemName = "Udvidet magasin",
        description = "Udvidet magasin til dit våben, kan holde en større mængde skud",
        weight = 0.85,
        components = {
            "COMPONENT_PISTOL_CLIP_02",
            "COMPONENT_COMBATPISTOL_CLIP_02",
            "COMPONENT_APPISTOL_CLIP_02",
            "COMPONENT_PISTOL50_CLIP_02",
            "COMPONENT_SNSPISTOL_CLIP_02",
            "COMPONENT_HEAVYPISTOL_CLIP_02",
            "COMPONENT_REVOLVER_MK2_CLIP_02",
            "COMPONENT_SNSPISTOL_MK2_CLIP_02",
            "COMPONENT_PISTOL_MK2_CLIP_02",
            "COMPONENT_VINTAGEPISTOL_CLIP_02",
            "COMPONENT_MICROSMG_CLIP_02",
            "COMPONENT_SMG_CLIP_02",
            "COMPONENT_ASSAULTSMG_CLIP_02",
            "COMPONENT_MINISMG_CLIP_02",
            "COMPONENT_SMG_MK2_CLIP_02",
            "COMPONENT_MACHINEPISTOL_CLIP_02",
            "COMPONENT_COMBATPDW_CLIP_02",
            "COMPONENT_ASSAULTSHOTGUN_CLIP_02",
            "COMPONENT_HEAVYSHOTGUN_CLIP_02",
            "COMPONENT_ASSAULTRIFLE_CLIP_02",
            "COMPONENT_CARBINERIFLE_CLIP_02",
            "COMPONENT_ADVANCEDRIFLE_CLIP_02",
            "COMPONENT_SPECIALCARBINE_CLIP_02",
            "COMPONENT_BULLPUPRIFLE_CLIP_02",
            "COMPONENT_BULLPUPRIFLE_MK2_CLIP_02",
            "COMPONENT_SPECIALCARBINE_MK2_CLIP_02",
            "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02",
            "COMPONENT_CARBINERIFLE_MK2_CLIP_02",
            "COMPONENT_COMPACTRIFLE_CLIP_02",
            "COMPONENT_MILITARYRIFLE_CLIP_02",
            "COMPONENT_MG_CLIP_02",
            "COMPONENT_COMBATMG_CLIP_02",
            "COMPONENT_COMBATMG_MK2_CLIP_02",
            "COMPONENT_GUSENBERG_CLIP_02",
            "COMPONENT_MARKSMANRIFLE_MK2_CLIP_02",
            "COMPONENT_HEAVYSNIPER_MK2_CLIP_02",
            "COMPONENT_MARKSMANRIFLE_CLIP_02"
        }
    },

    [4] = {
        item = "compensator",
        itemName = "Våben kompensator",
        description = "Våben kompensator et brugt til at formindske recoil",
        weight = 0.45,
        components = {
            "COMPONENT_AT_PI_COMP",
            "COMPONENT_AT_PI_COMP_02",
            "COMPONENT_AT_PI_COMP_03"
        }
    },

    [5] = {
        item = "smallscope",
        itemName = "Lille sigtekorn",
        description = "Et sigtekorn er brugt for en forøget præcision",
        weight = 0.25,
        components = {
            "COMPONENT_AT_SCOPE_MACRO_MK2",
            "COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
            "COMPONENT_AT_SCOPE_MACRO_02_MK2"
        }
    },

    [6] = {
        item = "meduimscope",
        itemName = "Mellem sigtekorn",
        description = "Et sigtekorn er brugt for en forøget præcision",
        weight = 0.35,
        components = {
            "COMPONENT_AT_SCOPE_SMALL_SMG_MK2",
            "COMPONENT_AT_SCOPE_SMALL_MK2"
        }
    },

    [7] = {
        item = "scope",
        itemName = "Normalt sigtekorn",
        description = "Et sigtekorn er brugt for en forøget præcision",
        weight = 0.45,
        components = {
            "COMPONENT_AT_SCOPE_MACRO",
            "COMPONENT_AT_SCOPE_MEDIUM",
            "COMPONENT_AT_SCOPE_SMALL",
            "COMPONENT_AT_SCOPE_SMALL_02",
            "COMPONENT_AT_SCOPE_LARGE",
            "COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM"
        }
    },

    [8] = {
        item = "largescope",
        itemName = "Stort sigtekorn",
        description = "Et sigtekorn er brugt for en forøget præcision",
        weight = 0.55,
        components = {
            "COMPONENT_AT_SCOPE_MEDIUM_MK2"
        }
    },

    [9] = {
        item = "advancedScope",
        itemName = "Advanceret sigtekorn",
        description = "Et sigtekorn er brugt for en forøget præcision",
        weight = 0.65,
        components = {
            "COMPONENT_AT_SCOPE_MAX"
        }
    },

    [10] = {
        item = "grip",
        itemName = "Våbengreb",
        description = "Et våbengreb er brugt for en forøget præcision og stabalisering af våbnet",
        weight = 0.75,
        components = {
            "COMPONENT_AT_AR_AFGRIP",
            "COMPONENT_AT_AR_AFGRIP_02"
        }
    }
}

return cfg
