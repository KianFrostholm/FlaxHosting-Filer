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
