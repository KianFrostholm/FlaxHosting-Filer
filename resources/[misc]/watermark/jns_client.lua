HT = nil

Citizen.CreateThread(function()
    while HT == nil do
        HT = {}
        Citizen.Wait(0)
    end

    HT.TriggerServerCallback('getPlayers', function(playerCount)
        while not NetworkIsSessionActive() do
            Citizen.Wait(0)
            print("Waiting")
        end
        print(playerCount)
        SendNUIMessage({action = "setPlayerCount", count = playerCount})
    end)
end)

RegisterNetEvent('vrp:playerLoaded')
AddEventHandler('vrp:playerLoaded', function()
TriggerServerEvent("getPlayers:check")
end)



RegisterNetEvent('getPlayers:done')
AddEventHandler('getPlayers:done', function(playerCount)
    SendNUIMessage({action = "setPlayerId", id = GetPlayerServerId(PlayerId())})
    SendNUIMessage({action = "setPlayerCount", count = playerCount})
end)


Citizen.CreateThread(function()
    while true do
        SendNUIMessage({action = "setPlayerCount", count = #GetActivePlayers()}) 
    Wait(600)
    end
end)
Citizen.CreateThread(function()
    while true do
        SendNUIMessage({action = "setPlayerId", id = GetPlayerServerId(PlayerId())}) 
    Wait(6000)
    end
end)