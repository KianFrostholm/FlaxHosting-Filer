local cfg = {}

cfg.WeaponProtection = true -- Enable blacklisted weapons
cfg.TriggersProtection = true -- Enable blacklisted events
cfg.WordsProtection = false -- Enable blacklisted words
cfg.GiveWeaponsProtection = true -- Enable give weapon
cfg.ExplosionProtection = true -- Enable blacklisted explosions
cfg.GiveWeaponAsPickupProtection = false -- Give Weapons as pickup
cfg.DamageModifierDetection = true -- banning people that are trying to change damage scale
cfg.DumpDetection = true -- banning people that trying to dump the server
cfg.InvisibilityDetection = false -- people cant be invisible when this is enabled
cfg.SpectateDetection = true -- banning people that trying to spectate
cfg.PickupDetection = true -- deleting pickups like armor and med kits

cfg.AntiBlips = true -- Detecting people that are trying to use player blips
cfg.AntiSpectate = true -- Detecting people that are trying to spectate people
cfg.AntiESX = true -- Only enable this on vrp servers!

--// License //--
cfg.LicenseOwner = "CHANGE ME" -- the discord name of the person that bought the anticheat. (cannot be seen by other)

--// Custom //--
cfg.ForceDiscord = false -- Forcing people to have fivem connected to discord (Highly Recommended because most of cheaters does not have fivem connected with discord)
cfg.ForceDiscordMessage = "Discord is required to join this server."
cfg.ForceDiscordConsoleLogs = true

cfg.ForceSteam = true -- Forcing people to have steam open (Recommended for whitelisted servers)
cfg.ForceSteamMessage = "Steam is required to join this server."
cfg.ForceSteamConsoleLogs = true

cfg.AntiVPN = false -- Detects if someone have VPN on. (Recommended for whitelisted servers)
cfg.AntiVPNMessage = "VPN er ikke tilladt på vores server."
cfg.AntiVPNDiscordLogs = true

cfg.BanReason = "Banned. Kontakt os over vores discord hvis du tænker dette er en fejl | https://discord.gg/GyN4mDkyWg" -- you can edit this uwu

cfg.EjerToolBan = true -- for danish servers only.
 
cfg.AntiAdminAbuse = false -- kicking admins that are trying to abuse their rank (only recommended for danish servers)
cfg.AntiAdminAbuseKickMessage = "AntiAdminAbuse is enabled"

cfg.MaxWeaponAmmo = 251 -- max weapon ammo

cfg.DisableAllWeapons = false -- removing all weapons from players

cfg.AntiVDM = true -- setting damage scale for vehicles to 0

cfg.TeleportKick = false -- kicking people that are teleporting

cfg.DisableAllUnits = false -- deleting all units on the server

--// ClearPedTasksImmediately //--
cfg.ClearPedTasksImmediatelyDetection = true -- Automatically detect ClearPedTasksImmediately (detect cheaters that are kicking out of vehicles other players) NEW!
cfg.ClearPedTasksImmediatelyKick = false -- kick
cfg.ClearPedTasksImmediatelyBan = true -- ban

--// Resource Stuff //--
cfg.ResourceStopDetection = true -- banning people that are trying to stop client sided resources

--// Blacklisted Commands //--
cfg.BlacklistedCommands = {
    '//',
	'killmenu',
	'dd'
}

--// Blacklisted Explosions //--
cfg.BlockedExplosions = {
    0, -- Grenade
    1, -- GrenadeLauncher
    3, -- Molotov
    4, -- Rocket
    6, -- Hi_Octane
    15, -- Boat
    16, -- Ship_Destroy
    18, -- Bullet
    22, -- Flare
    25, -- Programmablear
    26, -- Train
    27, -- Barrel
    --28, -- PROPANE
    29, -- Blimp
    32, -- PlaneRocket
    33, -- VehicleBullet
    35, -- FireWork
    36, -- SnowBall
    37, -- ProxMine
    38, -- Valkyrie_Cannon
}

--// BlacklistedWords //--
cfg.BlacklistedWords = {
    "Desudo",
	"Nigga",
	"ChocoHax",
	"WaveShield",
	"EulenCheats",
	"RedENGINE",
	"Neger",
	"N1gga",
	"Alokas",
	"HamMafia",
	"SkullExec",
	
}

--// Blacklisted Weapons //--
cfg.BlacklistedWeapons = {
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_MG",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_MINIGUN",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_RAILGUN",
	"WEAPON_FIREWORK",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_RPG",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_PIPEBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_MOLOTOV",
	"WEAPON_STICKYBOMB",
    "VEHICLE_WEAPON_ROTORS",
    "VEHICLE_WEAPON_TANK",
    "VEHICLE_WEAPON_SPACE_ROCKET",
    "VEHICLE_WEAPON_PLANE_ROCKET",
    "VEHICLE_WEAPON_PLAYER_LAZER",
    "VEHICLE_WEAPON_PLAYER_LASER",
    "VEHICLE_WEAPON_PLAYER_BULLET",
    "VEHICLE_WEAPON_PLAYER_BUZZARD",
    "VEHICLE_WEAPON_PLAYER_HUNTER",
    "VEHICLE_WEAPON_ENEMY_LASER",
    "VEHICLE_WEAPON_SEARCHLIGHT",
    "VEHICLE_WEAPON_RADAR",
    "VEHICLE_WEAPON_TURRET_INSURGENT",
    "VEHICLE_WEAPON_TURRET_TECHNICAL",
    "VEHICLE_WEAPON_NOSE_TURRET_VALKYRIE",
    "VEHICLE_WEAPON_PLAYER_SAVAGE",
    "VEHICLE_WEAPON_TURRET_LIMO",
    "VEHICLE_WEAPON_CANNON_BLAZER",
    "VEHICLE_WEAPON_TURRET_BOXVILLE",
    "VEHICLE_WEAPON_RUINER_BULLET",
    "PICKUP_VEHICLE_WEAPON_ASSAULTSMG",
    "PICKUP_VEHICLE_WEAPON_PISTOL50",
    "PICKUP_AMMO_BULLET_MP",
    "PICKUP_AMMO_MISSILE_MP",
    "PICKUP_AMMO_GRENADELAUNCHER_MP",
    "PICKUP_WEAPON_ASSAULTRIFLE",
    "PICKUP_WEAPON_CARBINERIFLE",
    "PICKUP_WEAPON_ADVANCEDRIFLE",
    "PICKUP_WEAPON_MG",
    "PICKUP_WEAPON_COMBATMG",
    "PICKUP_WEAPON_SNIPERRIFLE",
    "PICKUP_WEAPON_HEAVYSNIPER",
    "PICKUP_WEAPON_MICROSMG",
    "PICKUP_WEAPON_SMG",
    "PICKUP_ARMOUR_STANDARD",
    "PICKUP_WEAPON_RPG",
    "PICKUP_WEAPON_MINIGUN",
    "PICKUP_HEALTH_STANDARD",
    "PICKUP_WEAPON_SAWNOFFSHOTGUN",
    "PICKUP_WEAPON_ASSAULTSHOTGUN",
    "PICKUP_WEAPON_GRENADE",
    "PICKUP_WEAPON_MOLOTOV",
    "PICKUP_WEAPON_SMOKEGRENADE",
    "PICKUP_WEAPON_STICKYBOMB",
    "PICKUP_WEAPON_APPISTOL",
    "PICKUP_WEAPON_GRENADELAUNCHER",
    "PICKUP_MONEY_VARIABLE",
    "PICKUP_WEAPON_STUNGUN",
    "PICKUP_WEAPON_FIREEXTINGUISHER",
    "PICKUP_WEAPON_PETROLCAN",
    "PICKUP_WEAPON_GolfClub",
    "PICKUP_WEAPON_CROWBAR",
    "PICKUP_HANDCUFF_KEY",
    "PICKUP_CUSTOM_SCRIPT",
    "PICKUP_CAMERA",
    "PICKUP_PORTABLE_PACKAGE",
    "PICKUP_PORTABLE_CRATE_UNFIXED",
    "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR",
    "PICKUP_MONEY_CASE",
    "PICKUP_MONEY_WALLET",
    "PICKUP_MONEY_PURSE",
    "PICKUP_MONEY_DEP_BAG",
    "PICKUP_MONEY_MED_BAG",
    "PICKUP_MONEY_PAPER_BAG",
    "PICKUP_MONEY_SECURITY_CASE",
    "PICKUP_VEHICLE_WEAPON_APPISTOL",
    "PICKUP_VEHICLE_WEAPON_PISTOL",
    "PICKUP_VEHICLE_WEAPON_GRENADE",
    "PICKUP_VEHICLE_WEAPON_MOLOTOV",
    "PICKUP_VEHICLE_WEAPON_SMOKEGRENADE",
    "PICKUP_VEHICLE_WEAPON_STICKYBOMB",
    "PICKUP_VEHICLE_HEALTH_STANDARD",
    "PICKUP_VEHICLE_ARMOUR_STANDARD",
    "PICKUP_VEHICLE_WEAPON_MICROSMG",
    "PICKUP_VEHICLE_WEAPON_SMG",
    "PICKUP_VEHICLE_WEAPON_SAWNOFF",
    "PICKUP_VEHICLE_CUSTOM_SCRIPT",
    "PICKUP_VEHICLE_MONEY_VARIABLE",
    "PICKUP_SUBMARINE",
    "PICKUP_HEALTH_SNACK",
    "PICKUP_AMMO_MG",
    "PICKUP_AMMO_GRENADELAUNCHER",
    "PICKUP_AMMO_RPG",
    "PICKUP_AMMO_MINIGUN",
    "PICKUP_WEAPON_BULLPUPRIFLE",
    "PICKUP_WEAPON_BOTTLE",
    "PICKUP_WEAPON_SNSPISTOL",
    "PICKUP_WEAPON_GUSENBERG",
    "PICKUP_WEAPON_SPECIALCARBINE",
    "PICKUP_WEAPON_DAGGER",
    "PICKUP_WEAPON_FIREWORK",
    "PICKUP_WEAPON_MUSKET",
    "PICKUP_AMMO_FIREWORK",
    "PICKUP_AMMO_FIREWORK_MP",
    "PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE",
    "PICKUP_WEAPON_HEAVYSHOTGUN",
    "PICKUP_WEAPON_MARKSMANRIFLE",
    "PICKUP_GANG_ATTACK_MONEY",
    "PICKUP_WEAPON_PROXMINE",
    "PICKUP_WEAPON_HOMINGLAUNCHER",
    "PICKUP_AMMO_HOMINGLAUNCHER",
    "PICKUP_WEAPON_FLAREGUN",
    "PICKUP_AMMO_FLAREGUN",
    "PICKUP_WEAPON_MARKSMANPISTOL",
}

--// Blacklisted Models //--
cfg.BlacklistedModels = { -- Peds/Vehicles
	--VEHICLES
	"RHINO",
	"KHANJALI",
	"HUNTER",
	"CARGOBOB",
	"CARGOBOB2",
	"CARGOBOB3",
	"CARGOBOB4",
	"AKULA",
	"CHERNOBOG",
	"THRUSTER",
	"MINITANK",
	"APC",
	"DUMP",
	"LAZER",
	"JET",
	"HYDRA",
	"CARGOPLANE",
	"TITAN",

	-- PEDS
	's_m_y_swat_01',
	'u_m_y_zombie_01',
	'a_m_o_acult_01',
	'ig_wade',
	's_m_y_hwaycop_01',
	'A_M_Y_ACult_01',
	's_m_m_movalien_01',
	's_m_m_movallien_01',
	'u_m_y_babyd',
	'CS_Orleans',
	'A_M_Y_ACult_01',
	'S_M_M_MovSpace_01',
	'U_M_Y_Zombie_01',
	's_m_y_blackops_01',
	'a_f_y_topless_01',
	'a_c_boar',
	'a_c_cat_01',
	'a_c_chickenhawk',
	'a_c_chimp',
	's_f_y_hooker_03',
	'a_c_chop',
	'a_c_cormorant',
	'a_c_cow',
	'a_c_coyote',
	'a_c_crow',
	'a_c_dolphin',
	'a_c_fish',
	's_f_y_hooker_01',
	'a_c_hen',
	'a_c_humpback',
	'a_c_husky',
	'a_c_killerwhale',
	'a_c_mtlion',
	'a_c_pigeon',
	'a_c_poodle',
	'a_c_pug',
	'a_c_rabbit_01',
	'a_c_rat',
	'a_c_retriever',
	'a_c_rhesus',
	'a_c_rottweiler',
	'a_c_sharkhammer',
	'a_c_sharktiger',
	'a_c_shepherd',
	'a_c_stingray',
	'a_c_westy',
	'CS_Orleans',
	'p_crahsed_heli_s',
	'u_m_m_jesus_01',
	'u_m_y_imporage',
	'u_m_y_juggernaut_01',
	'mp_m_weapexp_01',
	'ig_chef2',
	'mp_m_bogdangoon',
	'a_m_y_hasjew_01',
}

cfg.WhitelistedProps = {
	"", -- does not work :/
}

--// Blacklisted Events //--
cfg.BlacklistedEvents = {
	"esx_vehicleshop:setVehicleOwned",
	"esx_mafiajob:confiscatePlayerItem",
	"vrp_slotmachine:server:2",
	"delivery:success1",
	"trucker:success",
	"Banca:deposit",
	"esx_jobs:caution",
	"give_back",
	"esx_fueldelivery:pay",
	"esx_carthief:pay",
	"esx_godirtyjob:pay",
	"esx_pizza:pay",
	"antilynx8:anticheat",
	"antilynxr6:detection",
	"esx_ranger:pay",
	"esx_garbagejob:pay",
	"esx_truckerjob:pay",
	"redst0nia:checking",
	"AdminMenu:giveBank",
	"AdminMenu:giveCash",
	"esx_gopostaljob:pay",
	"esx_banksecurity:pay",
	"esx_slotmachine:sv:2",
	"NB:recruterplayer",
	"esx_billing:sendBill",
	"esx_jailer:sendToJail",
	"esx_jail:sendToJail",
	"js:jailuser",
	"esx-qalle-jail:jailPlayer",
	"esx_dmvschool:pay", 
	"OG_cuffs:cuffCheckNearest",
	"CheckHandcuff",
	"cuffServer",
	"PICKUP_HEALTH_STANDARD",
	"cuffGranted",
	"police:cuffGranted",
	"esx_handcuffs:cuffing",
	"esx_policejob:handcuff",
	"esx_skin:responseSaveSkin",
	"esx_dmvschool:addLicense",
	"esx_mechanicjob:startCraft",
	"esx_drugs:startHarvestWeed",
	"esx_drugs:startTransformWeed",
	"esx_drugs:startSellWeed",
	"esx_drugs:startHarvestCoke",
	"esx_drugs:startTransformCoke",
	"esx_drugs:startSellCoke",
	"esx_drugs:startHarvestMeth",
	"esx_drugs:startTransformMeth",
	"esx_drugs:startSellMeth",
	"esx_drugs:startHarvestOpium",
	"esx_drugs:startSellOpium",
	"esx_drugs:startTransformOpium",
	"esx_blanchisseur:startWhitening",
	"esx_drugs:stopHarvestCoke",
	"esx_drugs:stopTransformCoke",
	"esx_drugs:stopSellCoke",
	"esx_drugs:stopHarvestMeth",
	"esx_drugs:stopTransformMeth",
	"esx_drugs:stopSellMeth",
	"esx_drugs:stopHarvestWeed",
	"esx_drugs:stopTransformWeed",
	"esx_drugs:stopSellWeed",
	"esx_drugs:stopHarvestOpium",
	"esx_drugs:stopTransformOpium",
	"esx_drugs:stopSellOpium",
	"esx_society:openBossMenu",
	"esx_jobs:caution",
	"esx_tankerjob:pay",
	"esx_vehicletrunk:giveDirty",
	"gambling:spend",
	"AdminMenu:giveDirtyMoney",
	"esx_moneywash:deposit",
	"esx_moneywash:withdraw",
	"mission:completed",
	"99kr-burglary:addMoney",
	"esx_jailer:unjailTime",
	"esx_ambulancejob:revive",
	"DiscordBot:playerDied",
	"hentailover:xdlol",
	"antilynx8:anticheat",
	"antilynxr6:detection",
	"esx:getSharedObject", -- anti injection!
	"esx_society:getOnlinePlayers",
	"antilynx8r4a:anticheat",
	"antilynxr4:detect",
	"js:jailuser", 
	"ynx8:anticheat",
	"lynx8:anticheat",
	"adminmenu:allowall",
	"h:xd",
	"ljail:jailplayer",
	"adminmenu:setsalary",
	"adminmenu:cashoutall",
	"paycheck:bonus",
	"HCheat:TempDisableDetection",
	"esx_drugs:pickedUpCannabis",
	"esx_drugs:processCannabis",
	"esx-qalle-hunting:reward",
	"esx-qalle-hunting:sell",
	"esx_mecanojob:onNPCJobCompleted",
	"BsCuff:Cuff696999",
	"esx_carthief:alertcops",
	"mellotrainer:adminTempBan",
	"mellotrainer:adminKick",
	"esx_society:putVehicleInGarage",
}

return cfg
