local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_garages")
vRPgc = Tunnel.getInterface("vRP_garages","vRP_garages")



RegisterServerEvent('ply_garages:CheckForSpawnVeh')
AddEventHandler('ply_garages:CheckForSpawnVeh', function(vehicle)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})

  
  MySQL.Async.fetchAll('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle', {user_id = user_id, vehicle = vehicle}, function(result, affected)
    if result[1].impound == 0 then
      
      vRP.closeMenu({player})
      vRPgc.spawnGarageVehicle(player,{result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation})
    else
      TriggerClientEvent("pNotify:SendNotification", player, {text = "Dette køretøj er i impound",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end)

RegisterServerEvent('ply_garages:CheckForSpawnBasicVeh')
AddEventHandler('ply_garages:CheckForSpawnBasicVeh', function(user_id,vehicle)
  local player = vRP.getUserSource({user_id})
  MySQL.Async.fetchAll('SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle', {user_id = user_id, vehicle = vehicle}, function(result, affected)
    vRP.closeMenu({player})
  vRPgc.spawnGarageVehicle(player,{result[1].veh_type,vehicle,result[1].vehicle_plate, result[1].vehicle_colorprimary, result[1].vehicle_colorsecondary, result[1].vehicle_pearlescentcolor, result[1].vehicle_wheelcolor, result[1].vehicle_plateindex, result[1].vehicle_neoncolor1, result[1].vehicle_neoncolor2, result[1].vehicle_neoncolor3, result[1].vehicle_windowtint, result[1].vehicle_wheeltype, result[1].vehicle_mods0, result[1].vehicle_mods1, result[1].vehicle_mods2, result[1].vehicle_mods3, result[1].vehicle_mods4, result[1].vehicle_mods5, result[1].vehicle_mods6, result[1].vehicle_mods7, result[1].vehicle_mods8, result[1].vehicle_mods9, result[1].vehicle_mods10, result[1].vehicle_mods11, result[1].vehicle_mods12, result[1].vehicle_mods13, result[1].vehicle_mods14, result[1].vehicle_mods15, result[1].vehicle_mods16, result[1].vehicle_turbo, result[1].vehicle_tiresmoke, result[1].vehicle_xenon, result[1].vehicle_mods23, result[1].vehicle_mods24, result[1].vehicle_neon0, result[1].vehicle_neon1, result[1].vehicle_neon2, result[1].vehicle_neon3, result[1].vehicle_bulletproof, result[1].vehicle_smokecolor1, result[1].vehicle_smokecolor2, result[1].vehicle_smokecolor3, result[1].vehicle_modvariation})
  end)
end)



RegisterServerEvent('ply_garages:CheckForVeh')
AddEventHandler('ply_garages:CheckForVeh', function(plate,vehicle,vtype)
local user_id = vRP.getUserId({source})
local player = vRP.getUserSource({user_id})
local hkey = GetHashKey(vehicle)

  MySQL.Async.fetchAll('SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle AND vehicle_plate = @plate', {user_id = user_id, vehicle = vehicle, plate = plate}, function(rows, affected)
  if #rows > 0 then -- has vehicle
    vRPgc.despawnGarageVehicle(player,{vtype,5})
    MySQL.Async.execute("UPDATE vrp_user_vehicles SET hashkey = @hashkey WHERE user_id = @user_id AND vehicle = @vehicle",{user_id = user_id, vehicle = vehicle, hashkey = hkey})
  else
    TriggerEvent("pNotify:SendNotification",{text = "Du ejer ikke dette køretøj",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
  end)
end)

RegisterServerEvent('ply_garages:CheckGarageForVeh', function()
  local user_id = vRP.getUserId({source})
  local vehicles = {}
  
  if user_id ~= nil then
    MySQL.Async.fetchAll("SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id", {user_id = user_id}, function(pvehicles, affected)
      for k,v in ipairs(pvehicles) do
        if v.veh_type == "car" or v.veh_type == "bike" then
          table.insert(vehicles, {["vehicle_model"] = v.vehicle_model, ["vehicle_name"] = v.vehicle})
        end
      end
        TriggerClientEvent("ply_garages:getVehicles", vRP.getUserSource({user_id}), vehicles)
      end)
    end
end)


RegisterNetEvent('Kian_impond:buycarsback', function()
  local user_id = vRP.getUserId({source})
  local xSource = vRP.getUserSource({user_id})
  count = 0
  MySQL.Async.fetchAll("SELECT vehicle_name, vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND impound = 1", {user_id = user_id}, function(biler, affected)
    if biler ~= nil then
      for k, v in pairs(biler) do
        count = count+1
      end
      if count == 0 then
        TriggerClientEvent("pNotify:SendNotification", xSource,{text = "Du har ikke nogen køretøjer i impound",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      else
        prise = count * Config.Fee
        vRP.prompt({xSource,"Vil du købe "..count.." køretøjer ud for "..prise.." (ja/nej): ","",function(xSource,svar)
          if string.lower(svar) == "ja" then
            if vRP.tryFullPayment({user_id,prise}) then
              TriggerClientEvent("pNotify:SendNotification", xSource,{text = "Du købte dine "..count.." køretøjer tilbage for "..prise.." DKK",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
              for k, v in pairs(biler) do
                MySQL.Async.execute("UPDATE vrp_user_vehicles SET impound = 0 WHERE user_id = @user_id AND vehicle = @vehicle",{
                  user_id = user_id,
                  vehicle = v.vehicle
                })
              end
            else
              TriggerClientEvent("pNotify:SendNotification", xSource, {text = "Du har ikke "..prise.." DKK til at købe "..count.." køretøjer tilbage",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
          else
            TriggerClientEvent("pNotify:SendNotification", xSource, {text = "Du har ikke bekræftet",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
          end
        end})
      end
    end
  end)
end)

RegisterNetEvent('Kian_impound:sv_impoundcar', function(plate, name)
  local user_id = vRP.getUserId({source})
  local xSource = vRP.getUserSource({user_id})
  MySQL.Async.execute("UPDATE vrp_user_vehicles SET impound = 1 WHERE vehicle_plate = @plate AND vehicle = @vehicle", {plate = plate, vehicle = name})
  TriggerClientEvent("pNotify:SendNotification", xSource, {text = "Køretøjet er impoundet",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
end)
