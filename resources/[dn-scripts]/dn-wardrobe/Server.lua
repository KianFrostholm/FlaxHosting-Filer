ResourceName = GetCurrentResourceName()
CurrentVersion = LoadResourceFile(ResourceName, 'Version')

local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface('vRP')

vRPclient = Tunnel.getInterface('vRP', 'vRP')
vRPbsC = Tunnel.getInterface('vRP_barbershop', ResourceName)

if Config.General.CheckForUpdates then
    PerformHttpRequest('https://raw.githubusercontent.com/Wolxy/Wolxy-Garderobe/main/Resource%20Mappe/Wolxy-Garderobe/Version', function(Error, Version)
        if Version ~= CurrentVersion then
            print('')
            print('')
            print('^1-----------------------------------------------------')
            print('^1Ny version af: ' .. ResourceName .. ' er blevet udgivet!')
            print('^1Din version: ' .. CurrentVersion)
            print('^1Nyeste version: ' .. Version)
            print('^1Hent den seneste version her: https://github.com/Wolxy/Wolxy-Garderobe')
            print('^1-----------------------------------------------------')
            print('')
            print('')
        else
            print('^2-----------------------------------------------------')
            print('^2Din version af: ' .. ResourceName .. ' er den nyeste!')
            print('^2-----------------------------------------------------')
        end
    end)
end

RegisterNetEvent('Wolxy:Garderobe:OpenMenu')
AddEventHandler('Wolxy:Garderobe:OpenMenu', function()
    local Player = source
    local user_id = vRP.getUserId({Player})
    OpenGarderobe(Player, user_id)
end)

AddEventHandler('vRP:playerSpawn', function(user_id, Source, FirstSpawn)
    if FirstSpawn then
        CreateAreas(Source)
    end
end)

function OpenGarderobe(Player, user_id)
    vRP.getUData({user_id, 'vRP:home:wardrobe', function(Data)
        local Sets = json.decode(Data) or {}

        GarderobeMenu = {name = Config.Menus.Garderobe.Navn}

        if Config.Menus.Garderobe.Color ~= nil then
            GarderobeMenu.css = {
                header_color = Config.Menus.Garderobe.Color
            }
        end

        local Choose = function(Player, Choice)
            vRP.closeMenu({Player})

            OutfitMenu = {name = Config.Menus.Outfit.Prefix .. Choice}

            OutfitMenu[Config.Menus.Outfit.Buttons.Anvend.Name] = {
                function(Player, Choice2)
                    local Custom = Sets[Choice]
                    if Custom ~= nil then
                      vRPclient.setCustomization(Player, {Custom})

                      Wait(150)

                      vRP.getUData({user_id, 'vRP:head:overlay', function(Value)
                          if Value ~= nil then
                              local Custom = json.decode(Value)
                              vRPbsC.setOverlay(Player, {Custom, true})
                          end
                      end})

                      vRP.closeMenu({Player})
                    end
                end,
                Config.Menus.Outfit.Buttons.Anvend.Description
            }

            OutfitMenu[Config.Menus.Outfit.Buttons.Overskriv.Name] = {
                function(Player, Choice2)
                    vRPclient.getCustomization(Player, {}, function(Custom)
                        Sets[Choice] = Custom
                        vRP.setUData({user_id, 'vRP:home:wardrobe', json.encode(Sets)})

                        vRP.closeMenu({Player})

                        OpenGarderobe(Player, user_id)
                    end)
                end,
                Config.Menus.Outfit.Buttons.Overskriv.Description
            }

            OutfitMenu[Config.Menus.Outfit.Buttons.Slet.Name] = {
                function(Player, Choice2)
                    Sets[Choice] = nil
                    vRP.setUData({user_id, 'vRP:home:wardrobe', json.encode(Sets)})

                    vRP.closeMenu({Player})

                    OpenGarderobe(Player, user_id)
                end,
                Config.Menus.Outfit.Buttons.Slet.Description
            }

            OutfitMenu.onclose = function()
                OpenGarderobe(Player, user_id)
            end

            vRP.openMenu({Player, OutfitMenu})
        end
        
        GarderobeMenu[Config.Menus.Garderobe.Buttons.SaveNewOutfit.Name] = {
            function(Player, Choice)
                vRP.prompt({Player, 'Vælg et navn til dit nye outfit', '', function(Player, Name)
                    if string.len(Name) > 0 then
                        if Sets[Name] == nil then
                            vRPclient.getCustomization(Player, {}, function(Custom)
                                Sets[Name] = Custom
                                vRP.setUData({user_id, 'vRP:home:wardrobe', json.encode(Sets)})

                                vRP.closeMenu({Player})

                                OpenGarderobe(Player, user_id)
                            end)
                        else
                            NotifyPlayer(Player, Config.Notifications.Messages.NameUsed)
                        end
                    else
                        NotifyPlayer(Player, Config.Notifications.Messages.BadName)
                    end
                end})
            end,
            Config.Menus.Garderobe.Buttons.SaveNewOutfit.Description
        }

        for k, v in pairs(Sets) do
            GarderobeMenu[k] = {
                Choose,
                Config.Menus.Garderobe.Buttons.Outfit.Description
            }
        end

        vRP.openMenu({Player, GarderobeMenu})
    end})
end

function CreateAreas(Source)
    local Enter = function(Source, Area)
        TriggerClientEvent('Wolxy:Garderobe:OpenPrompt', Source)
    end

    local Leave = function(Source, Area)
        vRP.closeMenu({Source})
        TriggerClientEvent('Wolxy:Garderobe:RemoveOpenPrompt', Source)
    end

    local i = 0
    for _, v in pairs(Config.Locations) do
        vRP.setArea({Source, 'vRP:Garderobe:' .. i, v.X, v.Y, v.Z, v.Radius, v.Radius, Enter, Leave})

        if Config.Markers.Enabled then
            vRPclient.addMarker(Source, {v.X, v.Y, v.Z - 1.0, 1.0, 1.0, 0.5, Config.Markers.R, Config.Markers.G, Config.Markers.B, 255, 200.0})
        end

        if Config.Blips.Enabled then
            vRPclient.addBlip(Source, {v.X, v.Y, v.Z, Config.Blips.Type, Config.Blips.Color, Config.Blips.Navn})
        end

        i = i + 1
    end
end

function NotifyPlayer(Player, Notification)
    local System = string.lower(Config.Notifications.System)

    if System == 'vrp' then
        vRPclient.notify(Player, {Config.Notifications.vRPTypeColors[Notification.Type] .. Notification.Msg})
    elseif System == 'pnotify' then
        local pNotify_FirstLetter = {
            ['T'] = 'top',
            ['B'] = 'bottom'
        }

        local pNotify_SecondLetter = {
            ['L'] = 'Left',
            ['C'] = 'Center',
            ['R'] = 'Right'
        }

        local pNotify_Type = {
            ['fejl'] = 'error',
            ['success'] = 'success',
            ['info'] = 'info'
        }

        TriggerClientEvent('pNotify:SendNotification', Player, {
            text = Notification.Msg,
            timeout = Notification.Timeout,
            type = pNotify_Type[Notification.Type],
            layout = pNotify_FirstLetter[Notification.Location:sub(1, 1)] .. pNotify_SecondLetter[Notification.Location:sub(-1)],
            progressBar = Notification.ProgressBar
        })
    elseif System == 'mythic_notify' then
        local mythic_notify_Type = {
            ['fejl'] = 'error',
            ['success'] = 'success',
            ['info'] = 'inform'
        }

        TriggerClientEvent('mythic_notify:client:SendAlert', Player, {
            type = mythic_notify_Type[Notification.Type],
            text = Notification.Msg
        })
    elseif System == 't-notify' then
        local tNotify_FirstLetter = {
            ['T'] = 'top-',
            ['B'] = 'bottom-'
        }

        local tNotify_SecondLetter = {
            ['L'] = 'left',
            ['C'] = 'center',
            ['R'] = 'right'
        }

        local tNotify_Type = {
            ['fejl'] = 'error',
            ['success'] = 'success',
            ['info'] = 'info'
        }

        TriggerClientEvent('t-notify:client:Custom', Player, {
            style = tNotify_Type[Notification.Type],
            duration = Notification.Timeout,
            message = Notification.Msg,
            position = tNotify_FirstLetter[Notification.Location:sub(1, 1)] .. tNotify_SecondLetter[Notification.Location:sub(-1)]
        })
    elseif System == 'mb_notify' then
        local mb_notify_FirstLetter = {
            ['T'] = 'top',
            ['B'] = 'bottom'
        }

        local mb_notify_SecondLetter = {
            ['L'] = 'left',
            ['C'] = 'center',
            ['R'] = 'right'
        }

        local mb_notify_Type = {
            ['fejl'] = 'error',
            ['success'] = 'success',
            ['info'] = 'info'
        }

        TriggerClientEvent('mb_notify:sendNotification', Player, Notification.Msg, {
            type = mb_notify_Type[Notification.Type],
            duration = Notification.Timeout,
            vertical = mb_notify_FirstLetter[Notification.Location:sub(1, 1)],
            horizontal = mb_notify_SecondLetter[Notification.Location:sub(-1)]
        })
    else
        print('^1Ugyldigt notifikations system valgt. Fix venligst Config/Config.lua i resourcen: ' .. ResourceName)
    end
end