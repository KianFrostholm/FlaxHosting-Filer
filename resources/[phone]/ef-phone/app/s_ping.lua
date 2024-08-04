-- ping
local Pings = {}

RegisterNetEvent('qb-phone:server:sendPing', function(data)
    local src = source
    if src == data then
        TriggerClientEvent("QBCore:Notify", src, "You cannot ping yourself", "error")
    end
end)

RegisterNetEvent('qb-ping:server:SendPing2', function(id)
    local src = source

    TriggerClientEvent('qb-ping:client:DoPing', src, tonumber(id))
end)

RegisterNetEvent('qb-ping:server:acceptping', function()
    local src = source
    local user_id = vRP.getUserId({src})
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {user_id})[1]


    if Pings[src] ~= nil then
        TriggerClientEvent('qb-ping:client:AcceptPing', src, Pings[src], Pings[src].sender)
        TriggerClientEvent('QBCore:Notify', Pings[src].sender, i.firstname.." "..i.name.." accepted your ping request!")
        Pings[src] = nil
    else
        TriggerClientEvent('QBCore:Notify', src, "You have no ping...", "error")
    end
end)

RegisterNetEvent('qb-ping:server:denyping', function()
    local src = source
    local user_id = vRP.getUserId({src})
    
    if Pings[src] ~= nil then
        TriggerClientEvent('QBCore:Notify', Pings[src].sender, "Your ping request has been rejected...", "error")
        TriggerClientEvent('QBCore:Notify', src, "You turned down the ping...", "success")
        Pings[src] = nil
    else
        TriggerClientEvent('QBCore:Notify', src, "You have no ping...", "error")
    end
end)

RegisterNetEvent('qb-ping:server:SendPing', function(id)
    local src = source
    local user_id = vRP.getUserId({src})
    local Target = vRP.getUserSource({id})
    local t_i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {id})[1]
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {user_id})[1]
    local ped = GetPlayerPed(id)
    local coords = GetEntityCoords(ped)

    if Target ~= nil then
        local OtherItem = vRP.getInventoryItemAmount({user_id, Config.Item})
        if OtherItem > 0 then
            TriggerClientEvent('QBCore:Notify', src, "You have requested the location of "..t_i.firstname.." "..t_i.name)
            Pings[id] = {
                coords = coords,
                sender = src,
            }
            TriggerClientEvent('QBCore:Notify', id, "You have received a ping request from "..i.firstname.." "..i.name..". Use the app to allow or reject!")
            TriggerClientEvent('qb-ping:client:UiUppers', id, true)
        else
            TriggerClientEvent('QBCore:Notify', src, "Could not send ping...", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "This person is not in the city...", "error")
    end
end)

RegisterNetEvent('qb-ping:server:SendLocation', function(PingData, SenderData)
    TriggerClientEvent('qb-ping:client:SendLocation', PingData.sender, PingData, SenderData)
end)