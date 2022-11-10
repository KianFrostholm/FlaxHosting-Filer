local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_dmvschool")

--[[LANG]]--
local Lang = module("vrp", "lib/Lang")
local cfg = module("vrp", "cfg/base")
local lang = Lang.new(module("vrp", "cfg/lang/"..cfg.lang) or {})


RegisterServerEvent("dmv:success")
AddEventHandler("dmv:success", function()
  local user_id = vRP.getUserId({source})
  if user_id ~= nil then
    MySQL.Async.execute("UPDATE vrp_users SET DmvTest='1' WHERE id = @id", {id = user_id})
    PerformHttpRequest('https://discord.com/api/webhooks/1037394990336319518/A6wE_FPjL-e4kq_dOw2kjbqNp2T8y-kVeaqL846pNnRwYYKQQHSwICHyoCQOZm7n2GwK', function(err, text, headers) end, 'POST', json.encode({username = 'Unknown - Logs', content = 'ID: '..user_id..' modtog kørekort'}), {['Content-Type'] = 'application/json'})
  else
      print('id fejl')
  end
end)

RegisterServerEvent("dmv:ttcharge")
AddEventHandler("dmv:ttcharge", function()
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  if vRP.tryFullPayment({user_id,2500}) then
        TriggerClientEvent('dmv:startttest',player)
  else
    TriggerClientEvent("pNotify:SendNotification", player,{text ="Du har ikke råd.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
  end
end)

RegisterServerEvent("dmv:ptcharge")
AddEventHandler("dmv:ptcharge", function()
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  if vRP.tryFullPayment({user_id,5000}) then
        TriggerClientEvent('dmv:startptest',player)
  else
      TriggerClientEvent("pNotify:SendNotification", player,{text ="Du har ikke råd.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
  end
end)

RegisterServerEvent("dmv:buycharge")
AddEventHandler("dmv:buycharge", function()
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  if vRP.tryFullPayment({user_id,10000}) then
        TriggerClientEvent('dmv:buylicense',player)
  else
      TriggerClientEvent("pNotify:SendNotification", player,{text ="Du har ikke råd.", type = "error", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
  end
end)




function vRP.getDriverLicenses(user_id, cbr)
  local task = Task(cbr)
 
  MySQL.Async.fetchAll('SELECT * FROM vrp_users WHERE id = @user_id', {user_id = user_id}, function(rows, affected)
    if #rows > 0 then
      if rows[1] ~= nil and rows[1].DmvTest ~= nil then
        task({rows[1]})
      else
        task()
      end
    else
      task()
    end
  end)
end
function vRP.getDriverLicenses2(nuser_id, cbr)
  local task = Task(cbr)
  MySQL.Async.fetchAll('SELECT * FROM vrp_users WHERE id = @nuser_id', {nuser_id = nuser_id}, function(rows, affected)
    task({rows[1]})
  end)
end

RegisterServerEvent("dmv:LicenseStatus")
AddEventHandler("dmv:LicenseStatus", function()
  local player = source
  local user_id = vRP.getUserId({source})
  local driverlicense = ""
  vRP.getDriverLicenses(user_id, function(license)
    if license ~= nil then
      driverlicense = license.DmvTest
    end
              
    if driverlicense == 1 then
      TriggerClientEvent('dmv:CheckLicStatusNon',player)
    elseif driverlicense == 2 then
      TriggerClientEvent('dmv:CheckLicStatusTaken',player)
    elseif driverlicense == 3 then
      TriggerClientEvent('dmv:CheckLicStatusHas',player)
    else
      TriggerClientEvent('dmv:CheckLicStatusNon',player)
    end
  end)
end)

--[[POLICE MENU]]--
local choice_asklc = {function(player,choice)
  vRPclient.getNearestPlayer(player,{10},function(nplayer)
    local nuser_id = vRP.getUserId({nplayer})
    if nuser_id ~= nil then
      -- vRPclient.notify(player,{"Spørger om kørekort"})
    TriggerClientEvent("pNotify:SendNotification", player,{text ="Spørger om kørekort.", type = "info", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
      vRP.request({nplayer,"Vil du vise dit kørekort?",15,function(nplayer,ok)
        if ok then
          vRP.getUserIdentity({nuser_id, function(identity)
            if identity then
              -- display identity and business
              local name = identity.name
              local firstname = identity.firstname
              local age = identity.age
              local registration = identity.registration
              local driverlicense = ""
              
              vRP.getDriverLicenses2(nuser_id, function(license)
           		 driverlicense = license.DmvTest

                if driverlicense == 1 then
                  driverlicense = "Ja"
                elseif driverlicense == 2 then
                  driverlicense = "Frataget"
                else
                  driverlicense = "Nej"
                end

                local content = "<b>Fornavn</b>: " .. firstname .. "<br /><b>Efternavn</b>: " .. name .. "<br /><b>Alder</b>: " .. age .. " år<br /><b>CPR</b>: " .. registration .. "-"..nuser_id.."<br /><b>Kørekort</b>: " .. driverlicense
                vRPclient.setDiv(player,{"police_identity",".div_police_identity{ background-color: rgba(0,0,0,0.75); color: white; font-family: Roboto; width: 500px; padding: 10px; margin: auto; margin-top: 150px; }",content})
                -- request to hide div
                vRP.request({player, lang.police.menu.askid.request_hide(), 1000, function(player,ok)
                  vRPclient.removeDiv(player,{"police_identity"})
                end})
             end)
            end
          end})
        else
          -- vRPclient.notify(player,{lang.common.request_refused()})
      TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.request_refused()}, type = "info", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
        end
      end})
    else
      -- vRPclient.notify(player,{lang.common.no_player_near()})
    TriggerClientEvent("pNotify:SendNotification", player,{text = {lang.common.no_player_near()}, type = "info", queue = "global",timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"},killer = true})
    end
  end)
end, "Tjek kørekort på nærmeste spiller."}

--[[vRP.registerMenuBuilder({"Politiregister", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    -- build police kørekort menu
    if vRP.hasPermission({user_id,"police.drag"}) then
       choices["Tjek kørekort"] = choice_asklc
    end
  
    add(choices)
  end
end})]]--

vRP.registerMenuBuilder({"police", function(add, data)
  local player = data.player

  local user_id = vRP.getUserId({player})
  if user_id ~= nil then
    local choices = {}

    -- build police menu
    if vRP.hasPermission({user_id,"police.askid"}) then
       choices["Tjek kørekort"] = choice_asklc
    end
  
    add(choices)
  end
end})