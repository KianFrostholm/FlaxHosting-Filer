TriggerEvent('HT_base:getBaseObjects', function(obj) HT = obj end)

RegisterNetEvent('getPlayers:check')
AddEventHandler('getPlayers:check', function()
    local playerCount = GetNumPlayerIndices()
    print(playerCount)
    TriggerClientEvent("getPlayers:done", playerCount)
end)
