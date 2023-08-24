vRPgt = {}
Tunnel.bindInterface("vRP_garages",vRPgt)
Proxy.addInterface("vRP_garages",vRPgt)
vRP = Proxy.getInterface("vRP")


local inrangeofgarage = false
local currentlocation = nil


GVEHICLES = {}
vehicles = {}
garageSelected = { {x=nil, y=nil, z=nil, h=nil}, }
selectedPage = 0
notgenerating = true
notparking = true

function vRPgt.spawnGarageVehicle(vtype, name, vehicle_plate, vehicle_colorprimary, vehicle_colorsecondary, vehicle_pearlescentcolor, vehicle_wheelcolor, vehicle_plateindex, vehicle_neoncolor1, vehicle_neoncolor2, vehicle_neoncolor3, vehicle_windowtint, vehicle_wheeltype, vehicle_mods0, vehicle_mods1, vehicle_mods2, vehicle_mods3, vehicle_mods4, vehicle_mods5, vehicle_mods6, vehicle_mods7, vehicle_mods8, vehicle_mods9, vehicle_mods10, vehicle_mods11, vehicle_mods12, vehicle_mods13, vehicle_mods14, vehicle_mods15, vehicle_mods16, vehicle_turbo, vehicle_tiresmoke, vehicle_xenon, vehicle_mods23, vehicle_mods24, vehicle_neon0, vehicle_neon1, vehicle_neon2, vehicle_neon3, vehicle_bulletproof, vehicle_smokecolor1, vehicle_smokecolor2, vehicle_smokecolor3, vehicle_modvariation)
  local vehicle = vehicles[vtype]
  if vehicle and not IsVehicleDriveable(vehicle[3]) then -- precheck if vehicle is undriveable
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
    TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Wait(10)
      i = i+1
    end

    notgenerating = false
    exports['progressBars']:startUI(Config.Timer*1000, "Henter køretøj")
    --Wait(Config.Timer*1000)
    notgenerating = true

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      local plate = "P " .. vRP.getRegistrationNumber({})
      SetVehicleNumberPlateText(nveh, plate)
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
      vehicle_migration = false
      if not vehicle_migration then
        local nid = NetworkGetNetworkIdFromEntity(nveh)
        SetNetworkIdCanMigrate(nid,false)
      end

      TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})
      TriggerServerEvent("LSC:applyModifications", mhash, nveh, plate)
    end
  else
    vRP.notify({"Du kan kun have et køretøj ude."})
  end
end

function vRPgt.spawnBoughtVehicle(vtype, name)

  local vehicle = vehicles[vtype]
  if vehicle then -- precheck if vehicle is undriveable
    -- despawn vehicle
    SetVehicleHasBeenOwnedByPlayer(vehicle[3],false)
    Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
    SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
    TriggerEvent("vrp_garages:setVehicle", vtype, nil)
  end

  vehicle = vehicles[vtype]
  if vehicle == nil then
    -- load vehicle model
    local mhash = GetHashKey(name)

    local i = 0
    while not HasModelLoaded(mhash) and i < 10000 do
      RequestModel(mhash)
      Wait(10)
      i = i+1
    end

    -- spawn car
    if HasModelLoaded(mhash) then
      local x,y,z = vRP.getPosition({})
      local nveh = CreateVehicle(mhash, x,y,z+0.5, GetEntityHeading(GetPlayerPed(-1)), true, false) -- added player heading
      SetVehicleOnGroundProperly(nveh)
      SetEntityInvincible(nveh,false)
      SetPedIntoVehicle(GetPlayerPed(-1),nveh,-1) -- put player inside
      SetVehicleNumberPlateText(nveh, "P " .. vRP.getRegistrationNumber({}))
      Citizen.InvokeNative(0xAD738C3085FE7E11, nveh, true, true) -- set as mission entity
      SetVehicleHasBeenOwnedByPlayer(nveh,true)
      vehicle_migration = false
      if not vehicle_migration then
        local nid = NetworkGetNetworkIdFromEntity(nveh)
        SetNetworkIdCanMigrate(nid,false)
      end

      TriggerEvent("vrp_garages:setVehicle", vtype, {vtype,name,nveh})

      SetModelAsNoLongerNeeded(mhash)
    end
  else
    TriggerEvent("pNotify:SendNotification",{
      text = "Du kan kun have en "..vtype.." ude ad gangen.",
      type = "info",
      timeout = (2000),
      layout = "bottomCenter",
      queue = "global",
      animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},
      killer = false
    })
  end
end

function vRPgt.despawnGarageVehicle(vtype, max_range)
  local vehicle = vehicles[vtype]
  local user_id = vRP.getUserId({source})
  local vehicle1 = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  -- local pris = math.ceil(((1000 - GetVehicleBodyHealth(vehicle1)) * 5) + (1000 - GetVehicleEngineHealth(vehicle1)) * 7.5)
  if vehicle then
      local x, y, z = table.unpack(GetEntityCoords(vehicle[3], true))
      local px, py, pz = vRP.getPosition()

      if GetDistanceBetweenCoords(x, y, z, px, py, pz, true) < max_range then -- check distance with the vehicle
          local playerPed = GetPlayerPed(-1)
          local vehiclePed = GetPedInVehicleSeat(vehicle[3], -1)
          if DoesEntityExist(vehiclePed) and vehiclePed == playerPed then
              TaskLeaveVehicle(playerPed, vehicle[3], 4160) -- 4160 is flag for exiting quickly
              Citizen.Wait(1000) -- Wait for the ped to exit the vehicle
          end

          -- Remove the vehicle after ped exits
          SetVehicleHasBeenOwnedByPlayer(vehicle[3], false)
          Citizen.InvokeNative(0xAD738C3085FE7E11, vehicle[3], false, true) -- set not as mission entity
          SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(vehicle[3]))
          Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(vehicle[3]))
          TriggerEvent("vrp_garages:setVehicle", vtype, nil)

          TriggerEvent("pNotify:SendNotification", {
              text = "Køretøjet er gemt!",
              type = "info",
              timeout = 2000,
              layout = "bottomCenter",
              queue = "global",
              animation = { open = "gta_effects_fade_in", close = "gta_effects_fade_out" },
              killer = false
          })
      else
          TriggerEvent("pNotify:SendNotification", {
              text = "Du er ikke i nærheden af et køretøj",
              type = "error",
              timeout = 2000,
              layout = "bottomCenter",
              queue = "global",
              animation = { open = "gta_effects_fade_in", close = "gta_effects_fade_out" },
              killer = false
          })
      end
  end
end


  function MenuGarage()
    ped = GetPlayerPed(-1)
    selectedPage = 0
    MenuTitle = "Garage"
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
    ClearMenu()
    Menu.addButton('Se Køretøjer',"ListVehicle",selectedPage)
    Menu.addButton('Luk',"CloseMenu",nil)
  end


	
  function Gembil()
    Citizen.CreateThread(function()
    local user_id = vRP.getUserId(player)
    local ped = GetPlayerPed(-1)
    local caissei = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  	
    
    SetEntityAsMissionEntity(caissei, true, true)
    local plate = GetVehicleNumberPlateText(caissei)
    local vtype = "car"
    if IsThisModelABike(GetEntityModel(caissei)) then
      vtype = "bike"
    end
    if DoesEntityExist(caissei) then
      TriggerServerEvent('ply_garages:CheckForVeh', plate, vehicles[vtype][2],vtype)
    else
      TriggerEvent("pNotify:SendNotification",{text = "Intet køretøj ude",type = "info",timeout = (2000), theme = "gta", layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
    end)
  end


  function StoreVehicle()
    Citizen.CreateThread(function()
    local caissei = GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70)
    SetEntityAsMissionEntity(caissei, true, true)
    local plate = GetVehicleNumberPlateText(caissei)
    local vtype = "car"
    if IsThisModelABike(GetEntityModel(caissei)) then
      vtype = "bike"
    end
    if DoesEntityExist(caissei) then
      local damage = GetEntityHealth(GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70))
      local windows = AreAllVehicleWindowsIntact(GetClosestVehicle(garageSelected.x, garageSelected.y, garageSelected.z, 3.000, 0, 70))
      if damage <850 or windows == false then
        TriggerEvent("pNotify:SendNotification",{text = "Dit køretøj er skadet, ring til en mekaniker!",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
      else
        TriggerServerEvent('ply_garages:CheckForVeh', plate, vehicles[vtype][2],vtype)
      end
    else
      TriggerEvent("pNotify:SendNotification",{text = "Intet køretøj ude",type = "info",timeout = (2000), theme = "gta", layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
    end)
    CloseMenu()
  end



  function ListVehicle(page)
    ped = GetPlayerPed(-1)
    selectedPage = page
    MenuTitle = 'Garage'
    ClearMenu()
    local count = 0
    for ind, value in pairs(GVEHICLES) do
      if ((count >= (page*10)) and (count < ((page*10)+10))) then
        Menu.addButton(tostring(value.vehicle_name), "OptionVehicle", value.vehicle_name)
      end
      count = count + 1
    end
    Menu.addButton('Næste',"ListVehicle",page+1)
    if page == 0 then
      Menu.addButton('Tilbage',"MenuGarage",nil)
    else
      Menu.addButton('Tilbage',"ListVehicle",page-1)
    end
  end

  function OptionVehicle(vehID)
    local vehID = vehID
    MenuTitle = "Garage"
    ClearMenu()
    Menu.addButton('Tag ud', "SpawnVehicle", vehID)
    Menu.addButton('Tilbage', "ListVehicle", selectedPage)
  end

  function SpawnVehicle(vehID)
    local vehID = vehID
    TriggerServerEvent('ply_garages:CheckForSpawnVeh', vehID)
    CloseMenu()
  end


  function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
  end

  function CloseMenu()
    Menu.hidden = true
    TriggerServerEvent("ply_garages:CheckGarageForVeh")
  end

  function LocalPed()
    return GetPlayerPed(-1)
  end

  function IsPlayerInRangeOfGarage()
    return inrangeofgarage
  end

  function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
  end

  --[[function ply_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
  SetTextFont(font)
  SetTextProportional(0)
  SetTextScale(scale, scale)
  SetTextColour(r, g, b, a)
  SetTextDropShadow(0, 0, 0, 0,255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(centre)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(x , y)
  end]]

  function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 100)
  end


  --[[Citizen]]--

Citizen.CreateThread(function()
  while true do
    Wait(0)
    for _, garage in pairs(Config.Garages) do
      if notgenerating then
      DrawMarker(27, garage.x, garage.y, garage.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 110, 0, 200, 0, 1, 0, 50)
      if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and IsPedInAnyVehicle(LocalPed(), true) == false then
        DrawText3Ds(garage.x, garage.y, garage.z + 1, "~g~[E]~w~ - Benyt garage")
        if IsControlJustPressed(1, 38) then
          garageSelected.x = garage.x
          garageSelected.y = garage.y
          garageSelected.z = garage.z
          MenuGarage()
          Menu.hidden = not Menu.hidden
        end
        Menu.renderGUI()
        end
      end
    end
  end
end)


Citizen.CreateThread(function()
  while notparking do
    Wait(0)
    for _, garage in pairs(Config.Garages) do
      DrawMarker(27, garage.x, garage.y, garage.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 0.5001, 0, 110, 0, 200, 0, 1, 0, 50)
      if GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
        DrawText3Ds(garage.x, garage.y, garage.z + 1, "~g~[E]~w~ - Parker køretøj")
        if IsControlJustPressed(1, 38) then
          notparking = false
          local bil = GetVehiclePedIsIn(GetPlayerPed(-1), false)
          FreezeEntityPosition(bil, true)
          exports['progressBars']:startUI(Config.Timer*1000, "Parkere køretøj")
          --Wait(Config.Timer*1000)
          FreezeEntityPosition(bil, false)
          garageSelected.x = garage.x
          garageSelected.y = garage.y
          garageSelected.z = garage.z
          Gembil()
          notparking = true
        end
      end
    end
  end
end)



Citizen.CreateThread(function()
  while true do
    local near = false
    Wait(0)
    for _, garage in pairs(Config.Garages) do
      if (GetDistanceBetweenCoords(garage.x, garage.y, garage.z, GetEntityCoords(LocalPed())) < 3 and near ~= true) then
        near = true
      end
    end
    if near == false then
      Menu.hidden = true
    end
  end
  end)

Citizen.CreateThread(function()
  for _, item in pairs(Config.Impound) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipAsShortRange(item.blip, true)
    SetBlipColour(item.blip, item.colour)
	SetBlipScale(item.blip,0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
  end
end)

Citizen.CreateThread(function()
  for _, item in pairs(Config.Garages) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipAsShortRange(item.blip, true)
    SetBlipColour(item.blip, item.colour)
	SetBlipScale(item.blip,0.6)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
  end
end)

  --[[Events]]--

  RegisterNetEvent('vrp_garages:setVehicle')
  AddEventHandler('vrp_garages:setVehicle', function(vtype, vehicle)
  vehicles[vtype] = vehicle
  end)

  RegisterNetEvent('ply_garages:addAptGarage')
  AddEventHandler('ply_garages:addAptGarage', function(gx,gy,gz,gh)
  local alreadyExists = false
  for _, garage in pairs(Config.Garages) do
    if garage.x == gx and garage.y == gy then
      alreadyExists = true
    end
  end
  if not alreadyExists then
    table.insert(garages, #garages + 1, {name="Apartment Garage", colour=3, id=357, x=gx, y=gy, z=gz, h=gh})
  end
  end)

  RegisterNetEvent('ply_garages:getVehicles')
  AddEventHandler("ply_garages:getVehicles", function(THEVEHICLES)
  GVEHICLES = {}
  GVEHICLES = THEVEHICLES
  end)







CreateThread(function()
    while true do
      Wait(0)
      --for _, garage in pairs(Config.Garages) do
          for k,Impound in pairs(Config.Impound) do
        local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Impound.x, Impound.y, Impound.z, true )
        if distance <= 10.0 and distance >= 2.0 then
          DrawMarker(20,Impound.x, Impound.y, Impound.z,0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.7, 52, 103, 235, 100, false, true, 2, false, false, false, false)
          elseif distance <= 2.0 then
            DrawText3Ds(Impound.x, Impound.y, Impound.z+0.2, "~g~[E]~w~ - Køb køretøjer tilbage", 3.0, 7)
          if IsControlJustPressed(1, 38) then
            TriggerServerEvent('Kian_impond:buycarsback')
          end
        end
      end
    end
end)



RegisterNetEvent('Kian_impound:impoundcar', function()
	local spiller = GetPlayerPed(-1)
	local veh = vRP.getNearestVehicle({10})
	local model = GetVehiclePedIsIn(spiller)
	local plate = GetVehicleNumberPlateText(veh)
  local vehID = GetDisplayNameFromVehicleModel(GetEntityModel(model))
  SetEntityAsMissionEntity( model, true, true )

	if plate ~= nil then
			exports['progressBars']:startUI(5000, "Impounder "..vehID)
			--Wait(5000)
			TriggerServerEvent('Kian_impound:sv_impoundcar', plate, vehID)
      Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(model))
		else
      TriggerEvent("pNotify:SendNotification", {text = "Ingen bil fundet",type = "info",timeout = (2000), layout = "bottomCenter",queue = "global", animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end
end)
