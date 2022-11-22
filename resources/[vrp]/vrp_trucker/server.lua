local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local webhook = module("vrp","cfg/webhooks")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_trucker")

RegisterServerEvent('trucker:checkjob')
AddEventHandler('trucker:checkjob', function()
    local source = source
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasPermission({user_id,"delivery.trucker"}) then --here check if you have permission
        TriggerClientEvent('yestrucker', source)
    else
        TriggerClientEvent('notrucker', source)
    end
end)

--Essential payment functions 

RegisterServerEvent('trucker:success')
AddEventHandler('trucker:success', function(amount)
    -- Get the players money amount
    local source = source
    local user_id = vRP.getUserId({source})
    local toPay = amount + math.random(0,1000)
    
    if amount < 7000 then
        vRP.giveBankMoney({user_id,toPay})
        TriggerClientEvent("pNotify:SendNotification", source,{text = "Du modtog <b style='color: #4E9350'>" .. toPay.." DKK</b>.",type = "success",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    else
        vRP.ban({user_id, 'Du forsøgte og spawne '..amount..' via "vrp_trucker"'})
        PerformHttpRequest(webhook.HoneyPot, function(err, text, headers) end, 'POST', 
        json.encode({username = 'Kian - Logs', 
        content = 'ID: '..user_id..' Forsøgte og spawne '..amount..' DKK via '..GetCurrentResourceName()}), {['Content-Type'] = 'application/json'})
    end
end)



