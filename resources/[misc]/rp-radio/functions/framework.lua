
if IsDuplicityVersion() then -- Check if server sided
    if true then
        Scully.Functions = {
            GetPlayerName = function(source)
                local xPlayer = GetPlayer(source)
                local identity = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_identities WHERE user_id = @id", {id = xPlayer})
                return identity[1].firstname ..' '.. identity[1].name
            end,
        }

        if Scully.UseItem then
            AddEventHandler('ox_inventory:usedItem', function(source, name, slotId, metadata) -- OX_Inventory -- Gjordt så det fungere med nyt inv (kian)
                --if Scully.AllowColours and Scully.UseItemColours then
                    if name == 'radio' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'default')
                    elseif name == 'radio_blue' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'blue')
                    elseif name == 'radio_brown' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'brown')
                    elseif name == 'radio_cherry' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'cherry')
                    elseif name == 'radio_green' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'green')
                    elseif name == 'radio_mint' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'mint')
                    elseif name == 'radio_orange' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'orange')
                    elseif name == 'radio_pink' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'pink')
                    elseif name == 'radio_purple' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'purple')
                    elseif name == 'radio_red' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'red')
                    elseif name == 'radio_yellow' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'yellow')
                    elseif name == 'radio_white' then
                        TriggerClientEvent('scully_radio:openRadio', source, 'white')
                    end
                --else
                --    if name == 'radio' then
                --        TriggerClientEvent('scully_radio:openRadio', source, 'default')
                --    end
                --end
            end)
        end
    elseif Scully.Framework == 'es_extended' then
        local ESX = exports['es_extended']:getSharedObject()

        Scully.Functions = {
            GetPlayerName = function(source)
                local xPlayer = ESX.GetPlayerFromId(source)
                local firstName = xPlayer.get('firstName')
                if firstName then
                    return '', string.sub(firstName, 1, 1) .. '. ' .. xPlayer.get('lastName')
                else
                    return '', GetPlayerName(source)
                end
            end,
        }

        if Scully.UseItem then
            if Scully.AllowColours and Scully.UseItemColours then
                ESX.RegisterUsableItem('radio', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'default')
                end)
                ESX.RegisterUsableItem('radio_blue', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'blue')
                end)
                ESX.RegisterUsableItem('radio_brown', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'brown')
                end)
                ESX.RegisterUsableItem('radio_cherry', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'cherry')
                end)
                ESX.RegisterUsableItem('radio_green', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'green')
                end)
                ESX.RegisterUsableItem('radio_green', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'green')
                end)
                ESX.RegisterUsableItem('radio_orange', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'orange')
                end)
                ESX.RegisterUsableItem('radio_pink', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'pink')
                end)
                ESX.RegisterUsableItem('radio_purple', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'purple')
                end)
                ESX.RegisterUsableItem('radio_red', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'red')
                end)
                ESX.RegisterUsableItem('radio_yellow', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'yellow')
                end)
                ESX.RegisterUsableItem('radio_white', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'white')
                end)
            else
                ESX.RegisterUsableItem('radio', function(source)
                    TriggerClientEvent('scully_radio:openRadio', source, 'default')
                end)
            end
        end
    elseif Scully.Framework == 'scully_core' then
        Scully.Functions = {
            GetPlayerName = function(source)
                local xPlayer = exports.scully_core:GetPlayerDataFromId(source)
                if xPlayer.character then
                    return xPlayer.character.callsign .. ' | ', string.sub(xPlayer.character.firstname, 1, 1) .. '. ' .. xPlayer.character.lastname
                else
                    return '', GetPlayerName(source)
                end
            end,
        }
    else
        Scully.Functions = {
            GetPlayerName = function(source)
                return '', GetPlayerName(source)
            end,
        }

        RegisterNetEvent('scully_radio:getPermissions', function()
            local _source = source
            local permissions = {}
            for k, v in ipairs(Scully.AcePerms) do
                if IsPlayerAceAllowed(_source, 'radio.' .. v) then
                    permissions[v] = true
                end
            end
            TriggerClientEvent('scully_radio:sendPermissions', _source, permissions)
        end)
    end
else
    local PlayerData = {}
    if Scully.Framework == 'qb-core' then
        PlayerData = QBCore.Functions.GetPlayerData()

        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            PlayerData = QBCore.Functions.GetPlayerData()
        end)

        RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
            PlayerData = {}
            TriggerEvent('scully_radio:leaveChannel', true)
        end)

        RegisterNetEvent('QBCore:Player:SetPlayerData', function(newData)
            PlayerData = QBCore.Functions.GetPlayerData()
        end)

        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(newJob)
            PlayerData.job = newJob
        end)

        RegisterNetEvent('qb-radio:onRadioDrop', function()
            TriggerEvent('scully_radio:leaveChannel', true)
        end)

        Scully.Functions = {
            HasAccess = function(channel)
                return Scully.WhitelistedAccess[channel][PlayerData.job.name]
            end,
            HasItem = function(item, cb)
                local hasItem = false
                for k, v in pairs(PlayerData.itEMS-Job) do
                    if v.name == item then
                        if PlayerData.itEMS-Job[k].amount > 0 then
                            hasItem = true
                            break
                        end
                    end
                end
                cb(hasItem)
            end,
            ShowNotification = function(text)
                if string.match(text, '~g~') then
                    QBCore.Functions.Notify(string.gsub(text, '~g~', ''), 'success')
                elseif string.match(text, '~r~') then
                    QBCore.Functions.Notify(string.gsub(text, '~r~', ''), 'error')
                else
                    QBCore.Functions.Notify(text, 'success')
                end
            end
        }
    elseif Scully.Framework == 'es_extended' then
        local ESX = exports['es_extended']:getSharedObject()
        PlayerData = ESX.GetPlayerData()

        RegisterNetEvent('esx:playerLoaded', function(newData)
            LocalPlayer.state:set('isLoggedIn', true, false)
            PlayerData = newData
        end)

        RegisterNetEvent('esx:onPlayerLogout', function()
            LocalPlayer.state:set('isLoggedIn', false, false)
            PlayerData = {}
            TriggerEvent('scully_radio:leaveChannel', true)
        end)

        RegisterNetEvent('esx:setPlayerData', function(key, val)
            if GetInvokingResource() == 'es_extended' then
                PlayerData[key] = val
            end
        end)

        RegisterNetEvent('esx:removeInventoryItem', function(item, count)
            local itemName = item
            if type(item) == 'table' then itemName = item.name end
            if string.match(itemName, 'radio') then
                if count < 1 then
                    TriggerEvent('scully_radio:leaveChannel', true)
                end
            end
        end)

        RegisterNetEvent('esx:setJob', function(JobInfo)
            PlayerData.job = JobInfo
        end)

        Scully.Functions = {
            HasAccess = function(channel)
                return Scully.WhitelistedAccess[channel][PlayerData.job.name]
            end,
            HasItem = function(item, cb)
                local hasItem = false
                for k, v in pairs(PlayerData.inventory) do
                    if v.name == item then
                        if PlayerData.inventory[k].count > 0 then
                            hasItem = true
                            break
                        end
                    end
                end
                cb(hasItem)
            end,
            ShowNotification = function(text)
                ESX.ShowNotification(text)
            end
        }
    elseif Scully.Framework == 'scully_core' then
        RegisterNetEvent('playerSpawned', function()
            LocalPlayer.state:set('isLoggedIn', true, false)
        end)

        Scully.Functions = {
            HasAccess = function(channel)
                local myJob = 'unemployed'
                if exports.scully_core:GetJobStatus('Politi-Job') then
                    myJob = 'Politi-Job'
                elseif exports.scully_core:GetJobStatus('EMS-Job') then
                    myJob = 'EMS-Job'
                end
                return Scully.WhitelistedAccess[channel][myJob]
            end,
            HasItem = function(item, cb)
                cb(true)
            end,
            ShowNotification = function(text)
                TriggerEvent('scully:core:shownotification', text)
            end
        }
    else
        CreateThread(function()
            TriggerServerEvent('scully_radio:getPermissions')
        end)

        RegisterNetEvent('scully_radio:sendPermissions', function(permissions)
            PlayerData.permissions = permissions
        end)

        RegisterNetEvent('playerSpawned', function()
            LocalPlayer.state:set('isLoggedIn', true, false)
        end)

        Scully.Functions = {
            HasAccess = function(channel)
                local isAllowed = false
                for permission, _ in pairs(Scully.WhitelistedAccess[channel]) do
                    if PlayerData.permissions[permission] then
                        isAllowed = true
                    end
                end
                return isAllowed
            end,
            HasItem = function(item, cb)
                cb(true)
            end,
            ShowNotification = function(text)
                SetNotificationTextEntry('STRING')
                AddTextComponentString(text)
                DrawNotification(true, true)
            end
        }
    end
end