
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")


vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_showroom")
Gclient = Tunnel.getInterface("vRP_garages","vRP_showroom")

local cfg = module("vrp_showroom","cfg/config")
local webhook = module("vrp","cfg/webhooks")

local vehgarage = cfg.showgarage


RegisterServerEvent('veh_SR:CheckMoneyForVeh')
AddEventHandler('veh_SR:CheckMoneyForVeh', function(vehicle, price ,veh_type)
    local user_id = vRP.getUserId({source})
    local player = vRP.getUserSource({user_id})
    MySQL.Async.fetchAll('SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle', {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
        vRP.prompt({player,"Er du sikker på, at du vil købe dette køretøj? (godkend/afvis)","",function(player, answer)
            if string.lower(answer) == "godkend" then
                if #pvehicle > 0 then
                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Du ejer allerede dette køretøj!", type = "warning", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                else
                    for i=1, #vehgarage.vehicles do
                        if vehgarage.vehicles[i].model == vehicle and vehgarage.vehicles[i].costs == price then
                            if price > 5000 then
                                if vRP.tryFullPayment({user_id,price}) then
                                    vRP.getUserIdentity({user_id, function(identity)
                                        MySQL.Async.execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_name,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_name,@vehicle_plate,@veh_type)", {user_id = user_id, vehicle = vehicle, vehicle_name = vehicle, vehicle_plate = "P "..identity.registration, veh_type = veh_type})
                                    end})

                                    TriggerClientEvent('veh_SR:CloseMenu', player, vehicle, veh_type)
                                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Betalte "..format_thousand(price).." DKK", type = "info", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                    PerformHttpRequest(webhook.BuyCar, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = "**"..user_id.."** har lige købt en **"..vehicle.."** for: **"..format_thousand(price).."**"}), { ['Content-Type'] = 'application/json' })
                                else
                                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Ikke nok penge!", type = "warning", queue = "global", timeout = 3000, layout = "centerRight",animation = {open = "gta_effects_open", close = "gta_effects_close"}})
                                end
                            end
                        end
                    end
                end
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "Betalingen afbrudt, da du ikke godkendte.", type = "error", queue = "global", timeout = 5000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end})
    end)
end)

function format_thousand(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
            .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end