RegisterNetEvent("revive")
AddEventHandler("revive", function()
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
	SetEntityHealth(GetPlayerPed(-1), 200)
end)

vRP = Proxy.getInterface("vRP")
-- Register a network event 
RegisterNetEvent( 'wk:deleteVehicle' )

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 10.0

-- Add an event handler for the deleteVehicle event. 
-- Gets called when a user types in /dv in chat (see server.lua)
AddEventHandler( 'wk:deleteVehicle', function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )

                if ( DoesEntityExist( vehicle ) ) then 
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Kunen ikke fjerne Køretøjet, prøv igen",
                        type = "warning",
                        timeout = (3000),
                        layout = "bottomCenter",
                        queue = "global",
                        killer=true,
                        animation = {
                        open = "gta_effects_fade_in", 
                        close = "gta_effects_fade_out",
                        }
                        })
                else 
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Køretøj fjernet",
                        type = "info",
                        timeout = (3000),
                        layout = "bottomCenter",
                        queue = "global",
                        killer=true,
                        animation = {
                        open = "gta_effects_fade_in", 
                        close = "gta_effects_fade_out",
                        }
                        })
                end 
            else 
                TriggerEvent("pNotify:SendNotification",{
                    text = "Du skal være i forsædet!",
                    type = "error",
                    timeout = (3000),
                    layout = "bottomCenter",
                    queue = "global",
                    killer=true,
                    animation = {
                    open = "gta_effects_fade_in", 
                    close = "gta_effects_fade_out",
                    }
                    })
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )

                if ( DoesEntityExist( vehicle ) ) then 
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Kunen ikke fjerne Køretøjet, prøv igen",
                        type = "warning",
                        timeout = (3000),
                        layout = "bottomCenter",
                        queue = "global",
                        killer=true,
                        animation = {
                        open = "gta_effects_fade_in", 
                        close = "gta_effects_fade_out",
                        }
                        })
                else 
                    TriggerEvent("pNotify:SendNotification",{
                        text = "Køretøj fjernet",
                        type = "info",
                        timeout = (3000),
                        layout = "bottomCenter",
                        queue = "global",
                        killer=true,
                        animation = {
                        open = "gta_effects_fade_in", 
                        close = "gta_effects_fade_out",
                        }
                        })
                end 
            else 
                TriggerEvent("pNotify:SendNotification",{
                    text = "Du skal være tæt eller inde i køretøj for at kunne fjerne den",
                    type = "error",
                    timeout = (3000),
                    layout = "bottomCenter",
                    queue = "global",
                    killer=true,
                    animation = {
                    open = "gta_effects_fade_in", 
                    close = "gta_effects_fade_out",
                    }
                    })
            end 
        end 
    end 
end )

-- Delete car function borrowed frtom Mr.Scammer's model blacklist, thanks to him!
function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end




RegisterNetEvent('admin:uncuff', function()
	local user_id = vRP.getUserId(source)

	if vRP.isHandcuffed(user_id) then
		vRP.toggleHandcuff(user_id,{})
		TriggerEvent("pNotify:SendNotification",{text = "Du har fået dirket dine håndjern op!",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	else
		TriggerEvent("pNotify:SendNotification",{text = "Du er ikke i håndjern!",type = "info",timeout = (2000),layout = "bottomCenter",queue = "global",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
	end
end)

RegisterNetEvent("murtaza:fix")
AddEventHandler("murtaza:fix", function()
	local playerPed = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed)
		SetVehicleEngineHealth(vehicle, 9999)
		SetVehiclePetrolTankHealth(vehicle, 9999)
		SetVehicleFixed(vehicle)
	else
	end
end)

function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end
