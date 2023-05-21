--==vRP connection==--
local vRP = Proxy.getInterface("vRP")
--===================================--

--==Variables==--
local componentFitWeapon = nil
--===================================--

--==Events==--
RegisterNetEvent("V1N_attachments:equipComponent", function(item)
    for k,v in pairs(cfg.attachments) do
        if cfg.attachments[k].itemName == item then
            local components = cfg.attachments[k].components
            for k,v in pairs(components) do
                local hashKey = GetSelectedPedWeapon(GetPlayerPed(-1))
                if DoesWeaponTakeWeaponComponent(hashKey, GetHashKey(v)) then
                    if not HasPedGotWeaponComponent(GetPlayerPed(-1), hashKey, GetHashKey(v)) then
                        GiveWeaponComponentToPed(PlayerPedId(), hashKey, GetHashKey(v))
                        vRP.notify({'~b~Du satte en '..item:lower()..' på dit våben'})
                        return
                    else
                        RemoveWeaponComponentFromPed(PlayerPedId(), hashKey, GetHashKey(v))
                        vRP.notify({'~b~Du tog en '..item:lower()..' af dit våben'})
                        return
                    end
                    componentFitWeapon = true
                    return
                else
                    componentFitWeapon = false
                end
            end
            if not componentFitWeapon then
                vRP.notify({'~r~Du kan ikke sætte et '..item:lower()..' på dette våben!'})
            end
        end
    end
end)
--===================================--
