RegisterNetEvent('getPlayers:check')
AddEventHandler('getPlayers:check', function()
    local playerSource = source
    local playerCount = #GetPlayers()
    TriggerClientEvent("getPlayers:done", playerSource, playerCount)
end)
