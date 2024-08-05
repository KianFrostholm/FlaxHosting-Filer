local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
local QBPhone = {}
local AppAlerts = {}
local MentionedTweets = {}
local Hashtags = {}
local Calls = {}
local Adverts = {}
local GeneratedPlates = {}
local bannedCharacters = { '%', '$', ';' }
local TWData = {}

-- Functions

local function GetOnlineStatus(number)
    local Target = GetPlayerByPhone({number})
    local retval = false
    if Target ~= nil then
        retval = true
    end
    return retval
end

local function GenerateMailId()
    return math.random(111111, 999999)
end

local function escape_sqli(source)
    local replacements = {
        ['"'] = '\\"',
        ["'"] = "\\'"
    }
    return source:gsub("['\"]", replacements)
end

local function round(num, numDecimalPlaces)
    if numDecimalPlaces and numDecimalPlaces > 0 then
        local mult = 10 ^ numDecimalPlaces
        return math.floor(num * mult + 0.5) / mult
    end
    return math.floor(num + 0.5)
end

function QBPhone.AddMentionedTweet(citizenid, TweetData)
    if MentionedTweets[citizenid] == nil then
        MentionedTweets[citizenid] = {}
    end
    MentionedTweets[citizenid][#MentionedTweets[citizenid] + 1] = TweetData
end

function QBPhone.SetPhoneAlerts(citizenid, app, alerts)
    if citizenid ~= nil and app ~= nil then
        if AppAlerts[citizenid] == nil then
            AppAlerts[citizenid] = {}
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = alerts
                end
            end
        else
            if AppAlerts[citizenid][app] == nil then
                if alerts == nil then
                    AppAlerts[citizenid][app] = 1
                else
                    AppAlerts[citizenid][app] = 0
                end
            else
                if alerts == nil then
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 1
                else
                    AppAlerts[citizenid][app] = AppAlerts[citizenid][app] + 0
                end
            end
        end
    end
end


local function SplitStringToArray(string)
    local retval = {}
    for i in string.gmatch(string, '%S+') do
        retval[#retval + 1] = i
    end
    return retval
end

local function GenerateOwnerName()
    local names = {
        [1] = { name = 'Bailey Sykes', citizenid = 'DSH091G93' },
        [2] = { name = 'Aroush Goodwin', citizenid = 'AVH09M193' },
        [3] = { name = 'Tom Warren', citizenid = 'DVH091T93' },
        [4] = { name = 'Abdallah Friedman', citizenid = 'GZP091G93' },
        [5] = { name = 'Lavinia Powell', citizenid = 'DRH09Z193' },
        [6] = { name = 'Andrew Delarosa', citizenid = 'KGV091J93' },
        [7] = { name = 'Skye Cardenas', citizenid = 'ODF09S193' },
        [8] = { name = 'Amelia-Mae Walter', citizenid = 'KSD0919H3' },
        [9] = { name = 'Elisha Cote', citizenid = 'NDX091D93' },
        [10] = { name = 'Janice Rhodes', citizenid = 'ZAL0919X3' },
        [11] = { name = 'Justin Harris', citizenid = 'ZAK09D193' },
        [12] = { name = 'Montel Graves', citizenid = 'POL09F193' },
        [13] = { name = 'Benjamin Zavala', citizenid = 'TEW0J9193' },
        [14] = { name = 'Mia Willis', citizenid = 'YOO09H193' },
        [15] = { name = 'Jacques Schmitt', citizenid = 'QBC091H93' },
        [16] = { name = 'Mert Simmonds', citizenid = 'YDN091H93' },
        [17] = { name = 'Rickie Browne', citizenid = 'PJD09D193' },
        [18] = { name = 'Deacon Stanley', citizenid = 'RND091D93' },
        [19] = { name = 'Daisy Fraser', citizenid = 'QWE091A93' },
        [20] = { name = 'Kitty Walters', citizenid = 'KJH0919M3' },
        [21] = { name = 'Jareth Fernandez', citizenid = 'ZXC09D193' },
        [22] = { name = 'Meredith Calhoun', citizenid = 'XYZ0919C3' },
        [23] = { name = 'Teagan Mckay', citizenid = 'ZYX0919F3' },
        [24] = { name = 'Kurt Bain', citizenid = 'IOP091O93' },
        [25] = { name = 'Burt Kain', citizenid = 'PIO091R93' },
        [26] = { name = 'Joanna Huff', citizenid = 'LEK091X93' },
        [27] = { name = 'Carrie-Ann Pineda', citizenid = 'ALG091Y93' },
        [28] = { name = 'Gracie-Mai Mcghee', citizenid = 'YUR09E193' },
        [29] = { name = 'Robyn Boone', citizenid = 'SOM091W93' },
        [30] = { name = 'Aliya William', citizenid = 'KAS009193' },
        [31] = { name = 'Rohit West', citizenid = 'SOK091093' },
        [32] = { name = 'Skylar Archer', citizenid = 'LOK091093' },
        [33] = { name = 'Jake Kumar', citizenid = 'AKA420609' },
    }
    return names[math.random(1, #names)]
end


local function sendNewMailToOffline(user_id, mailData)
    if user_id then
        local src = vRP.getUserSource({user_id})

        if mailData.button == nil then
            MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {user_id, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0 })
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        else
            MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', {user_id, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button) })
            TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)
        end

        local mails = MySQL.query.await(
        'SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', {user_id})
        if mails[1] ~= nil then
            for k, _ in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
        end

        TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
    else
        if mailData.button == nil then
            MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', {user_id, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0 })
        else
            MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', {user_id, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button) })
        end
    end
end
exports('sendNewMailToOffline', sendNewMailToOffline)
-- Callbacks

lib.callback.register('qb-phone:server:GetCallState', function(_, ContactData)
    local res = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_identities WHERE phone = ?", {ContactData.number})

    if not res then return end

    local Target = res[1].user_id
    --print('Target: call: '..ContactData.number)
    if Target ~= nil then
        if Calls[Target] ~= nil then
            if Calls[Target].inCall then
                return false, true
            else
                return true, true
            end
        else
            return true, true
        end
    else
        return false, false
    end
end)

lib.callback.register('qb-phone:server:GetPhoneData', function(src)
    local user_id = vRP.getUserId({src})

    if user_id ~= nil then
        local PhoneData = {
            Applications = {},
            PlayerContacts = {},
            MentionedTweets = {},
            Chats = {},
            Hashtags = {},
            Invoices = {},
            Garage = {},
            Mails = {},
            Adverts = {},
            CryptoTransactions = {},
            Tweets = {},
            Images = {},
            InstalledApps = {} -- Player.PlayerData.metadata['phonedata'].InstalledApps
        }

        PhoneData.Adverts = Adverts

        local result = MySQL.query.await('SELECT * FROM player_contacts WHERE citizenid = ? ORDER BY name ASC', {user_id})
        
        if result[1] ~= nil then
            for _, v in pairs(result) do
                v.status = GetOnlineStatus(v.number)
            end

            PhoneData.PlayerContacts = result
        end

        local invoices = MySQL.query.await('SELECT * FROM phone_invoices WHERE citizenid = ?', {user_id})

        if invoices[1] ~= nil then
            for _, v in pairs(invoices) do

                local Ply = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {v.sender})[1] --QBCore.Functions.GetPlayerByCitizenId(v.sender)

                if Ply ~= nil then
                    v.number = Ply.phone
                else
                    local res = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {v.sender})
                    if res[1] ~= nil then
                        res[1].charinfo = json.decode(res[1].charinfo)
                        v.number = res[1].charinfo.phone
                    else
                        v.number = nil
                    end
                end
            end
            PhoneData.Invoices = invoices
        end

        local messages = MySQL.query.await('SELECT * FROM phone_messages WHERE citizenid = ?', {user_id})
        if messages ~= nil and next(messages) ~= nil then
            PhoneData.Chats = messages
        end

        if AppAlerts[user_id] ~= nil then
            PhoneData.Applications = AppAlerts[user_id]
        end

        if MentionedTweets[user_id] ~= nil then
            PhoneData.MentionedTweets = MentionedTweets[user_id]
        end

        if Hashtags ~= nil and next(Hashtags) ~= nil then
            PhoneData.Hashtags = Hashtags
        end

        local Tweets = MySQL.query.await('SELECT * FROM phone_tweets WHERE `date` > NOW() - INTERVAL ? hour', { Config.TweetDuration })

        if Tweets ~= nil and next(Tweets) ~= nil then
            PhoneData.Tweets = Tweets
            TWData = Tweets
        end

        local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', { user_id })
        if mails[1] ~= nil then
            for k, _ in pairs(mails) do
                if mails[k].button ~= nil then
                    mails[k].button = json.decode(mails[k].button)
                end
            end
            PhoneData.Mails = mails
        end

        local transactions = MySQL.query.await('SELECT * FROM crypto_transactions WHERE citizenid = ? ORDER BY `date` ASC', { user_id })
        if transactions[1] ~= nil then
            for _, v in pairs(transactions) do
                PhoneData.CryptoTransactions[#PhoneData.CryptoTransactions + 1] = {
                    TransactionTitle = v.title,
                    TransactionMessage = v.message
                }
            end
        end
        local images = MySQL.query.await('SELECT * FROM phone_gallery WHERE citizenid = ? ORDER BY `date` DESC', { user_id })
        if images ~= nil and next(images) ~= nil then
            PhoneData.Images = images
        end
        return PhoneData
    end
end)

lib.callback.register('qb-phone:server:PayInvoice', function(src, society, amount, invoiceId, sendercitizenid)
    local Invoices = {}
    local Ply = vRP.getUserId({src})
    local PlyId = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {Player})[1]
    local SenderPly = vRP.getUserId({sendercitizenid})
    local invoiceMailData = {}

    if SenderPly and Config.BillingCommissions[society] then
        local commission = round(amount * Config.BillingCommissions[society])
        vRP.giveBankMoney({SenderPly, commission})
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Commission Received',
            message = string.format('You received a commission check of $%s when %s %s paid a bill of $%s.', commission, PlyId.firstname, PlyId.name, amount)
        }
    elseif not SenderPly and Config.BillingCommissions[society] then
        invoiceMailData = {
            sender = 'Billing Department',
            subject = 'Bill Paid',
            message = string.format('%s %s paid a bill of $%s', PlyId.firstname, PlyId.name, amount)
        }
    end

    vRP.tryBankPayment({Ply, amount})

    -- Lav firma transaction function
    exports['ef-phone']:sendNewMailToOffline(sendercitizenid, invoiceMailData)

    exports['qb-banking']:AddMoney(society, amount, 'Phone invoice')
    -- -- --


    MySQL.query('DELETE FROM phone_invoices WHERE id = ?', { invoiceId })
    local invoices = MySQL.query.await('SELECT * FROM phone_invoices WHERE citizenid = ?', {Ply})

    if invoices[1] ~= nil then
        Invoices = invoices
    end

    return true, Invoices
end)

lib.callback.register('qb-phone:server:DeclineInvoice', function(src, _, _, invoiceId)
    local Invoices = {}
    local Ply = vRP.getUserId({src})

    MySQL.query('DELETE FROM phone_invoices WHERE id = ?', { invoiceId })

    local invoices = MySQL.query.await('SELECT * FROM phone_invoices WHERE citizenid = ?', { Ply })

    if invoices[1] ~= nil then
        Invoices = invoices
    end

    return true, Invoices
end)

lib.callback.register('qb-phone:server:GetContactPictures', function(_, Chats)
    for _, v in pairs(Chats) do
        local user_id = GetPlayerByPhone({v.number})
        
        if user_id ~= nil then
            local Data = vRP.getUserDataTable({user_id})
            if not Data.metadata then return end
            if Data.metadata.phone.profilepicture ~= nil then
                v.picture = Data.metadata.phone.profilepicture
            else
                v.picture = 'default'
            end
        end
    end

    return Chats
end)

lib.callback.register('qb-phone:server:GetContactPicture', function(_, Chat)
    local result = GetPlayerByPhone({Chat.number})
    local user_id, src = result
    local MetaData = vRP.getUserDataTable({user_id})

    if MetData then
        if MetaData.phone.profilepicture ~= nil then
            Chat.picture = MetaData.phone.profilepicture
        else
            Chat.picture = 'default'
        end
    else
        Chat.picture = 'default'
    end

    return Chat
end)

lib.callback.register('qb-phone:server:GetPicture', function(_, number)
    local user_id = GetPlayerByPhone({number})

    if user_id ~= nil then
        local Picture = 'default'
        local MetaData = vRP.getUserDataTable({user_id})

        if MetaData.metadata.phone.profilepicture ~= nil then
            Picture = MetaData.metadata.phone.profilepicture
        end

        return Picture
    else
        return nil
    end
end)

lib.callback.register('qb-phone:server:FetchResult', function(_, search)
    search = escape_sqli(search)
    local searchData = {}
    local ApaData = {}
    local searchParameters = SplitStringToArray(search)
    --print('Search Params: ', searchParameters[1], searchParameters[2], searchParameters[3])
    
    local query = 'SELECT * FROM `vrp_user_identities`'
    local conditions = {}

    -- Handle first name or last name search
    if searchParameters[1] then
        -- Check if it could be a first name or last name
        local firstNameCondition = '`firstname` LIKE "%' .. searchParameters[1] .. '%"'
        local lastNameCondition = '`name` LIKE "%' .. searchParameters[1] .. '%"'
        table.insert(conditions, firstNameCondition)
        table.insert(conditions, lastNameCondition)
    end
    
    -- Handle last name search if provided separately
    if searchParameters[2] then
        table.insert(conditions, '`name` LIKE "%' .. searchParameters[2] .. '%"')
    end
    
    -- Handle user ID search if provided
    if searchParameters[3] then
        table.insert(conditions, '`user_id` = "' .. searchParameters[3] .. '"')
    end

    -- Combine all conditions with OR if any condition exists
    if #conditions > 0 then
        query = query .. ' WHERE ' .. table.concat(conditions, ' OR ')
    end

    -- Fetch all apartment data once
    local ApartmentData = MySQL.query.await('SELECT * FROM vrp_user_homes')
    for k, v in pairs(ApartmentData) do
        ApaData[v.user_id] = v
    end
    
    -- Fetch results based on the query
    local result = MySQL.query.await(query)
    
    if result[1] ~= nil then
        for _, v in pairs(result) do
            local license = MySQL.Sync.fetchAll('SELECT * FROM vrp_users WHERE id = ?', {v.user_id})[1]
            local aps = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_homes WHERE user_id = ?", {v.user_id})
            
            local appartmentdata = {}
            if #aps > 0 then
                appartmentdata.label = aps[1].home .. ' ' .. aps[1].number
                appartmentdata.type = aps[1].home
            end
    
            table.insert(searchData, {
                citizenid = v.user_id,
                firstname = v.firstname,
                lastname = v.name,
                birthdate = v.registration,
                phone = v.phone,
                nationality = '',
                gender = '',
                warrant = false,
                driverlicense = license.DmvTest,
                appartmentdata = appartmentdata
            })
        end
        return searchData
    else
        return nil
    end    
end)

lib.callback.register('qb-phone:server:GetVehicleSearchResults', function(_, search)
    search = escape_sqli(search)
    local searchData = {}
    local query = '%' .. search .. '%'
    local result = MySQL.query.await('SELECT * FROM vrp_user_vehicles WHERE vehicle_plate LIKE ? OR user_id = ?',
        { query, search })
    if result[1] ~= nil then
        for k, _ in pairs(result) do
            local player = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', { result[k].user_id })
            if player[1] ~= nil then
                
                local charinfo = player[1]

                local vehicleInfo = QBShared.Vehicles[result[k].vehicle]

                if vehicleInfo ~= nil then
                    searchData[#searchData + 1] = {
                        plate = result[k].vehicle_plate,
                        status = true,
                        owner = charinfo.firstname .. ' ' .. charinfo.name,
                        citizenid = result[k].user_id,
                        label = vehicleInfo['vehicle']
                    }
                else
                    searchData[#searchData + 1] = {
                        plate = result[k].vehicle_plate,
                        status = true,
                        owner = charinfo.firstname .. ' ' .. charinfo.name,
                        citizenid = result[k].user_id,
                        label = 'Navn ikke fundet..'
                    }
                end
            end
        end
    else
        if GeneratedPlates[search] ~= nil then
            searchData[#searchData + 1] = {
                plate = GeneratedPlates[search].plate,
                status = GeneratedPlates[search].status,
                owner = GeneratedPlates[search].owner,
                citizenid = GeneratedPlates[search].citizenid,
                label = 'Brand unknown..'
            }
        else
            local ownerInfo = GenerateOwnerName()
            GeneratedPlates[search] = {
                plate = search,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
            searchData[#searchData + 1] = {
                plate = search,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid,
                label = 'Mærke ukendt..'
            }
        end
    end
    return searchData
end)

lib.callback.register('qb-phone:server:ScanPlate', function(source, plate)
    local src = source
    local vehicleData

    if plate ~= nil then
        local result = MySQL.query.await('SELECT * FROM vrp_user_vehicles WHERE vehicle_plate = ?', { plate })
        if result[1] ~= nil then
            local charinfo = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {result[1].user_id})[1]
            vehicleData = {
                plate = plate,
                status = true,
                owner = charinfo.firstname .. ' ' .. charinfo.name,
                citizenid = result[1].user_id
            }
        elseif GeneratedPlates ~= nil and GeneratedPlates[plate] ~= nil then
            vehicleData = GeneratedPlates[plate]
        else
            local ownerInfo = GenerateOwnerName()
            GeneratedPlates[plate] = {
                plate = plate,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
            vehicleData = {
                plate = plate,
                status = true,
                owner = ownerInfo.name,
                citizenid = ownerInfo.citizenid
            }
        end
        return vehicleData
    else
        TriggerClientEvent('ef-phone:Notify', src, 'No Vehicle Nearby', 'error')
        return nil
    end
end)

lib.callback.register('qb-phone:server:HasPhone', function(src)
    local Player = vRP.getUserId({src})
    if Player ~= nil then
        local HasPhone = vRP.getInventoryItemAmount({Player, Config.Item})

        if HasPhone > 0 then
            return true
        else
            return false
        end
    end
end)

lib.callback.register('qb-phone:server:CanTransferMoney', function(src, amount, iban)
    local newAmount = tostring(amount)
    local newiban = tostring(iban)

    for _, v in pairs(bannedCharacters) do
        newAmount = string.gsub(newAmount, '%' .. v, '')
        newiban = string.gsub(newiban, '%' .. v, '')
    end

    iban = newiban
    amount = tonumber(newAmount)

    local Player = vRP.getUserId({src})

    if (vRP.getBankMoney({Player}) - amount) >= 0 then
        local result = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE registration LIKE ?', { iban })

        if result[1] ~= nil then
            local Reciever = vRP.getUserSource({tonumber(result[1].user_id)})
            local RecieverMoney = MySQL.query.await('SELECT * FROM vrp_user_moneys WHERE user_id LIKE ?', { result[1].user_id })

            vRP.tryBankPayment({Player, amount})

            if Reciever ~= nil then
                vRP.giveBankMoney({Reciever, amount})
            else
                local RecieverMoney = json.decode(result[1].bank)

                MySQL.update('UPDATE vrp_user_moneys SET bank = ? WHERE user_id = ?', { vRP.getBankMoney({result[1].user_id}) + amount, result[1].user_id })
            end

            return true
        else
            return false
        end
    end
end)

lib.callback.register('qb-phone:server:GetCurrentLawyers', function()
    local Lawyers = {}

    for _, src in pairs(vRP.getUsers({})) do
        local Player = vRP.getUserId({src})
        local PlayerJob = vRP.getUserGroupByType({Player, 'job'})
        local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {Player})[1]

        if Player ~= nil then
            if (PlayerJob == 'Advokat' or 
                PlayerJob == 'Ejendomsmægler' or
                PlayerJob == 'Mekaniker' or 
                PlayerJob == 'Taxi' or
                PlayerJob == 'Politi-Job' or 
                PlayerJob == 'EMS') 
                then

                Lawyers[#Lawyers + 1] = {
                    name = i.firstname .. ' ' .. i.name,
                    phone = i.phone,
                    typejob = PlayerJob
                }

            end
        end
    end
    
    return Lawyers
end)

lib.callback.register('qb-phone:server:GetWebhook', function(_)
    if Config.Webhook ~= '' then
        return Config.Webhook
    else
        print('Webhook er ikke opsat - venligst opsæt webook for at kamera virker')
        return nil
    end
end)

-- Events

RegisterNetEvent('qb-phone:server:AddAdvert', function(msg, url)
    local src = source
    local CitizenId = vRP.getUserId({src})
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {CitizenId})[1]

    --print('Addvertisment test: ', CitizenId, msg, url)

    if Adverts[CitizenId] ~= nil then
        Adverts[CitizenId].message = msg
        Adverts[CitizenId].name = '@' .. i.firstname .. '' .. i.name
        Adverts[CitizenId].number = i.phone
        Adverts[CitizenId].url = url
    else
        Adverts[CitizenId] = {
            message = msg,
            name = '@' .. i.firstname .. '' .. i.name,
            number = i.phone,
            url = url
        }
    end
    TriggerClientEvent('qb-phone:client:UpdateAdverts', -1, Adverts, '@' .. i.firstname .. '' .. i.name)
end)

RegisterNetEvent('qb-phone:server:DeleteAdvert', function()
    local citizenid = vRP.getUserId({src})
    Adverts[citizenid] = nil
    TriggerClientEvent('qb-phone:client:UpdateAdvertsDel', -1, Adverts)
end)

RegisterNetEvent('qb-phone:server:SetCallState', function(bool)
    local src = source
    local citizenid = vRP.getUserId({src})
    if Calls[citizenid] ~= nil then
        Calls[citizenid].inCall = bool
    else
        Calls[citizenid] = {}
        Calls[citizenid].inCall = bool
    end
end)

RegisterNetEvent('qb-phone:server:RemoveMail', function(MailId)
    local src = source
    local Player = vRP.getUserId({src})

    MySQL.query('DELETE FROM player_mails WHERE mailid = ? AND citizenid = ?', { MailId, Player })
    
    local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', { Player })
    if mails[1] ~= nil then
        for k, _ in pairs(mails) do
            if mails[k].button ~= nil then
                mails[k].button = json.decode(mails[k].button)
            end
        end
    end
    
    TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
end)

RegisterNetEvent('qb-phone:server:sendNewMail', function(mailData)
    local src = source
    local Player = vRP.getUserId({src})

    if mailData.button == nil then
        MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', { Player, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0 })
    else
        MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', { Player, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button) })
    end

    TriggerClientEvent('qb-phone:client:NewMailNotify', src, mailData)

    local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` DESC', { Player })
    if mails[1] ~= nil then
        for k, _ in pairs(mails) do
            if mails[k].button ~= nil then
                mails[k].button = json.decode(mails[k].button)
            end
        end
    end

    TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
end)

RegisterNetEvent('qb-phone:server:sendNewEventMail', function(citizenid, mailData)
    local Player = vRP.getUserSource({citizenid})
    if mailData.button == nil then
        MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`) VALUES (?, ?, ?, ?, ?, ?)', { citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0 })
    else
        MySQL.insert('INSERT INTO player_mails (`citizenid`, `sender`, `subject`, `message`, `mailid`, `read`, `button`) VALUES (?, ?, ?, ?, ?, ?, ?)', { citizenid, mailData.sender, mailData.subject, mailData.message, GenerateMailId(), 0, json.encode(mailData.button) })
    end
    
    local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', { citizenid })
    if mails[1] ~= nil then
        for k, _ in pairs(mails) do
            if mails[k].button ~= nil then
                mails[k].button = json.decode(mails[k].button)
            end
        end
    end
    
    TriggerClientEvent('qb-phone:client:UpdateMails', Player, mails)
end)

RegisterNetEvent('qb-phone:server:ClearButtonData', function(mailId)
    local src = source
    local Player = vRP.getUserId({src})
    MySQL.update('UPDATE player_mails SET button = ? WHERE mailid = ? AND citizenid = ?', { '', mailId, Player })
    
    local mails = MySQL.query.await('SELECT * FROM player_mails WHERE citizenid = ? ORDER BY `date` ASC', { Player })
    if mails[1] ~= nil then
        for k, _ in pairs(mails) do
            if mails[k].button ~= nil then
                mails[k].button = json.decode(mails[k].button)
            end
        end
    end
    TriggerClientEvent('qb-phone:client:UpdateMails', src, mails)
        
end)

RegisterNetEvent('qb-phone:server:MentionedPlayer', function(firstName, lastName, TweetMessage)
    for _, src in pairs(vRP.getUsers({})) do
        local Player = vRP.getUserId({src})
        local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {Player})[1]

        if Player ~= nil then
            if (i.firstname == firstName and i.name == lastName) then
                QBPhone.SetPhoneAlerts(Player, 'twitter')
                QBPhone.AddMentionedTweet(Player, TweetMessage)
                TriggerClientEvent('qb-phone:client:GetMentioned', src, TweetMessage, AppAlerts[Player]['twitter'])
            else
                local query1 = '%' .. firstName .. '%'
                local query2 = '%' .. lastName .. '%'
                local result = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE firstname LIKE ? AND name LIKE ?', { query1, query2 })

                if result[1] ~= nil then
                    local MentionedTarget = result[1].citizenid
                    QBPhone.SetPhoneAlerts(MentionedTarget, 'twitter')
                    QBPhone.AddMentionedTweet(MentionedTarget, TweetMessage)
                end
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:CallContact', function(TargetData, CallId, AnonymousCall)
    local src = source
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {vRP.getUserId({src})})[1]
    local Target = GetPlayerByPhone({TargetData.number})
    local Tsrc = vRP.getUserSource({Target})

    if Target ~= nil then
        TriggerClientEvent('qb-phone:client:GetCalled', Tsrc, i.phone, CallId, AnonymousCall)
    end
end)

RegisterNetEvent('qb-phone:server:BillingEmail', function(data, paid)
    for _, src in pairs(vRP.getUsers({})) do
        local target = vRP.getUserId({src})
        local tJob = vRP.getUserGroupByType({target, 'job'})
        local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {target})[1]

        if tJob == data.society then
            if paid then
                local name = '' .. i.firstname .. ' ' .. i.name .. ''
                TriggerClientEvent('qb-phone:client:BillingEmail', src, data, true, name)
            else
                local name = '' .. i.firstname .. ' ' .. i.name .. ''
                TriggerClientEvent('qb-phone:client:BillingEmail', src, data, false, name)
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:UpdateHashtags', function(Handle, messageData)
    if Hashtags[Handle] ~= nil and next(Hashtags[Handle]) ~= nil then
        Hashtags[Handle].messages[#Hashtags[Handle].messages + 1] = messageData
    else
        Hashtags[Handle] = {
            hashtag = Handle,
            messages = {}
        }
        Hashtags[Handle].messages[#Hashtags[Handle].messages + 1] = messageData
    end
    TriggerClientEvent('qb-phone:client:UpdateHashtags', -1, Handle, messageData)
end)

RegisterNetEvent('qb-phone:server:SetPhoneAlerts', function(app, alerts)
    local src = source
    local CitizenId = vRP.getUserId({src})
    QBPhone.SetPhoneAlerts(CitizenId, app, alerts)
end)

RegisterNetEvent('qb-phone:server:DeleteTweet', function(tweetId)
    local Player = vRP.getUserId({source})
    local delete = false
    local TID = tweetId
    local Data = MySQL.scalar.await('SELECT citizenid FROM phone_tweets WHERE tweetId = ?', { TID })
    if Data == Player then
        MySQL.query.await('DELETE FROM phone_tweets WHERE tweetId = ?', { TID })
        delete = true
    end

    if delete then
        for k, _ in pairs(TWData) do
            if TWData[k].tweetId == TID then
                TWData = nil
            end
        end
        TriggerClientEvent('qb-phone:client:UpdateTweets', -1, TWData, nil, true)
    end
end)

RegisterNetEvent('qb-phone:server:UpdateTweets', function(NewTweets, TweetData)
    local src = source
    if Config.Linux then
        MySQL.insert('INSERT INTO phone_tweets (citizenid, firstName, lastName, message, date, url, picture, tweetid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            TweetData.citizenid,
            TweetData.firstName,
            TweetData.lastName,
            TweetData.message,
            TweetData.date,
            TweetData.url:gsub('[%<>\"()\' $]', ''),
            TweetData.picture:gsub('[%<>\"()\' $]', ''),
            TweetData.tweetId
        })
        TriggerClientEvent('qb-phone:client:UpdateTweets', -1, src, NewTweets, TweetData, false)
    else
        MySQL.insert('INSERT INTO phone_tweets (citizenid, firstName, lastName, message, date, url, picture, tweetid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', {
            TweetData.citizenid,
            TweetData.firstName,
            TweetData.lastName,
            TweetData.message,
            TweetData.time,
            TweetData.url:gsub('[%<>\"()\' $]', ''),
            TweetData.picture:gsub('[%<>\"()\' $]', ''),
            TweetData.tweetId
        })
        TriggerClientEvent('qb-phone:client:UpdateTweets', -1, src, NewTweets, TweetData, false)
    end
end)

RegisterNetEvent('qb-phone:server:TransferMoney', function(iban, amount)
    local src = source
    local sender = vRP.getUserId({src})
    local result = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE registration LIKE ?', { iban })

    if result[1] ~= nil then
        local reciever = vRP.getUserSource({result[1].user_id})

        if reciever ~= nil then
            local PhoneItem = vRP.getInventoryItemAmount({sender, Config.Item})

            vRP.giveBankMoney({sender, amount})
            vRP.tryBankPayment({sender, amount})

            if PhoneItem > 0 then
                TriggerClientEvent('qb-phone:client:TransferMoney', reciever, amount, vRP.getBankMoney({result[1].user_id}))
            end
        else
            local RecieverMoney = MySQL.query.await('SELECT * FROM vrp_user_moneys WHERE user_id LIKE ?', { result[1].user_id })
            MySQL.update('UPDATE vrp_user_moneys SET bank = ? WHERE user_id = ?', { RecieverMoney[1].bank + amount, result[1].user_id})
            vRP.tryBankPayment({sender, amount})
        end
    else
        TriggerClientEvent('ef-phone:Notify', src, "This account number doesn't exist!", 'error')
    end
end)

RegisterNetEvent('qb-phone:server:EditContact', function(newName, newNumber, newIban, oldName, oldNumber, _)
    local src = source
    local Player = vRP.getUserId({src})
    
    MySQL.update(
        'UPDATE player_contacts SET name = ?, number = ?, iban = ? WHERE citizenid = ? AND name = ? AND number = ?',
        { newName, newNumber, newIban, Player, oldName, oldNumber })
end)

RegisterNetEvent('qb-phone:server:RemoveContact', function(Name, Number)
    local src = source
    local Player = vRP.getUserId({src})
    MySQL.query('DELETE FROM player_contacts WHERE name = ? AND number = ? AND citizenid = ?',
        { Name, Number, Player })
end)

RegisterNetEvent('qb-phone:server:AddNewContact', function(name, number, iban)
    local src = source
    local Player = vRP.getUserId({src})
    MySQL.insert('INSERT INTO player_contacts (citizenid, name, number, iban) VALUES (?, ?, ?, ?)', { Player, tostring(name), tostring(number), tostring(iban) })
end)

RegisterNetEvent('qb-phone:server:UpdateMessages', function(ChatMessages, ChatNumber, _)
    local src = source
    local SenderData = vRP.getUserId({src})
    local i = MySQL.Sync.fetchAll('SELECT * FROM vrp_user_identities WHERE user_id = ?', {SenderData})[1]
    
    local Player = MySQL.Sync.fetchAll('SELECT * FROM vrp_user_identities WHERE phone LIKE ?', { ChatNumber })
    if Player[1] ~= nil then
        local tI = MySQL.Sync.fetchAll('SELECT * FROM vrp_user_identities WHERE user_id = ?', {Player[1].user_id})[1]
        local TargetSource = vRP.getUserSource({Player[1].user_id})
        local TargetData = Player[1].user_id

        if TargetSource ~= nil then
            local Chat = MySQL.Sync.fetchAll('SELECT * FROM phone_messages WHERE citizenid = ? AND number = ?', { SenderData, ChatNumber })
            if Chat[1] ~= nil then
                -- Update for target
                MySQL.update('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', { json.encode(ChatMessages), TargetData, i.phone })
                -- Update for sender
                MySQL.update('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', { json.encode(ChatMessages), SenderData, tI.phone })
                -- Send notification & Update messages for target
                TriggerClientEvent('qb-phone:client:UpdateMessages', vRP.getUserSource({Player[1].user_id}), ChatMessages, i.phone, false)
            else
                -- Insert for target
                MySQL.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', { TargetData, i.phone, json.encode(ChatMessages) })
                -- Insert for sender
                MySQL.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', { SenderData, tI.phone, json.encode(ChatMessages) })
                -- Send notification & Update messages for target
                TriggerClientEvent('qb-phone:client:UpdateMessages', vRP.getUserSource({Player[1].user_id}), ChatMessages, i.phone, true)
            end
        else
            local Chat = MySQL.Sync.fetchAll('SELECT * FROM phone_messages WHERE citizenid = ? AND number = ?', { SenderData, ChatNumber })
            if Chat[1] ~= nil then
                -- Update for target
                MySQL.update('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', { json.encode(ChatMessages), Player[1].user_id, i.phone })
                -- Update for sender
                Player[1].charinfo = json.decode(Player[1].charinfo)
                MySQL.update('UPDATE phone_messages SET messages = ? WHERE citizenid = ? AND number = ?', { json.encode(ChatMessages), SenderData, Player[1]..phone })
            else
                -- Insert for target
                MySQL.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', { Player[1].citizenid, i.phone, json.encode(ChatMessages) })
                -- Insert for sender
                Player[1].charinfo = json.decode(Player[1].charinfo)
                MySQL.insert('INSERT INTO phone_messages (citizenid, number, messages) VALUES (?, ?, ?)', { SenderData, Player[1].phone, json.encode(ChatMessages) })
            end
        end
    end
end)

RegisterNetEvent('qb-phone:server:AddRecentCall', function(type, data)
    local src = source
    local Ply = vRP.getUserId({src})
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {Ply})[1]
    local Hour = os.date('%H')
    local Minute = os.date('%M')
    local label = Hour .. ':' .. Minute
    TriggerClientEvent('qb-phone:client:AddRecentCall', src, data, label, type)
    local res = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_identities WHERE phone = ?", {data.number})

    if not res then return end

    local Trgt = res[1].user_id
    local tsrc = vRP.getUserSource({Trgt})

    if Trgt ~= nil then
        TriggerClientEvent('qb-phone:client:AddRecentCall', tsrc, {
            name = i.firstname .. ' ' .. i.name,
            number = i.phone,
            anonymous = data.anonymous
        }, label, 'outgoing')
    end
end)

RegisterNetEvent('qb-phone:server:CancelCall', function(ContactData)
    local Ply, src = GetPlayerByPhone({ContactData.TargetData.number})
    if Ply ~= nil then
        TriggerClientEvent('qb-phone:client:CancelCall', src)
    end
end)

RegisterNetEvent('qb-phone:server:AnswerCall', function(CallData)
    local Ply, src = GetPlayerByPhone({CallData.TargetData.number})
    if Ply ~= nil then
        TriggerClientEvent('qb-phone:client:AnswerCall', src)
    end
end)

RegisterNetEvent('qb-phone:server:SaveMetaData', function(MData)
    local src = source
    local user_id = vRP.getUserId({src})
    if not user_id then return end

    local Data = vRP.getUserDataTable({user_id})
    
    
    if Data.metadata == nil then
        Data.metadata = {}
    else
        Data.metadata = json.encode(Data.metadata)
    end
    
    Data.metadata.phone = MData

    vRP.setUData({user_id, 'vRP:datatable', json.encode(Data)})
end)


RegisterNetEvent('qb-phone:server:GiveContactDetails', function(PlayerId)
    local src = source
    local Player = vRP.getUserId({src})
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {Player})[1]

    local SuggestionData = {
        name = {
            [1] = i.firstname,
            [2] = i.name
        },
        number = i.phone,
        bank = i.registration
    }

    TriggerClientEvent('qb-phone:client:AddNewSuggestion', PlayerId, SuggestionData)
end)

RegisterNetEvent('qb-phone:server:AddTransaction', function(data)
    local src = source
    local Player = vRP.getUserId({src})

    MySQL.insert('INSERT INTO crypto_transactions (citizenid, title, message) VALUES (?, ?, ?)', {
        Player,
        data.TransactionTitle,
        data.TransactionMessage
    })
end)

RegisterNetEvent('qb-phone:server:InstallApplication', function(ApplicationData)
    local src = source
    local user_id = vRP.getUserId({src})
    local Data = vRP.getUserDataTable(user_id)
    
    if Data.metadata == nil then
        Data.metadata = {}
    else
        Data.metadata = json.decode(Data.metadata)
    end
    
    if Data.metadata.phonedata == nil then
        Data.metadata.phonedata = { InstalledApps = {} }
    elseif Data.metadata.phonedata.InstalledApps == nil then
        Data.metadata.phonedata.InstalledApps = {}
    end
    
    Data.metadata.phonedata.InstalledApps[ApplicationData.app] = ApplicationData
    
    vRP.setUData({user_id, 'vRP:datatable', json.encode(Data)})

    -- TriggerClientEvent('qb-phone:RefreshPhone', src)
end)


RegisterNetEvent('qb-phone:server:RemoveInstallation', function(App)
    local src = source
    local user_id = vRP.getUserId({src})
    local Data = vRP.getUserDataTable(user_id)
    
    if Data.metadata == nil then
        Data.metadata = {}
    else
        Data.metadata = json.decode(Data.metadata)
    end
    
    if Data.metadata.phonedata == nil then
        Data.metadata.phonedata = { InstalledApps = {} }
    elseif Data.metadata.phonedata.InstalledApps == nil then
        Data.metadata.phonedata.InstalledApps = {}
    end
    
    Data.metadata.phonedata.InstalledApps[App] = nil
    
    vRP.setUData({user_id, 'vRP:datatable', json.encode(Data)})

    -- TriggerClientEvent('qb-phone:RefreshPhone', src)
end)


RegisterNetEvent('qb-phone:server:addImageToGallery', function(image)
    local src = source
    local Player = vRP.getUserId({src})
    MySQL.insert('INSERT INTO phone_gallery (`citizenid`, `image`) VALUES (?, ?)', { Player, image })
end)

RegisterNetEvent('qb-phone:server:getImageFromGallery', function()
    local src = source
    local Player = vRP.getUserId({src})
    local images = MySQL.query.await('SELECT * FROM phone_gallery WHERE citizenid = ? ORDER BY `date` DESC', { Player })
    TriggerClientEvent('qb-phone:refreshImages', src, images)
end)

RegisterNetEvent('qb-phone:server:RemoveImageFromGallery', function(data)
    local src = source
    local Player = vRP.getUserId({src})
    local image = data.image
    MySQL.query('DELETE FROM phone_gallery WHERE citizenid = ? AND image = ?', { Player, image })
end)

RegisterNetEvent('qb-phone:server:sendPing', function(data)
    local src = source

    if src == data then
        TriggerClientEvent('ef-phone:Notify', src, 'You cannot ping yourself', 'error')
    end
end)

-- Command

RegisterCommand('bill', function(src, args)
    local biller = vRP.getUserId({src})
    local billed = tonumber(args[1])

    local billerI = vRP.getUserIdentity({biller})
    local billedI = vRP.getUserIdentity({billed})

    local billerJob = vRP.getUserGroupByType({biller, 'job'})
    local billedJob = vRP.getUserGroupByType({billed, 'job'})

    local amount = tonumber(args[2])

    if billerJob == 'police' or billerJob == 'ambulance' or billerJob == 'mechanic' then
        if billed ~= nil then
            -- if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                    MySQL.insert(
                        'INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (?, ?, ?, ?, ?)',
                        { billed, amount, billerJob, billerI.firstname, biller })
                    TriggerClientEvent('qb-phone:RefreshPhone', vRP.getUserSource({billed}))
                    TriggerClientEvent('ef-phone:Notify', source, 'Invoice Successfully Sent', 'success')
                    TriggerClientEvent('ef-phone:Notify', vRP.getUserSource({billed}), 'New Invoice Received')
                else
                    TriggerClientEvent('ef-phone:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                end
            -- else
            --     TriggerClientEvent('ef-phone:Notify', source, 'You Cannot Bill Yourself', 'error')
            -- end
        else
            TriggerClientEvent('ef-phone:Notify', source, 'Player Not Online', 'error')
        end
    else
        TriggerClientEvent('ef-phone:Notify', source, 'No Access', 'error')
    end
end)


-- Eftertilføjelser -- Kian --

lib.callback.register('ef-phone:fetchJob', function(src)
    local user_id = vRP.getUserId({src})

    return vRP.getUserGroupByType({user_id, 'job'})
end)

lib.callback.register('ef-phone:fetchMetaData', function(src)
    local user_id = vRP.getUserId({src})
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {user_id})[1]
    local Metdata = vRP.getUserDataTable({user_id})

    return MetData
end)

lib.callback.register('ef-phone:fetchMoney', function(src)
    local user_id = vRP.getUserId({src})
    local bank = vRP.getBankMoney({user_id})
    local wallet = vRP.getMoney({user_id})
    local crypto = MySQL.query.await('SELECT * FROM vrp_user_moneys WHERE user_id = ?', {user_id})[1].crypto

    return bank, wallet
end)

lib.callback.register('ef-phone:fetchCharInfo', function(src)
    local user_id = vRP.getUserId({src})
    local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {user_id})[1]

    return i.phone, i.firstname, i.name, i.registration, user_id
end)

lib.callback.register('qb-garages:server:GetPlayerVehicles', function(src)
    local user_id = vRP.getUserId({src})
    local Vehicles = {}
    local result = MySQL.query.await('SELECT * FROM vrp_user_vehicles WHERE user_id = ?', { user_id })
        
    if result[1] then
        for _, v in pairs(result) do
            local VehicleData = QBShared.Vehicles[v.vehicle]

            local VehicleGarage = ''
            --if v.garage ~= nil then
            --    if Config.Garages[v.garage] ~= nil then
            --        VehicleGarage = Config.Garages[v.garage].label
            --    else
            --        VehicleGarage = Lang:t('info.house')
            --    end
            --end

            local stateTranslation
            if v.state == 0 then
                stateTranslation = 'Tilgængelig'
            elseif v.state == 1 then
                stateTranslation = 'Impounded'
            --elseif v.state == 2 then
            --    stateTranslation = Lang:t('status.impound')
            end

            local fullname
            if VehicleData and VehicleData['brand'] then
                fullname = VehicleData['brand'] .. ' ' .. VehicleData['name']
            else
                fullname = VehicleData and VehicleData['name'] or 'Ukendt køretøj'
            end

            Vehicles[#Vehicles + 1] = {
                fullname = fullname,
                brand = VehicleData and VehicleData['brand'] or '',
                model = VehicleData and VehicleData['name'] or '',
                plate = v.vehicle_plate,
                garage = VehicleGarage,
                state = stateTranslation,
                fuel = v.vehicle_fuel,
                engine = v.vehicle_damage,
                body = v.vehicle_damage
            }
        end

        return Vehicles
    else
        return nil
    end
end)

lib.callback.register('ef-phone:fetchOSData', function()
    local currentTime = os.time()
    local dateTable = os.date("*t", currentTime)

    return currentTime, dateTable
end)

function GetPlayerByPhone(phone)
    local res = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_identities WHERE phone = ?", {phone})

    if res then
      local src = vRP.getUserSource({res[1].user_id})
      if src then
        return res[1].user_id, src
      else
        return res[1].user_id
      end
    end
end

-- Housing --
local hcfg = module("vrp","cfg/homes")
local houses = hcfg.homes


lib.callback.register('qb-phone:server:GetPlayerHouses', function(src)
    local user_id = vRP.getUserId({src})
    local res = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_homes WHERE user_id = ?", {user_id})
    local MyHouses = {}
    --print('Debug : id: '.. user_id .. 'res: ', json.encode(res))
    if not res then return {} end

    for k, v in pairs(res) do
        MyHouses[#MyHouses + 1] = {
            name = v.home ..' '.. v.number,
            keyholders = {},
            owner = user_id,
            price = houses[v.home].buy_price,
            label = v.home,
            tier =  houses[v.home].tier,
            garage = false,
        }
    end


    return MyHouses
end)

lib.callback.register('qb-phone:server:MeosGetPlayerHouses', function(src, input)
    local res = MySQL.Sync.fetchAll("SELECT * FROM vrp_user_homes")
    local searchData = {}
    if not res then return end

    for k, v in pairs(res) do
        local i = MySQL.query.await('SELECT * FROM vrp_user_identities WHERE user_id = ?', {v.user_id})[1]
        searchData[#searchData+1] = {
            name = v.home,
            keyholders = {},
            owner = v.user_id,
            price = houses[v.home].buy_price,
            label = v.home,
            tier = houses[v.home].tier,
            garage = false,
            charinfo = {
                account = i.registration,
                phone = i.phone,
                firstname = i.firstname,
                lastname = i.name,
            },
            coords = {
                x = houses[v.home].entry_point[1],
                y = houses[v.home].entry_point[2],
                z = houses[v.home].entry_point[3]
            }
        }
    end

    return searchData
end)

lib.callback.register('qb-phone:server:TransferCid', function(src, NewCid, house)
    local user_id = vRP.getUserId({src})

    --print("User ID: ", user_id)
    --print("NewCid: ", NewCid)
    --print("House: ", house.name)

    local result
    local success, err = pcall(function()
        result = exports.oxmysql:executeSync('SELECT * FROM vrp_user_ids WHERE user_id = ?', { NewCid })
    end)

    if not success then
        --print("Database query failed: ", err)
        return false
    end

    --print("Result: ", json.encode(result))

    if result[1] then
        local updateResult
        success, err = pcall(function()
            updateResult = exports.oxmysql:executeSync('UPDATE vrp_user_homes SET user_id = ? WHERE home = ? AND user_id = ?', { NewCid, house.name, user_id })
        end)

        if not success then
            --print("Database update failed: ", err)
            return false
        end

        --print("Affected Rows: ", updateResult)

        if updateResult.affectedRows > 0 then
            --print("Update Successful")
            return true
        else
            --print("Update Failed")
            return false
        end
    else
        --print("No Result Found")
        return false
    end
end)

lib.callback.register('ef-phone:fetchhcfg', function(src)
    return module("vrp","cfg/homes")
end)

RegisterNetEvent('vRP:playerLeaveGroup', function(user_id, group, gtype)
    local source = vRP.getUserSource({user_id})
    TriggerClientEvent('QBCore:Client:OnJobUpdate', source, {
        name = 'Arbejdsløs',
        onduty = false,
    })
end)

RegisterNetEvent("vRP:playerJoinGroup", function(user_id, group, gtype)
    local source = vRP.getUserSource({user_id})
    TriggerClientEvent('QBCore:Client:OnJobUpdate', source, {
        name = group,
        onduty = false,
    })
end)
