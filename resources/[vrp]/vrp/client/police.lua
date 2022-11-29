
-- this module define some police tools and functions

local handcuffed = false
local cop = false

-- set player as cop (true or false)
function tvRP.setCop(flag)
  cop = flag
  SetPedAsCop(GetPlayerPed(-1),flag)
end

-- HANDCUFF


function tvRP.toggleHandcuff()
  handcuffed = not handcuffed

  SetEnableHandcuffs(GetPlayerPed(-1), handcuffed)
  if handcuffed then
    tvRP.playAnim(true,{{"mp_arresting","idle",1}},true)
    TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 2, "handcuff", 0.4)
  else
    tvRP.stopAnim(true)
  end
end

function tvRP.setHandcuffed(flag)
  if handcuffed ~= flag then
    tvRP.toggleHandcuff()
  end
end

function tvRP.isHandcuffed()
  return handcuffed
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
		if IsControlJustReleased(1,170) then
			TriggerServerEvent('handcuff:checkjob')
			Citizen.Wait(1500)
		end
	end
end)

RegisterNetEvent("cuff")
AddEventHandler("cuff", function()
	if not tvRP.isInComa() and not tvRP.isHandcuffed() then
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			TriggerEvent("pNotify:SendNotification",{text = "Du kan ikke give håndjern på fra et køretøj.",type = "error",timeout = (5000),layout = "centerRight",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		else
			TriggerServerEvent('handcuff:cuffHim')
		end
	end
end)

function tvRP.spawnspikes()
  TriggerEvent('c_setSpike')
end

other = nil
drag = false
playerStillDragged = false
drag1 = false
drag2 = false
dragversion = 1

RegisterNetEvent("dr:drag")
AddEventHandler('dr:drag', function(pl)
	other = pl
	drag = not drag
	dragversion = 1
end)

RegisterNetEvent("dr:drag2")
AddEventHandler('dr:drag2', function(pl)
	other = pl
	drag = not drag
	dragversion = 2
end)

RegisterNetEvent("dr:undrag")
AddEventHandler('dr:undrag', function(pl)
	drag2 = false
	drag1 = false
	drag = false
end)

RegisterNetEvent("dr:undrag2")
AddEventHandler('dr:undrag2', function(pl)
	drag2 = false
	drag1 = false
	drag = false
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)


Citizen.CreateThread(function()
	while true do
		if drag and other ~= nil then
			local ped = GetPlayerPed(GetPlayerFromServerId(other))
			local myped = GetPlayerPed(-1)
			if dragversion == 1 then 
			AttachEntityToEntity(myped, ped, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
			else
			AttachEntityToEntity(myped, ped, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 0.0, false, false, false, false, 2, false)
			end
			playerStillDragged = true
		else
			if(playerStillDragged) then
				DetachEntity(GetPlayerPed(-1), true, false)
				playerStillDragged = false
			end
		end
		Citizen.Wait(0)
	end
end)


function tvRP.putInNearestVehicleAsPassenger(radius)
  local veh = tvRP.getNearestVehicle(radius)

  if IsEntityAVehicle(veh) then
    for i=1,math.max(GetVehicleMaxNumberOfPassengers(veh),3) do
      if IsVehicleSeatFree(veh,i) then
        SetPedIntoVehicle(GetPlayerPed(-1),veh,i)
    beltOn = true
        return true
      end
    end
  end
  return false
end

function tvRP.putInNetVehicleAsPassenger(net_veh)
  local veh = NetworkGetEntityFromNetworkId(net_veh)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
      DetachEntity(GetPlayerPed(-1), true, false)
        SetPedIntoVehicle(GetPlayerPed(-1),veh,i)
    beltOn = true
        return true
      end
    end
  end
end

function tvRP.putInVehiclePositionAsPassenger(x,y,z)
  local veh = tvRP.getVehicleAtPosition(x,y,z)
  if IsEntityAVehicle(veh) then
    for i=1,GetVehicleMaxNumberOfPassengers(veh) do
      if IsVehicleSeatFree(veh,i) then
      DetachEntity(GetPlayerPed(-1), true, false)
        SetPedIntoVehicle(GetPlayerPed(-1),veh,i)
    beltOn = true
        return true
      end
    end
  end
end

-- keep handcuffed animation
CreateThread(function()
  while true do
    Citizen.Wait(5000)
    if handcuffed then
      tvRP.playAnim(true,{{"mp_arresting","idle",1}},true)
    end
  end
end)


-- force stealth movement while handcuffed (prevent use of fist and slow the player)
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if handcuffed then
      SetPedStealthMovement(GetPlayerPed(-1),true,"")
      DisableControlAction(0,21,true) -- disable sprint (SHIFT)
      DisableControlAction(0,22,true) -- disable jump (SPACE)
      DisableControlAction(0,23,true) -- disable enter vehicle (F)
      DisableControlAction(0,24,true) -- disable attack (LEFTCLICK)
      DisableControlAction(0,25,true) -- disable aim (RIGHTCLICK)
      DisableControlAction(0,29,true) -- disable point (B)
      DisableControlAction(0,47,true) -- disable weapon
      DisableControlAction(0,58,true) -- disable weapon
      DisableControlAction(0,73,true) -- disable handsup (X)
      DisableControlAction(0,75,true) -- disable exit vehicle (F)
      DisableControlAction(27,75,true) -- disable exit vehicle (F)
      DisableControlAction(0,140,true) -- disable melee
      DisableControlAction(0,141,true) -- disable melee
      DisableControlAction(0,142,true) -- disable melee
      DisableControlAction(0,143,true) -- disable melee
      DisableControlAction(0,257,true) -- disable melee
      DisableControlAction(0,263,true) -- disable melee
      DisableControlAction(0,264,true) -- disable melee
      DisableControlAction(0,311,true) -- disable seatbelt (K)
      DisableControlAction(0,323,true) -- disable handsup2 (X)
      DisableControlAction(0,244,true) -- disable flipoff (M)
    end
  end
end)

-- JAIL

local jail = nil

-- jail the player in a no-top no-bottom cylinder
function tvRP.jail(x,y,z,radius)
  tvRP.teleport(x,y,z) -- teleport to center
  jail = {x+0.0001,y+0.0001,z+0.0001,radius+0.0001}
end

-- unjail the player
function tvRP.unjail()
  jail = nil
end

function tvRP.isJailed()
  return jail ~= nil
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(5)
    if jail then
      local x,y,z = tvRP.getPosition()

      local dx = x-jail[1]
      local dy = y-jail[2]
      local dist = math.sqrt(dx*dx+dy*dy)

      if dist >= jail[4] then
        local ped = GetPlayerPed(-1)
        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001) -- stop player

        -- normalize + push to the edge + add origin
        dx = dx/dist*jail[4]+jail[1]
        dy = dy/dist*jail[4]+jail[2]

        -- teleport player at the edge
        SetEntityCoordsNoOffset(ped,dx,dy,z,true,true,true)
      end
    end
  end
end)

-- WANTED

-- wanted level sync
local wanted_level = 0

function tvRP.applyWantedLevel(new_wanted)
  Citizen.CreateThread(function()
    local old_wanted = GetPlayerWantedLevel(PlayerId())
    local wanted = math.max(old_wanted,new_wanted)
    ClearPlayerWantedLevel(PlayerId())
    SetPlayerWantedLevelNow(PlayerId(),false)
    Citizen.Wait(10)
    SetPlayerWantedLevel(PlayerId(),wanted,false)
    SetPlayerWantedLevelNow(PlayerId(),false)
  end)
end

-- update wanted level
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(2000)

    -- if cop, reset wanted level
    if cop then
      ClearPlayerWantedLevel(PlayerId())
      SetPlayerWantedLevelNow(PlayerId(),false)
    end

    -- update level
    local nwanted_level = GetPlayerWantedLevel(PlayerId())
    if nwanted_level ~= wanted_level then
      wanted_level = nwanted_level
      vRPserver.updateWantedLevel({wanted_level})
    end
  end
end)




RegisterNetEvent("vRPpolice-handcuff:Target")
AddEventHandler("vRPpolice-handcuff:Target", function(source)
  local playerPed = GetPlayerPed(-1)
  local targetPed = GetPlayerPed(GetPlayerFromServerId(source))
  RequestAnimDict("mp_arrest_paired")
  while not HasAnimDictLoaded("mp_arrest_paired") do
    Citizen.Wait(10)
  end
  AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_left", 8.0, -8.0, 5500, 33, 0, false, false, false)
	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)
end)

RegisterNetEvent("vRPpolice-handcuff:Player")
AddEventHandler("vRPpolice-handcuff:Player", function()
	local playerPed = GetPlayerPed(-1)
	RequestAnimDict("mp_arrest_paired")
	while not HasAnimDictLoaded("mp_arrest_paired") do
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, "mp_arrest_paired", "cop_p2_back_left", 8.0, -8.0, 5500, 33, 0, false, false, false)
end)

RegisterNetEvent('vRPpolice-unhandcuff:Target')
AddEventHandler('vRPpolice-unhandcuff:Target', function(source)
  local playerPed = GetPlayerPed(-1)
  local targetPed = GetPlayerPed(GetPlayerFromServerId(source))
  RequestAnimDict("mp_arresting")
  while not HasAnimDictLoaded("mp_arresting") do
    Citizen.Wait(10)
  end
  AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, "mp_arresting", "b_uncuff", 8.0, -8.0, 5500, 33, 0, false, false, false)
	Citizen.Wait(5500)
	DetachEntity(GetPlayerPed(-1), true, false)
  ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('vRPpolice-unhandcuff:Player')
AddEventHandler('vRPpolice-unhandcuff:Player', function()
  local playerPed = GetPlayerPed(-1)
	RequestAnimDict('mp_arresting')
	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, 'mp_arresting', "a_uncuff", 8.0, -8.0, 5500, 33, 0, false, false, false)
end)
