local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local webhook = module("vrp","cfg/webhooks")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","Kian-houserobbery")

RegisterServerCallback('kian-indburd:BetjenteOnline', function(source, cb)
	Politionline = 0
	local users = vRP.getUsers({})
	for k,v in pairs(users) do
		local player = vRP.getUserSource({k})
	  	if player ~= nil then
			if user_id ~= nil then
				local user_id = vRP.getUserId({player})
				if vRP.hasPermission({user_id, Config.Permission}) then
					Politionline = Politionline + 1
				end
			end
	  	end
	end
	cb(Politionline)
end)

RegisterNetEvent('kian-indburd:givback')
AddEventHandler('kian-indburd:givback', function()
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		vRP.giveInventoryItem({user_id,Config.Lockpick,1,false})
		PerformHttpRequest(webhook.Burglary, function(err, text, headers) end, 'POST', json.encode({username = "Kian - houserobbery", content = "```ID: "..user_id.." fik sin lockpick tilbage```"}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterNetEvent('kian-indburd:givback2')
AddEventHandler('kian-indburd:givback2', function()
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		vRP.giveInventoryItem({tonumber(user_id), Config.lockpick, 1, true})
		PerformHttpRequest(webhook.Burglary, function(err, text, headers) end, 'POST', json.encode({username = "Kian - houserobbery", content = "```ID: "..user_id.." fik sin lockpick tilbage```"}), { ['Content-Type'] = 'application/json' })
	end
end)

RegisterNetEvent('kian-indburd:lockpickbroke')
AddEventHandler('kian-indburd:lockpickbroke', function()
	local user_id = vRP.getUserId({source})
	if user_id ~= nil then
		vRP.tryGetInventoryItem({user_id, Config.lockpick, 1})
		PerformHttpRequest(webhook.Burglary, function(err, text, headers) end, 'POST', json.encode({username = "Kian - houserobbery", content = "```ID: "..user_id.." fejlede et indbrud.```"}), { ['Content-Type'] = 'application/json' })
	end
end)


RegisterNetEvent('kian-indburd:searchItem')
AddEventHandler('kian-indburd:searchItem', function(antal)
local user_id = vRP.getUserId({source})
local randomItem = Config.rewarditems[math.random(1,#Config.rewarditems)]
local maxAmount = randomItem.quantity or 10
local randomAmount = math.random(1, maxAmount)
if antal == 0 then
vRP.giveInventoryItem({user_id, randomItem.name, randomAmount})
local message = "ID: "..user_id.." fandt "..randomAmount.. " " ..randomItem.name.."."
if randomAmount > 1 then
message = message .. "s"
end
PerformHttpRequest(webhook.Burglary, function(err, text, headers) end, 'POST', json.encode({username = "PrimeRP - houserobbery", content = ""..message..""}), { ['Content-Type'] = 'application/json' })
else
vRP.ban({user_id, 'Du forsøgte at misbruge indbrud med '..antal..' antal"'})
PerformHttpRequest(webhook.HoneyPot, function(err, text, headers) end, 'POST',
json.encode({username = 'Server Navn - Logs',
content = 'ID: '..user_id..' forsøgte at misbruge indbrud med '..antal..' via '..GetCurrentResourceName()}), {['Content-Type'] = 'application/json'})
end
end)

RegisterCommand('rush', function(source)
	local user_id = vRP.getUserId({source})
	if vRP.hasPermission({user_id, Config.Permission}) then
		TriggerClientEvent('kian-indburd:cbreach', source, true)
	end
end)
