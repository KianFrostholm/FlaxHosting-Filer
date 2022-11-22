local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


RegisterNetEvent('ec-dispatch:robbery')
AddEventHandler('ec-dispatch:robbery', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-90', ["name"] = 'Igangværende røveri', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchrobbery", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:panicbutton')
AddEventHandler('ec-dispatch:panicbutton', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        vRP.getUserIdentity({user_id, function(identity)
            if vRP.hasGroup({user_id, "Politi-Job"}) then
                data = {["code"] = 'DISPATCH', ["name"] = 'Panikknap udløst af ' ..identity.firstname..' ' ..identity.name.. '', ["loc"] = street}
                length = 5000
                TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
                TriggerClientEvent("dispatchrobbery", v, playerStreetsLocation)
            end
        end})
    end
end)

RegisterNetEvent('ec-dispatch:robberydecleined')
AddEventHandler('ec-dispatch:robberydecleined', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-90', ["name"] = 'Røveri afbrudt', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
        end
    end
end)

RegisterNetEvent('ec-dispatch:carsteal')
AddEventHandler('ec-dispatch:carsteal', function(type, street, playerStreetsLocation, display)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = { ["code"] = '10-15', ["name"] = 'Biltyveri på en ' ..display.. '',  ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:shooting')
AddEventHandler('ec-dispatch:shooting', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = { ["code"] = '10-13', ["name"] = 'Skud affyret',  ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:combat')
AddEventHandler('ec-dispatch:combat', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-10', ["name"] = 'Vold',  ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:death')
AddEventHandler('ec-dispatch:death', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-28', ["name"] = 'Bevidstløs person', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchems", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:hash')
AddEventHandler('ec-dispatch:hash', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-33', ["name"] = 'Mistænkeligt salg', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:atmrobbery')
AddEventHandler('ec-dispatch:atmrobbery', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-58', ["name"] = 'Røveri på hæveautomat', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent("ec-dispatch:hospital")
AddEventHandler("ec-dispatch:hospital", function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = 'DISPATCH', ["name"] = 'Person mangler hjælp', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchems", v, playerStreetsLocation)
        end
    end
end)

RegisterNetEvent('ec-dispatch:detector')
AddEventHandler('ec-dispatch:detector', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-12', ["name"] = 'Person udløste en alarm', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
            PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode({username = "Unknwon - Logs", content = "```id "..user_id.." udløste en alarm på "..street.." ```"}), { ['Content-Type'] = 'application/json' })
        end
    end
end)


RegisterNetEvent('ec-dispatch:truckrobbery')
AddEventHandler('ec-dispatch:truckrobbery', function(type, street, playerStreetsLocation)
    local allPlayers = vRP.getUsers({})
    for k,v in pairs(allPlayers) do
        local user_id = vRP.getUserId({v})
        if vRP.hasGroup({user_id, "Politi-Job"}) then
            data = {["code"] = '10-12', ["name"] = 'En person er igang med at røve en pengetransporter', ["loc"] = street}
            length = 5000
            TriggerClientEvent('wf_alerts:SendAlert', v, type, data, length)
            TriggerClientEvent("dispatchpolice", v, playerStreetsLocation)
            PerformHttpRequest('', function(err, text, headers) end, 'POST', json.encode({username = "Unknwon - Logs", content = "```id "..user_id.." udløste en alarm på "..street.." ```"}), { ['Content-Type'] = 'application/json' })
        end
    end
end)
