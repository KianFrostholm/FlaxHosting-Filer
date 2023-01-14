
--==vRP connection==--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP", GetCurrentResourceName())
local vRPc = Tunnel.getInterface(GetCurrentResourceName(), GetCurrentResourceName())
--===================================--

--==Events==--
RegisterServerEvent("V1N_InformationHUD:updateHud")
AddEventHandler("V1N_InformationHUD:updateHud", function()
    local source = source
    local user_id = vRP.getUserId({source})

    local data = {}
    table.insert(data, {
        type = "update",
        wallet = vRP.getMoney({user_id}), 
        bank = vRP.getBankMoney({user_id}), 
        dirty_money = vRP.getInventoryItemAmount({user_id, "dirty_money"}),
        job = vRP.getUserGroupByType({user_id, "job"}),
        id = user_id
    })
    Wait(750)
    vRPc.updateHud(source, data)
end)
--===================================--
