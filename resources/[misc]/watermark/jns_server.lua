HT = {}

TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)


HT.RegisterServerCallback('getPlayers', function(playerCount, cb)
    local playerCount = GetNumPlayerIndices()
    cb(playerCount)
end)

HT.RegisterServerCallback('getPlayers2', function(playerCount, cb)
    local playerCount = GetNumPlayerIndices()
    cb(playerCount)
end)

RegisterNetEvent('getPlayers:check')
AddEventHandler('getPlayers:check', function()
    local playerCount = GetNumPlayerIndices()
    print(playerCount)
    TriggerClientEvent("getPlayers:done", playerCount)
end)