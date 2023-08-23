local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_delivery")


RegisterServerEvent('delivery:checkjob')
AddEventHandler('delivery:checkjob', function()
	local source = source
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})

    if vRP.hasPermission({user_id,"delivery.gopostal"}) then --here check if you have permission
      TriggerClientEvent('yesdelivery', source)
    else
      TriggerClientEvent('nodelivery', source)
    end
end)

--Essential payment functions 

RegisterServerEvent('delivery:success')
AddEventHandler('delivery:success', function(amount)
	-- Get the players money amount
local source = source
local user_id = vRP.getUserId({source})
local money = vRP.getBankMoney({user_id})
 -- update player money amount
    
    if amount < 12000 then
	vRP.giveBankMoney({user_id,amount})
	TriggerClientEvent("pNotify:SendNotification", source,{text = "Modtog "..amount.." DKK.", type = "success", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    else
        vRP.ban({user_id, 'Du forsøgte og spawne '..amount..' via "vrp_trucker"'})
        PerformHttpRequest(webhook.HoneyPot, function(err, text, headers) end, 'POST', 
        json.encode({username = 'Kian - Logs', 
        content = 'ID: '..user_id..' Forsøgte og spawne '..amount..' DKK via '..GetCurrentResourceName()}), {['Content-Type'] = 'application/json'})
    end
end)
