local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

local tbl = {
	[1] = {locked = false, player = nil},
	[2] = {locked = false, player = nil},
	[3] = {locked = false, player = nil},
	[4] = {locked = false, player = nil},
	[5] = {locked = false, player = nil},
	[6] = {locked = false, player = nil},
	[7] = {locked = false, player = nil},
	[8] = {locked = false, player = nil},
}

RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if not b then
		tbl[tonumber(garage)].player = nil
	else
		tbl[tonumber(garage)].player = source
	end
	TriggerClientEvent('lockGarage',-1,tbl)
end)

RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
	TriggerClientEvent('lockGarage',-1,tbl)
end)

AddEventHandler('playerDropped', function()
	for i,g in pairs(tbl) do
		if g.player then
			if source == g.player then
				g.locked = false
				g.player = nil
				TriggerClientEvent('lockGarage',-1,tbl)
			end
		end
	end
end)

RegisterServerEvent("LSC:buttonSelected")
AddEventHandler("LSC:buttonSelected", function(name, button)
	local source = source
	local user_id = vRP.getUserId({source})
	if user_id then
		TriggerClientEvent("LSC:buttonSelected", source, name, button, vRP.tryFullPayment({user_id, button.price or 0})) -- money
	end
end)


RegisterServerEvent("LSC:finished")
AddEventHandler("LSC:finished", function(VehicleModel, plate, veh, prcolor, secolor)
	local source = source
	local user_id = vRP.getUserId({source})
	if user_id then
		MySQL.Async.execute("update vrp_user_vehicles set modifications = @modifications where user_id = @user_id and hashkey = @hashkey and vehicle_plate = @vehicle_plate", {user_id = user_id, hashkey = VehicleModel, vehicle_plate = plate, modifications = json.encode({color = veh.color, extraColor = veh.extracolor, neon = veh.neon, neonColor = veh.neoncolor, xenonColor = veh.xenoncolor, smokeColor = veh.smokecolor, wheelType = veh.wheeltype, bulletProofTyres = veh.bulletProofTyres, windowTint = veh.windowtint, plateIndex = veh.plateindex, mods = veh.mods})})
		MySQL.Async.execute('update vrp_user_vehicles set vehicle_colorprimary = @pcolor where user_id = @user_id and hashkey = @hashkey and vehicle_plate = @vehicle_plate', {user_id = user_id, hashkey = VehicleModel, vehicle_plate = plate, pcolor = prcolor})
		MySQL.Async.execute('update vrp_user_vehicles set vehicle_colorsecondary = @scolor where user_id = @user_id and hashkey = @hashkey and vehicle_plate = @vehicle_plate', {user_id = user_id, hashkey = VehicleModel, vehicle_plate = plate, scolor = secolor})
	end
end)

RegisterServerEvent("LSC:applyModifications")
AddEventHandler("LSC:applyModifications", function (key, vehicle, plate)
	local source = source
	local user_id = vRP.getUserId({source})
	if user_id then
		MySQL.Async.fetchAll("select modifications from vrp_user_vehicles where user_id = @user_id and hashkey = @hashkey and vehicle_plate = @plate", {user_id = user_id, hashkey = key, plate = plate}, function(rows, affected)
			if #rows > 0 then
				local modifications = json.decode(rows[1].modifications)
				if modifications then
					TriggerClientEvent("LSC:applyModifications", source, vehicle, modifications)
				end
			end
		end)
	end
end)
