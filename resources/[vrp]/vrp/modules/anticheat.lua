local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")
local lang = vRP.lang

local cfg = module("cfg/anticheat")
local webhook = module("cfg/webhooks")

RegisterServerEvent('aopkfgebjzhfpazf77')
AddEventHandler('aopkfgebjzhfpazf77', function(reason,_)
    local source = source
    if source == nil then
        print("[aopkfgebjzhfpazf77] - Player source was nil.")
    end
    if not reason then reason = "Auto Anti-Cheat" end


    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        vRP.ban(user_id, 'Vores anticheat har udelukket dig med grunden: '..reason)
        print("Bannet"..user_id)
    end
    DropPlayer(source, 'Vores anticheat har udelukket dig med grunden: '..reason)
end)


AddEventHandler('playerConnecting', function (playerName,setKickReason)
    local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then   
                license = v  
        elseif string.sub(v, 1, string.len("steam:")) == "steam:" then   
                steamID = v
        elseif string.sub(v, 1, string.len("live:")) == "live:" then 
                liveid = v   
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then   
                xblid  = v   
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then   
                discord = v  
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                playerip = v
        end
    end
end)

local validResourceList
local function collectValidResourceList()
	validResourceList = {}
	for i=0,GetNumResources()-1 do
    	validResourceList[GetResourceByFindIndex(i)] = true
  	end
end

collectValidResourceList()
AddEventHandler("onResourceListRefresh", collectValidResourceList)
RegisterNetEvent("Pl:CmR")
AddEventHandler("Pl:CmR", function(givenList)
    for _, resource in ipairs(givenList) do
        if not validResourceList[resource] then
            TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
            FlaxLog(source, "Tried to inject a resource that is not listed","basic")
            break
        end
    end
end)

AddEventHandler("RemoveAllPedWeaponsEvent", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
    FlaxLog(source, "Remove Weapon","basic")
end)



AddEventHandler("RemoveAllPedWeaponsEvent", function(source, data)
    if data.ByType == false then
        CancelEvent()
        TriggerEvent("aopkfgebjzhfpazf77", "Fjern våben", source)
        FlaxLog(source, "Remove Weapon","basic")
    end
end)



AddEventHandler("RemoveAllPedWeapons", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", " Fjern våben", source)
    FlaxLog(source, "Remove Weapon","basic")
end)



AddEventHandler("ShootSingleBulletBetweenCoordsEvent", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
    FlaxLog(source, "Taze","basic")
end)



AddEventHandler("ShootSingleBulletBetweenEvent", function(source, data)
    if data.coords then
        CancelEvent()
        TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
        FlaxLog(source, "Taze","basic")
    end
end)



AddEventHandler("shootSingleBulletBetweenCoordsEvent", function(source, data)
    if data.givenAsPickup == false then
        CancelEvent()
        TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
        FlaxLog(source, "Taze","basic")
    end
end)



AddEventHandler("ResetPlayerStamina", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
    FlaxLog(source, "Stamina Reset","basic")
end)

AddEventHandler("SetSuperJumpThisFrame", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
    FlaxLog(source, "SuperJump","basic")
end)



AddEventHandler("AddAmmoToPed", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
    FlaxLog(source, "Add Ammo","basic")
end)

AddEventHandler("AddAmmoToPedEvent", function(source, data)
    if data.ByType then
        CancelEvent()
        TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
        FlaxLog(source, "Add Ammo","basic")
    end
end)



AddEventHandler("AddAmmoToPedEvent", function(source, data)
    if data.ByType == false then
        CancelEvent()
        TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
        FlaxLog(source, "Add Ammo","basic")
    end
end)



AddEventHandler("ShootSingleBulletBetweenCoords", function(source)
    CancelEvent()
    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
    FlaxLog(source, "Taze","basic")
end)

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

if cfg.EjerToolBan then
    RegisterServerEvent('RunCode:RunStringRemotelly')
    AddEventHandler('RunCode:RunStringRemotelly', function()
        TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", source)
        FlaxLog(source, "Ejer Tool","basic")
        CancelEvent()
    end)
end

if cfg.EjerToolBan then
    RegisterServerEvent('lanaporn:RunStringRemotelly')
    AddEventHandler('lanaporn:RunStringRemotelly', function()
        TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", source)
        FlaxLog(source, "Ejer Tool","basic")
        CancelEvent()
    end)
end
--[[
if cfg.EjerToolBan then
    AddEventHandler("*", function(eventName, ...)
        if string.find(eventName, "RunStringRemotely") then
            TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function "..eventName, source)
            FlaxLog(source, "Ejer Tool","basic")
        end
    end) 
end
]]
if cfg.AntiAdminAbuse then
    RegisterNetEvent('murtaza:fix')
    AddEventHandler('murtaza:fix', function()
        CancelEvent()
        DropPlayer(source, "🦈 "..cfg.AntiAdminAbuseKickMessage)
    end)
end

if cfg.AntiAdminAbuse then
    RegisterNetEvent('fix')
    AddEventHandler('fix', function()
        CancelEvent()
        DropPlayer(source, "🦈 "..cfg.AntiAdminAbuseKickMessage)
    end)
end

if cfg.AntiAdminAbuse then
    RegisterNetEvent('staff.revive')
    AddEventHandler('staff.revive', function()
        CancelEvent()
        DropPlayer(source, "🦈 "..cfg.AntiAdminAbuseKickMessage)
    end)
end

if cfg.ForceDiscord then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local discordIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()
    Wait(0)
    for _, v in pairs(identifiers) do
        if string.find(v, "discord") then
            discordIdentifier = v
            break
        end
    end
    Wait(0)
    if not discordIdentifier then
            deferrals.done("🦈 " .. cfg.ForceDiscordMessage)
                if cfg.ForceDiscordConsoleLogs then
                    print("^6ForceDiscord^0 " .. name .. " ^3Rejected for not using discord.")
                end
        else
            deferrals.done()
        end
     end
end
AddEventHandler("playerConnecting", OnPlayerConnecting)

if cfg.ForceSteam then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    local steamIdentifier
    local identifiers = GetPlayerIdentifiers(player)
    deferrals.defer()
    Wait(0)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steamIdentifier = v
            break
        end
    end
    Wait(0)
    if not steamIdentifier then
            deferrals.done("🦈 " .. cfg.ForceSteamMessage)
                if cfg.ForceSteamConsoleLogs then
                    print("^9ForceSteam^0 " .. name .. " ^7Rejected for not using steam.")
                end
        else
            deferrals.done()
        end
     end
end

AddEventHandler("playerConnecting", OnPlayerConnecting)

if cfg.ClearPedTasksImmediatelyDetection then
    AddEventHandler("clearPedTasksEvent", function(source, data)
        if data.immediately then
            CancelEvent()
            TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", source)
            FlaxLog(source, "ClearPedTasksImmediately","basic")
        end
    end)
end

FlaxLog = function(playerId, reason, typee)
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    if playerId == 0 then
        local name = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
        local reason = "YOU HAVE TRIGGERED A BLACKLISTED TRIGGER"
    else
    end
    local steamid = "Unknown"
    local license = "Unknown"
    local discord = "Unknown"
    local xbl = "Unknown"
    local liveid = "Unknown"
    local ip = "Unknown"
    if name == nil then
        name = "Unknown"
    end
    for k, v in pairs(GetPlayerIdentifiers(playerId)) do

        if string.sub(v, 1, string.len("steam:")) == "steam:" then

            steamid = v

        elseif string.sub(v, 1, string.len("license:")) == "license:" then

            license = v

        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then

            xbl = v

        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then

            ip = string.sub(v, 4)

        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then

            discordid = string.sub(v, 9)

            discord = "<@" .. discordid .. ">"

        elseif string.sub(v, 1, string.len("live:")) == "live:" then

            liveid = v

        end

    end



    local discordInfo = {

        ["color"] = "16752128",

        ["type"] = "rich",

        ["title"] = "Banned",

        ["description"] = "**Name : **" ..

            name ..

                "\n **Reason : **" ..

                    reason ..

                        "\n **ID : **" ..

                            playerId ..

                                "\n **IP : **" ..

                                    ip ..

                                        "\n **Steam Hex : **" ..

                                            steamid .. "\n **License : **" .. license .. "\n **Discord : **" .. discord,

        ["footer"] = {

            ["text"] = " FlaxAC "

        }

    }



    if name ~= "Unknown" then

        if typee == "basic" then

            PerformHttpRequest(

                webhook.Anticheat,

                function(err, text, headers)

                end,

                "POST",

                json.encode({username = " FlaxAC ", embeds = {discordInfo}}),

                {["Content-Type"] = "application/json"}

            )

        elseif typee == "model" then

            PerformHttpRequest(

                webhook.Anticheat,

                function(err, text, headers)

                end,

                "POST",

                json.encode({username = " FlaxAC ", embeds = {discordInfo}}),

                {["Content-Type"] = "application/json"}

            )

        elseif typee == "explosion" then

            PerformHttpRequest(

                webhook.Anticheat,

                function(err, text, headers)

                end,

                "POST",

                json.encode({username = " FlaxAC ", embeds = {discordInfo}}),

                {["Content-Type"] = "application/json"}

            )

        end

    end

end

ACStarted = function()

    local discordInfo = {

        ["color"] = "16752128",

        ["type"] = "rich",

        ["title"] = " FlaxAC Started",

        ["footer"] = {

            ["text"] = " FlaxAC "

        }

    }



    PerformHttpRequest(

        webhook.Anticheat,

        function(err, text, headers)

        end,

        "POST",

        json.encode({username = " FlaxAC ", embeds = {discordInfo}}),

        {["Content-Type"] = "application/json"}

    )

end

ACFailed = function()

end

--=====================================================--

RegisterServerEvent("fuhjizofzf4z5fza")
AddEventHandler("fuhjizofzf4z5fza", function(type, item)
    local _type = type or "default"
    local _item = item or "none"
    _type = string.lower(_type)
    if not IsPlayerAceAllowed(source, "Flaxacbypass") then
        if (_type == "default") then
            FlaxLog(source, "Unknown Reason","basic")
            TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
        elseif (_type == "godmode") then
            FlaxLog(source, "Tried to put in godmod","basic")
            TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
        elseif (_type == "esx") then
            if cfg.AntiESX then
                TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
            FlaxLog(source, "Injection Menu","basic")
        end
        elseif (_type == "spec")then
            TriggerEvent("aopkfgebjzhfpazf77", "Spectate", source)
            FlaxLog(source, "Spectate","basic")
        elseif (_type == "spectate") then
            TriggerEvent("aopkfgebjzhfpazf77", "Spectate", source)
            FlaxLog(source, "Spectate","basic")
        elseif (_type == "antiblips") then
            TriggerEvent("aopkfgebjzhfpazf77", "Blips", source)
            FlaxLog(source, "Blips","basic")
        elseif (_type == "blips") then
            TriggerEvent("aopkfgebjzhfpazf77", "Blips", source)
            FlaxLog(source, "Blips","basic")
        elseif (_type == "blipz") then
            TriggerEvent("aopkfgebjzhfpazf77", "Blips", source)
            FlaxLog(source, "Blips","basic")
        elseif (_type == "injection") then
            TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
            FlaxLog(source, "tried to execute the command " .. item,"basic")
        elseif (_type == "hash") then
            TriggerEvent("aopkfgebjzhfpazf77", "blacklisted køretøj", source)
            FlaxLog(source, "Tried to spawn a blacklisted car : " .. item,"basic")
        elseif (_type == "explosion") then
            TriggerEvent("aopkfgebjzhfpazf77", "explosion", source)
            FlaxLog(source, "Tried to spawn an explosion : " .. item,"basic")
        elseif (_type == "event") then
            TriggerEvent("aopkfgebjzhfpazf77", "blacklisted event", source)
            FlaxLog(source, "Tried to trigger a blacklisted event : " .. item,"basic")
        elseif (_type == "menu") then
            TriggerEvent("aopkfgebjzhfpazf77", "Indsat menu", source)
            FlaxLog(source, "Tried inject a menu in " .. item,"basic")
        elseif (_type == "functionn") then
            TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
            FlaxLog(source, "Tried to inject a function in " .. item,"basic")
        elseif (_type == "damagemodifier") then
            TriggerEvent("aopkfgebjzhfpazf77", "Våben skade", source)
            FlaxLog(source, "Tried to change his Weapon Damage : " .. item,"basic")
        elseif (_type == "malformedresource") then
            TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)
            FlaxLog(source, "Tried to inject a malformed resource : " .. item,"basic")
        end
    end
end)



Citizen.CreateThread(function()

    exploCreator = {}

    vehCreator = {}

    pedCreator = {}

    entityCreator = {}

    while true do

        Citizen.Wait(2500)

        exploCreator = {}

        vehCreator = {}

        pedCreator = {}

        entityCreator = {}

    end

end)



if cfg.ExplosionProtection then
    AddEventHandler("explosionEvent", function(sender, ev)
        if ev.damageScale ~= 0.0 then
            local BlacklistedExplosionsArray = {}

            for kkk, vvv in pairs(cfg.BlockedExplosions) do
                table.insert(BlacklistedExplosionsArray, vvv)
            end

            if inTable(BlacklistedExplosionsArray, ev.explosionType) ~= false then
                CancelEvent()
                FlaxLog(sender, "Tried to spawn a blacklisted explosion - type: " .. ev.explosionType, "explosion")
                TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", sender)
            else
                --FlaxLog(sender, "Tried to Explode a player", "explosion")
            end

            if ev.explosionType ~= 9 then
                exploCreator[sender] = (exploCreator[sender] or 0) + 1
                if exploCreator[sender] > 999 then
                    FlaxLog(sender, "Tried to spawn mass explosions - type: " .. ev.explosionType, "explosion")
                    TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", sender)
                    CancelEvent()
                end
            else
                exploCreator[sender] = (exploCreator[sender] or 0) + 1
                if exploCreator[sender] > 999 then
                    --FlaxLog(sender, "Tried to spawn mass explosions (gas pump)", "explosion")
                    --TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", sender)
                    CancelEvent()
                end
            end

            if ev.isAudible == false then
                FlaxLog(sender, "Tried to spawn silent explosion - type: " .. ev.explosionType, "explosion")
                TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", sender)
            end

            if ev.isInvisible == true then
                FlaxLog(sender, "Tried to spawn invisible explosion - type: " .. ev.explosionType, "explosion")
                TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", sender)
            end

            if ev.damageScale > 1.0 then
                FlaxLog(sender, "Tried to spawn oneshot explosion - type: " .. ev.explosionType, "explosion")
                TriggerEvent("aopkfgebjzhfpazf77", "Ban Reason:Blocked Function", sender)
            end

            CancelEvent()
        end
    end)
end


if cfg.GiveWeaponsProtection then

    AddEventHandler(

        "giveWeaponEvent",

        function(sender, data)

            if data.givenAsPickup == false then

                TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", sender)

                FlaxLog(sender, "Tried to give weapons to a player","basic")

                CancelEvent()

            end

        end

    )

end



if cfg.GiveWeaponAsPickupProtection then

    AddEventHandler(

        "giveWeaponEvent",

        function(sender, data)

            if data.givenAsPickup then

                TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", sender)

                FlaxLog(sender, "Tried to give weapons to a player as a pickup","basic")

                CancelEvent()

            end

        end

    )

end



if cfg.WordsProtection then

    AddEventHandler(

        "chatMessage",

        function(source, n, message)

            for k, n in pairs(cfg.BlacklistedWords) do

                if string.match(message:lower(), n:lower()) then

                    FlaxLog(source, "Tried to say : " .. n,"basic")

                    TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)

                end

            end

        end

    )

end



if cfg.TriggersProtection then

    for k, events in pairs(cfg.BlacklistedEvents) do

        RegisterServerEvent(events)

        AddEventHandler(

            events,

            function()

                FlaxLog(source, "Blacklisted event: " .. events,"basic")

                TriggerEvent("aopkfgebjzhfpazf77", "Blocked Function", source)

                CancelEvent()

            end

        )

    end

end



AddEventHandler(

    "entityCreating",

    function(entity)

        if DoesEntityExist(entity) then

            local src = NetworkGetEntityOwner(entity)

            local model = GetEntityModel(entity)

            local blacklistedPropsArray = {}

            local WhitelistedPropsArray = {}

            local eType = GetEntityPopulationType(entity)



            if src == nil then

                CancelEvent()

            end



            for bl_k, bl_v in pairs(cfg.BlacklistedModels) do

                table.insert(blacklistedPropsArray, GetHashKey(bl_v))

            end



            for wl_k, wl_v in pairs(cfg.WhitelistedProps) do

                table.insert(WhitelistedPropsArray, GetHashKey(wl_v))

            end



            if eType == 0 then

                CancelEvent()

            end



            if GetEntityType(entity) == 3 then

                if eType == 6 or eType == 7 then

                    if inTable(WhitelistedPropsArray, model) == false then

                        if model ~= 0 then

                            FlaxLog(src, "Tried to spawn a blacklisted prop : " .. model,"model")

                            TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Prop", src)

                            CancelEvent()



                            entityCreator[src] = (entityCreator[src] or 0) + 1

                            if entityCreator[src] > 15 then

                                FlaxLog(src, "Tried to spawn "..entityCreator[src].." entities","model")

                                TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Mass Entities", src)
                            end
                        end
                    end
                end
            else
                if GetEntityType(entity) == 2 then
                    if eType == 6 or eType == 7 then
                        if inTable(blacklistedPropsArray, model) ~= false then
                            if model ~= 0 then
                                FlaxLog(src, "Tried to spawn a blacklisted vehicle : " .. model,"model")
                                TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Blacklisted Vehicle", src)
                                CancelEvent()
                            end
                        end
                        vehCreator[src] = (vehCreator[src] or 0) + 1
                        if vehCreator[src] > 999 then
                            FlaxLog(src, "Tried to spawn "..vehCreator[src].." vehs","model")
                            TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Mass Vehs", src)
                        end
                    end
                elseif GetEntityType(entity) == 1 then
                    if eType == 6 or eType == 7 then
                        if inTable(blacklistedPropsArray, model) ~= false then
                            if model ~= 0 or model ~= 225514697 then
                                FlaxLog(src, "Tried to spawn a blacklisted ped : " .. model,"model")
                                TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Blacklisted Ped", src)
                                CancelEvent()
                            end
                        end
                        pedCreator[src] = (pedCreator[src] or 0) + 1
                        if pedCreator[src] > 999 then
                            FlaxLog(src, "Tried to spawn "..pedCreator[src].." peds","model")
                            TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Mass Peds", src)
                        end
                    end
                else
                    if inTable(blacklistedPropsArray, GetHashKey(entity)) ~= false then
                        if model ~= 0 or model ~= 225514697 then
                            FlaxLog(src, "Tried to spawn a model : " .. model,"model")
                            TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Blacklisted Model", src)
                            CancelEvent()
                        end
                    end
                end
            end
            if GetEntityType(entity) == 1 then
                if eType == 6 or eType == 7 or eType == 0 then
                    pedCreator[src] = (pedCreator[src] or 0) + 1
                    if pedCreator[src] > 15 then
                        FlaxLog(src, "Tried to spawn "..pedCreator[src].." peds","model")
                        TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Mass Peds", src)
                        CancelEvent()
                    end
                end
                elseif GetEntityType(entity) == 2 then
                if eType == 6 or eType == 7 or eType == 0 then
                    vehCreator[src] = (vehCreator[src] or 0) + 1
                    if vehCreator[src] > 999 then
                        FlaxLog(src, "Tried to spawn "..vehCreator[src].." vehs","model")
                        TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Mass Vehs", src)
                        CancelEvent()
                    end
                end
                elseif GetEntityType(entity) == 3 then
                if eType == 6 or eType == 7 or eType == 0 then
                    entityCreator[src] = (entityCreator[src] or 0) + 1
                    if entityCreator[src] > 100 then
                        FlaxLog(src, "Tried to spawn "..entityCreator[src].." entities","model")
                        TriggerEvent("aopkfgebjzhfpazf77", " ❓Ban Reason: Spawned Mass Entities", src)
                        CancelEvent()
                    end
                end
            end
        end
    end
)

function webhooklog(a, b, d, e, f)
    if cfg.AntiVPN then
        if webhook.Anticheat ~= "" or webhook.Anticheat ~= nil then
            PerformHttpRequest(
                webhook.Anticheat,
                function(err, text, headers)
                end,
                "POST",
                json.encode(
                    {
                        embeds = {
                            {
                                author = {name = " FlaxAC AntiVPN", url = "", icon_url = ""},
                                title = "Connection " .. a,
                                description = "**Player:** " .. b .. "\nIP: " .. d .. "\n" .. e,
                                color = f
                            }

                        }

                    }

                ),
                {["Content-Type"] = "application/json"}
            )
        else
            print("^6AntiVPN^0: ^1Discord Webhook link missing!^0")
        end
    end
end

if cfg.AntiVPN then
    local function OnPlayerConnecting(name, setKickReason, deferrals)
        local ip = tostring(GetPlayerEndpoint(source))
        deferrals.defer()
        Wait(0)
        deferrals.update("Checking VPN...")
        PerformHttpRequest(
            "https://blackbox.ipinfo.app/lookup/" .. ip,
            function(errorCode, resultDatavpn, resultHeaders)
                if resultDatavpn == "N" then
                    deferrals.done()
                else
                    print("^5[FlaxAC]^0: ^1Player ^0" .. name .. " ^1rejected for using a VPN, ^8IP: ^0" .. ip .. "^0")
                    if cfg.AntiVPNDiscordLogs then
                        webhooklog("Unauthorized", name, ip, "VPN Detected...", 16515843)
                    end
                    deferrals.done("🦈 "..cfg.AntiVPNMessage)
                end
            end
        )
    end
    AddEventHandler("playerConnecting", OnPlayerConnecting)
end

local Charset = {}
for i = 65, 90 do
    table.insert(Charset, string.char(i))
end
for i = 97, 122 do
    table.insert(Charset, string.char(i))
end

function RandomLetter(length)
    if length > 0 then
        return RandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    end
    return ""
end
