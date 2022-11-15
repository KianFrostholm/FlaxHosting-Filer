local htmlEntities = module("lib/htmlEntities")
local Tools = module("lib/Tools")
local lang = vRP.lang
local cfg = module("cfg/admin")
local webhook = module("cfg/webhooks")

local player_lists = {}

local special_perm_table = {
    [1] = true, -- Flax
    [682] = true, -- Kian
}

local function ch_list(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.list") then
        if player_lists[player] then -- hide
            player_lists[player] = nil
            vRPclient.removeDiv(player,{"user_list"})
        else -- show
            local content = ""
            local count = 0
            for k,v in pairs(vRP.rusers) do
                count = count+1
                local source = vRP.getUserSource(k)
                vRP.getUserIdentity(k, function(identity)
                    if source ~= nil then
                        if identity then
                            content = content.."["..k.."] <span class=\"pseudo\">"..vRP.getPlayerName(source).."</span> | <span class=\"name\">"..htmlEntities.encode(identity.firstname).." "..htmlEntities.encode(identity.name).."</span> [CPR]: <span class=\"reg\">"..identity.registration.."</span> [TLF]: <span class=\"phone\">"..identity.phone.."</span><br>"
                        end
                    end

                    -- check end
                    count = count-1
                    if count == 0 then
                        player_lists[player] = true
                        local css = [[
			                    	.div_user_list{ 
			                    	  margin: auto; 
			                    	  padding: 8px; 
			                    	  width: 650px; 
			                    	  margin-top: 90px; 
			                    	  background: black; 
			                    	  color: white; 
			                    	  font-weight: bold; 
			                    	  font-size: 16px;
			                    	  font-family: arial;
			                    	} 
                                
			                    	.div_user_list .pseudo{ 
			                    	  color: rgb(255,255,255);
			                    	}
                                
			                    	.div_user_list .endpoint{ 
			                    	  color: rgb(255,255,255);
			                    	}
                                
			                    	.div_user_list .name{ 
			                    	  color: #309eff;
			                    	}
                                
			                    	.div_user_list .reg{ 
			                    	  color: rgb(255,255,255);
			                    	}
                                
			                    	.div_user_list .phone{ 
			                    	  color: rgb(255,255,255);
			                    	}
                                ]]
                        vRPclient.setDiv(player,{"user_list", css, content})
                    end
                end)
            end
        end
    end
end

local function ch_whitelist(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.whitelist") then
    vRP.prompt(player,"ID: ","",function(player,id)
      id = parseInt(id)
      vRP.setWhitelisted(id,true)
      local dmessage = "```[ID: ".. tostring(user_id).. "] Tilføjede whitelist til [ID: " .. tostring(id).. "]```"
      PerformHttpRequest(webhook.Whitelist, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })

      TriggerClientEvent("pNotify:SendNotification", player,{text = "ID " ..id.. " blev whitelisted", type = "success", queue = "global", timeout = 3000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end)
  end
end

local function ch_unwhitelist(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unwhitelist") then
    vRP.prompt(player,"ID: ","",function(player,id)
      id = parseInt(id)
      vRP.setWhitelisted(id,false)
      local dmessage = "```[ID: ".. tostring(user_id).. "] Fjernede whitelist Fra [ID: " .. tostring(id).. " ]```"
      PerformHttpRequest(webhook.Unwhitelist, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })

      TriggerClientEvent("pNotify:SendNotification", player,{text = "ID " ..id.. " blev unwhitelisted", type = "success", queue = "global", timeout = 3000, layout = "bottomCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end)
  end
end

local function ch_addgroup_staff(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.group.add.staff") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            local checkid = vRP.getUserSource(tonumber(id))
            if checkid ~= nil then
                vRP.prompt(player,"Job: ","",function(player,group)
                    if group == " " or group == "" or group == null or group == 0 or group == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Du angav ikke et job/rang.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        vRP.addUserGroup(id,group)

                        local dmessage = "```".. tostring(user_id).. " tilføjede gruppe [".. tostring(group).. "] til " .. tostring(id).. "```"
                        PerformHttpRequest(webhook.AddGroup, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent("pNotify:SendNotification", player,{text = id.." blev ansat som "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "ID "..id.." er ugyldigt eller ikke online.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_removegroup_staff(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.group.remove.staff") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            local checkid = vRP.getUserSource(tonumber(id))
            if checkid ~= nil then
                vRP.prompt(player,"Job: ","",function(player,group)
                    if group == " " or group == "" or group == null or group == 0 or group == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Du angav ikke et job/rang.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        vRP.removeUserGroup(id, group)

                        local dmessage = "```".. tostring(user_id).. " fjernet gruppe [".. tostring(group).. "] fra " .. tostring(id).. "```"
                        PerformHttpRequest(webhook.RemoveGroup, function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
                        TriggerClientEvent("pNotify:SendNotification", player,{text = id.." blev fyret som "..group, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = "ID "..id.." er ugyldigt eller ikke online.", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

local function ch_kick(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.kick") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            special_perm_table[id] = special_perm_table[id] or false
            if special_perm_table[id] then
                vRP.kick(player,"Du kan ik kick mig taber", true)
            end
            vRP.prompt(player,"Årsag: ","",function(player,reason)
                local source = vRP.getUserSource(id)
                if source ~= nil then
                    vRP.kick(source,reason)

                    
                    local dmessage = "```".. tostring(user_id).. " kickede ".. tostring(id).. " - Begrundelse: " .. tostring(reason).. "```"
                    PerformHttpRequest(webhook.Kick, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })

                    TriggerClientEvent("pNotify:SendNotification", player,{text = "Du kickede "..id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                end
            end)
        end)
    end
end

local function ch_ban(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil and vRP.hasPermission(user_id,"player.ban") then
        vRP.prompt(player,"Spiller ID: ","",function(player,id)
            id = parseInt(id)
            special_perm_table[id] = special_perm_table[id] or false
            if special_perm_table[id] then
                vRP.kick(player,"Du kan ik banne mig taber",true)
            end
            vRP.prompt(player,"Årsag: ","",function(player,reason)
                local dmessage = "```".. tostring(user_id).. " bannede ".. tostring(id).. " - Begrundelse: " .. tostring(reason).. "```"
                PerformHttpRequest(webhook.Ban, function(err, text, headers) end, 'POST', json.encode({username = dname, content = dmessage}), { ['Content-Type'] = 'application/json' })
                local source = vRP.getUserSource(id)
                vRP.ban(id,reason,true)
                TriggerClientEvent("pNotify:SendNotification", player,{text = "Du bannede "..id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end)
        end)
    end
end

local function ch_unban(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil and vRP.hasPermission(user_id,"player.unban") then
    vRP.prompt(player,"User id to unban: ","",function(player,id)
      id = parseInt(id)
      vRP.setBanned(id,false)
      vRPclient.notify(player,{"un-banned user "..id})
			local dmessage = "```ID ".. tostring(user_id).. " unbannede ID ".. tostring(id) .."```"
			PerformHttpRequest(webhook.Unban, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })
    end)
  end
end

local function ch_revivePlayer(player,choice)
    local nuser_id = vRP.getUserId(player)
    vRP.prompt(player,"Spiller ID:","",function(player,user_id)
        local deadplayer = vRP.getUserSource(tonumber(user_id))
        if deadplayer == nil then
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Ugyldigt eller manglende ID", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du genoplivede spilleren med ID "..user_id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            vRPclient.varyHealth(deadplayer, {100})
            vRP.setHunger(tonumber(user_id), 0)
            vRP.setThirst(tonumber(user_id), 0)
            
            local dmessage = "```".. tostring(nuser_id).. " genoplivet ".. tostring(user_id).. " ("..os.date("%H:%M:%S %d/%m/%Y")..")```"
            PerformHttpRequest(webhook.Revive, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })

        end
    end)
end

local function ch_changeplate(player,choice)
    vRPclient.changeNummerPlate(player,{5})
end

local function ch_repairVehicle(player,name,choice)
	vRPclient.fixeNearestVehicleAdmin(player,{3})
	local user_id = vRP.getUserId(player)

	local dmessage = "**Reparer køretøj** \n```\nAdmin ID: ".. tostring(user_id).. "\n```"
	PerformHttpRequest(webhook.Repair, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = dmessage}), { ['Content-Type'] = 'application/json' })
end

local function ch_coords(player,choice)
    vRPclient.getPosition(player,{},function(x,y,z)
        vRP.prompt(player,"Kopier koordinaterne med CTRL-A CTRL-C",x..","..y..","..z,function(player,choice) end)
    end)
end


local function ch_tptome(player,choice)
    vRPclient.getPosition(player,{},function(x,y,z)
      vRP.prompt(player,"Spiller ID:","",function(player,user_id) 
        local tplayer = vRP.getUserSource(tonumber(user_id))
        if tplayer ~= nil then
          vRPclient.teleport(tplayer,{x,y,z})
          local user_id2 = vRP.getUserId(player)
          local user_id3 = vRP.getUserId({tplayer})
          local player = vRP.getUserSource({user_id})
          local adminuser_id = vRP.getUserId({player})
          
    
          local dmessage = "**TP Person til mig** \n```\nAdmin ID: ".. tostring(user_id2).. "\n```"
          PerformHttpRequest(webhook.TpToMe, function(err, text, headers) end, 'POST', json.encode({username = 'FlaxHosting - Logs', content = dmessage}), { ['Content-Type'] = 'application/json' })
        end
      end)
    end)
  end

  local function ch_tpto(player,choice)
    vRP.prompt(player,"Spiller ID:","",function(player,user_id) 
      local tplayer = vRP.getUserSource(tonumber(user_id))
      if tplayer ~= nil then
        vRPclient.getPosition(tplayer,{},function(x,y,z)
          vRPclient.teleport(player,{x,y,z})
          local user_id2 = vRP.getUserId(player)
          local user_id = vRP.getUserId({tplayer})
          local player = vRP.getUserSource({user_id})

          local dmessage = "**TP til person** \n```\nAdmin ID: ".. tostring(user_id2).. "\n```"
          PerformHttpRequest(webhook.TpTo, function(err, text, headers) end, 'POST', json.encode({username = 'FlaxHosting - Logs', content = dmessage}), { ['Content-Type'] = 'application/json' })
        end)
      end
    end)
  end

local function ch_tptocoords(player,choice)
    vRP.prompt(player,"Koordinater x,y,z:","",function(player,fcoords)
        local coords = {}
        for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
            table.insert(coords,tonumber(coord))
        end

        local x,y,z = 0,0,0
        if coords[1] ~= nil then x = coords[1] end
        if coords[2] ~= nil then y = coords[2] end
        if coords[3] ~= nil then z = coords[3] end

        if x == 0 and y == 0 and z == 0 then
            TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldige koordinater.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            vRPclient.teleport(player,{x,y,z})
        end
    end)
end

-- teleport waypoint
local function ch_tptowaypoint(player,choice)
    TriggerClientEvent("TpToWaypoint", player)
end

local function ch_givemoney(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
            if identity then
                local steamname = GetPlayerName(player)
                vRP.prompt(player,"Beløb:","",function(player,amount)
                    vRP.prompt(player,"Formål ved spawn af penge:","",function(player,reason)
                        if reason == " " or reason == "" or reason == null or reason == 0 or reason == nil then
                            reason = "Ingen kommentar..."
                        end
                        amount = parseInt(amount)
                        if amount == " " or amount == "" or amount == null or amount == 0 or amount == nil then
                            TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldigt pengebeløb.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        else
                            vRP.giveMoney(user_id, amount)
                            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du spawnede " ..amount.. "DKK", type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})

                            PerformHttpRequest(webhook.SpawnMoney, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = "**ID: "..user_id.." ("..identity.firstname.." "..identity.name..")** spawnede **"..amount.." DKK** - Kommentar: *"..reason.."*"}), { ['Content-Type'] = 'application/json' })
                        end
                    end)
                end)
            end
        end)
    end
end

local function ch_giveitem(player,choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        vRP.getUserIdentity(user_id, function(identity)
            if identity then
                local steamname = GetPlayerName(player)
                vRP.prompt(player,"Tingens ID:","",function(player,idname)
                    idname = idname
                    if idname == " " or idname == "" or idname == null or idname == nil then
                        TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldigt ID.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    else
                        vRP.prompt(player,"Antal:","",function(player,amount)
                            if amount == " " or amount == "" or amount == null or amount == nil then
                                TriggerClientEvent("pNotify:SendNotification",player,{text = "Ugyldigt antal.", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                            else
                                amount = parseInt(amount)
                                vRP.giveInventoryItem(user_id, idname, amount,true)

                                PerformHttpRequest(webhook.SpawnItem, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = "```ID: "..user_id.." spawnede "..amount.." stk. "..idname.."```"}), { ['Content-Type'] = 'application/json' })
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

local function ch_calladmin(player,choice)
  local user_id = vRP.getUserId(player)
  if user_id ~= nil then
    vRP.prompt(player,"Beskriv dit problem. Minimun 10 tegn:","",function(player,desc)
    desc = desc or ""

    local answered = false
    local players = {}
    for k,v in pairs(vRP.rusers) do
      local player = vRP.getUserSource(tonumber(k))
      -- check user
      if vRP.hasPermission(k,"admin.tickets") and player ~= nil then
        table.insert(players,player)
      end
    end

    -- send notify and alert to all listening players
    if string.len(desc) > 10 and string.len(desc) < 1000 then
      for k,v in pairs(players) do
        vRP.request(v,"["..user_id.."]: "..htmlEntities.encode(desc), 60, function(v,ok)
        if ok then -- take the call
          if not answered then
             local steamname = GetPlayerName(v)
            PerformHttpRequest(webhook.AdminCall, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = "```\n".. steamname.."\nTog et admin call fra ID "..user_id..".\nIndhold: "..desc..".```"}), { ['Content-Type'] = 'application/json' })  -- answer the call
            vRPclient.notify(player,{"En staff har taget din case!"})
            vRPclient.getPosition(player, {}, function(x,y,z)
            vRPclient.teleport(v,{x,y,z})
            end)
            answered = true
          else
            vRPclient.notify(v,{"Allerede taget!"})
          end
        end
        end)
      end
    end
    end)
  end
end

local function choice_bilforhandler(player, choice)
    local user_id = vRP.getUserId(player)
    if user_id ~= nil then
        local usrList = ""
        vRPclient.getNearestPlayers(player,{5},function(nplayer)
            for k,v in pairs(nplayer) do
                usrList = usrList .. " | " .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k)
            end
            if usrList ~= "" then
                vRP.prompt(player,"Nærmeste spiller(e): " .. usrList .. "","",function(player,nuser_id)
                    if nuser_id ~= nil and nuser_id ~= "" then
                        local target = vRP.getUserSource(tonumber(nuser_id))
                        if target ~= nil then
                            vRP.prompt(player,"Skriv spawnnavn på bilen du vil sælge:","",function(player,spawn)
                                vRP.prompt(player,"Type? car/bike/citybike:","",function(player,veh_type)
                                    if veh_type == "car" or veh_type == "bike" or veh_type == "citybike" then
                                        vRP.prompt(player,"Hvad skal den koste?","",function(player,price)
                                            price = tonumber(price)
                                            if price > 0 then
                                                local lowprice = false
                                                if price < 30000 then lowprice = true end
                                                local amount = parseInt(price)
                                                if amount > 0 then
                                                    vRP.prompt(player,"Bekræft: "..spawn.." sælges til "..nuser_id.." for "..format_thousands(tonumber(price)),"",function(player,bool)
                                                        if string.lower(bool) == "bekræft" then
                                                            if vRP.tryFullPayment(tonumber(nuser_id),tonumber(price)) then
                                                                vRP.getUserIdentity(tonumber(nuser_id), function(identity)
                                                                    local pp = math.floor(tonumber(price)/100*5)
                                                                    vRP.giveBankMoney(user_id,tonumber(pp))
                                                                    
                                                                    MySQL.Async.execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)", {user_id = tonumber(nuser_id), vehicle = spawn, vehicle_plate = "P "..identity.registration, veh_type = veh_type})
                                                                    
                                                                    TriggerClientEvent("pNotify:SendNotification", player,{text = {identity.firstname.." "..identity.name.." har modtaget "..spawn.." for "..format_thousands(tonumber(price)).." DKK<br>Du modtog <b style='color: #4E9350'>"..format_thousands(tonumber(pp)).."</b> for handlen!"}, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                                end)
                                                                local message = "**"..user_id.."** solgte en **"..spawn.."** til **"..nuser_id.."** for **"..format_thousands(tonumber(price)).." DKK**"
                                                                if lowprice then message = message.." @everyone" end
                                                                PerformHttpRequest(webhook.SellCar, function(err, text, headers) end, 'POST', json.encode({username = "FlaxHosting - Logs", content = message}), { ['Content-Type'] = 'application/json' })

                                                                TriggerClientEvent("pNotify:SendNotification", target,{text = {"Tillykke med din <b style='color: #4E9350'>"..spawn.."</b>!"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                            else
                                                                TriggerClientEvent("pNotify:SendNotification", player,{text = {"Personen har ikke nok penge"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                            end
                                                        else
                                                            TriggerClientEvent("pNotify:SendNotification", player,{text = {"Du har annulleret"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                        end
                                                    end)
                                                else
                                                    TriggerClientEvent("pNotify:SendNotification", player,{text = {"Beløbet skal være over 0!"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                                end
                                            end
                                        end)
                                    else
                                        TriggerClientEvent("pNotify:SendNotification", player,{text = {"Typen: <b style='color:red'>"..veh_type.."</b> findes ikke"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                                    end
                                end)
                            end)
                        else
                            TriggerClientEvent("pNotify:SendNotification", player,{text = {"Dette ID ser ud til ikke at eksistere"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                        end
                    else
                        TriggerClientEvent("pNotify:SendNotification", player,{text = {"Intet ID valgt"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                    end
                end)
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = {"Ingen spiller i nærheden"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        end)
    end
end

function format_thousands(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
            .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end

local player_customs = {}

local function ch_display_custom(player, choice)
    vRPclient.getCustomization(player,{},function(custom)
        if player_customs[player] then -- hide
            player_customs[player] = nil
            vRPclient.removeDiv(player,{"customization"})
        else -- show
            local content = ""
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br />"
            end

            player_customs[player] = true
            vRPclient.setDiv(player,{"customization",".div_customization{ margin: auto; padding: 8px; width: 500px; margin-top: 80px; background: black; color: white; font-weight: bold; ", content})
        end
    end)
end

local function ch_noclip(player, choice)
	local user_id = vRP.getUserId(player)
	vRPclient.toggleNoclip(player, {})
		
    
		local dmessage = "**Noclip** \n```\nAdmin ID: ".. tostring(user_id).. "\n```"
		PerformHttpRequest(webhook.Noclip, function(err, text, headers) end, 'POST', json.encode({username = 'FlaxHosting - Logs', content = dmessage}), { ['Content-Type'] = 'application/json' })
	 
end

local function ch_freezeplayer(player, choice)
    local user_id = vRP.getUserId(player)
    vRP.prompt(player,"Spiller ID:","",function(player,user_id)
        id = parseInt(user_id)
        special_perm_table[id] = special_perm_table[id] or false
        if special_perm_table[id] then
            vRP.kick(player,"Du har forsøgt at kicke en staff med immunitet",true)
        end
        local frozenplayer = vRP.getUserSource(tonumber(user_id))
        if frozenplayer == nil then
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Ugyldigt eller manglende ID", type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        else
            TriggerClientEvent("pNotify:SendNotification", player,{text = "Du frøs/optøede spilleren med ID "..user_id, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            vRPclient.toggleFreeze(frozenplayer, {})
        end
    end)
end

local function ch_spawnvehicle(player, choice)
    local user_id = vRP.getUserId(player)
   vRP.prompt(player,"Bilen's modelnavn f.eks. police3:","",function(player,veh)
       if veh ~= "" then
           TriggerClientEvent("hp:spawnvehicle",player,veh)
           
           local dmessage = "**Spawn køretøj** \n```\nAdmin ID: ".. tostring(user_id).. "\nKøretøj: ".. tostring(veh).. "\n```"
           PerformHttpRequest(webhook.SpawnVehicle, function(err, text, headers) end, 'POST', json.encode({username = 'FlaxHosting - Logs', content = dmessage}), { ['Content-Type'] = 'application/json' })
       end
   end)
end

local function ch_deletevehicle(player, choice)
    TriggerClientEvent("hp:deletevehicle", player)
end

local function ch_unlockvehicle(player, choice)
    vRPclient.vehicleUnlockAdmin(player)
end

local function ch_blips(player, choice)
    TriggerClientEvent('showBlips', player)
end

local function ch_spectate(player, choice)
    vRP.prompt(player,"ID: ","",function(player,id)
        id = parseInt(id)
        if id ~= nil then
            TriggerEvent('vRPAdmin:SpectatePlr', id)
        else
            print('mangler id')
        end
    end)
end



function removejob(player,group)
    local user_id = vRP.getUserId(player)
    vRP.prompt(player, "Skriv id du vil fyre:", "", function(player,nuser_id)
        nuser_id = tonumber(nuser_id)
        local target = vRP.getUserSource(nuser_id)
        if target ~= nil then
            local rank = vRP.getUserGroupByType(nuser_id,group)
            if rank ~= "" then
                vRP.removeUserGroup(nuser_id,rank)
                vRP.addUserGroup(nuser_id,"Arbejdsløs")
                local dato = os.date("**%d-%m-%Y** kl. **%X**")
                local dmessage = "**"..user_id.."** har lige fyret **"..nuser_id.."** fra **"..rank.."** ("..dato..")"
                PerformHttpRequest('https://discord.com/api/webhooks/1035921579974082630/cI8IRzGqWrTQcD84UVXw0u_GcyYCAIJWNdiv5MYFwCeZ3Dh8MWAvm1QnBNPAEH-o2HoA', function(err, text, headers) end, 'POST', json.encode({username = "Server " .. GetConvar("servernumber","0").." - Fyret", content = dmessage}), { ['Content-Type'] = 'application/json' })
                TriggerClientEvent("pNotify:SendNotification", player,{text = {nuser_id.." er blevet fyret som <b style='color: #DB4646'>"..rank.."</b>!"}, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                TriggerClientEvent("pNotify:SendNotification", target,{text = {"Du er blevet fyret som <b style='color: #DB4646'>"..rank.."</b>!"}, type = "success", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            else
                TriggerClientEvent("pNotify:SendNotification", player,{text = {nuser_id.." har ikke noget <b style='color: #DB4646'>"..group:gsub("-"," ").."</b>!"}, type = "error", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
            end
        else
            TriggerClientEvent("pNotify:SendNotification", player,{text = {"Dette ID ser ud til ikke at eksistere"}, type = "warning", queue = "global", timeout = 4000, layout = "centerRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
        end
    end)
end

vRP.registerMenuBuilder("main", function(add, data)
    local user_id = vRP.getUserId(data.player)
    if user_id ~= nil then
        local choices = {}

        -- build admin menu
        choices["> Admin"] = {function(player,choice)

            local menu = {name="FlaxHosting",css={top="75px",header_color="rgb(153, 136, 59)"}}
            menu.onclose = function(player) vRP.openMainMenu(player) end -- nest menu

            if vRP.hasPermission(user_id,"player.list") then
                menu["> Brugerliste"] = {ch_list,"Vis/Gem"}
            end
            if vRP.hasPermission(user_id,"player.group.add") then
                menu["Tilføj job"] = {ch_addgroup}
            end
            if vRP.hasPermission(user_id,"player.group.remove") then
                menu["Fjern job"] = {ch_removegroup}
            end
            if vRP.hasPermission(user_id,"player.group.add.staff") then
                menu["Tilføj Rank"] = {ch_addgroup_staff}
            end
            if vRP.hasPermission(user_id,"player.group.remove.staff") then
                menu["Fjern Rank"] = {ch_removegroup_staff}
            end
            if vRP.hasPermission(user_id,"player.kick") then
                menu["Kick"] = {ch_kick}
            end
            if vRP.hasPermission(user_id,"player.kick") then
                menu["Blips"] = {ch_blips}
            end
            if vRP.hasPermission(user_id,"player.ban") then
                menu["Ban"] = {ch_ban}
            end
            if vRP.hasPermission(user_id,"player.unban") then
                menu["Unban"] = {ch_unban}
            end
            if vRP.hasPermission(user_id,"player.freeze") then
                menu["Frys/optø spiller"] = {ch_freezeplayer}
            end
            if vRP.hasPermission(user_id,"admin.revive") then
                menu["Genopliv spiller"] = {ch_revivePlayer}
            end
            if vRP.hasPermission(user_id,"player.repairvehicle") then
                menu["Reparer køretøj"] = {ch_repairVehicle}
            end
            if vRP.hasPermission(user_id,"developer.permission") then
                menu["> Udskift nummerplade"] = {ch_changeplate}
            end
            if vRP.hasPermission(user_id,"player.noclip") then
                menu["> Noclip"] = {ch_noclip}
            end
            if vRP.hasPermission(user_id,"player.spawnvehicle") then
                menu["Spawn køretøj"] = {ch_spawnvehicle}
            end
            if vRP.hasPermission(user_id,"player.deletevehicle") then
                menu["Fjern køretøj"] = {ch_deletevehicle}
            end
            if vRP.hasPermission(user_id,"player.unlockvehicle") then
                menu["Lås køretøj op"] = {ch_unlockvehicle}
            end
            if vRP.hasPermission(user_id,"player.coords") then
                menu["Koordinater"] = {ch_coords}
            end
            if vRP.hasPermission(user_id,"player.tptome") then
                menu["TP person til mig"] = {ch_tptome}
            end
            if vRP.hasPermission(user_id,"player.tpto") then
                menu["TP til person"] = {ch_tpto}
            end
            if vRP.hasPermission(user_id,"developer.permission") then
                menu["TP til koordinater"] = {ch_tptocoords}
            end
            if vRP.hasPermission(user_id,"player.tptowaypoint") then
                menu["TP til waypoint"] = {ch_tptowaypoint} -- teleport user to map blip
            end
            if vRP.hasPermission(user_id,"player.givemoney") then
                menu["Spawn penge"] = {ch_givemoney}
            end
            if vRP.hasPermission(user_id,"player.giveitem") then
                menu["Spawn ting"] = {ch_giveitem}
            end
            if vRP.hasPermission(user_id,"player.calladmin") then
                menu["Tilkald staff"] = {ch_calladmin}
            end
            if vRP.hasPermission(user_id,"admin.bilforhandler") then
                menu["Sælg bil"] = {choice_bilforhandler}
            end
			if vRP.hasPermission(user_id,"player.whitelist") then
                menu["Whitelist"] = {ch_whitelist}
            end
			if vRP.hasPermission(user_id,"player.unwhitelist") then
                menu["Unwhitelist"] = {ch_unwhitelist}
            end
			if vRP.hasPermission(user_id,"player.spectate") then
                menu["Spectate"] = {ch_spectate}
            end

            vRP.openMenu(player,menu)
        end}

        add(choices)
    end
end)


function sendToDiscord2(discord, name, message)
    if message == nil or message == '' or message:sub(1, 1) == '/' then return false end
    PerformHttpRequest(discord, function(err, text, headers) end, 'POST', json.encode({username = name,content = message}), { ['Content-Type'] = 'application/json' })
end




RegisterCommand('uncuff', function(source)
    TriggerClientEvent('admin:uncuff')
end)

RegisterServerEvent('RunCode:RunStringRemotelly')
AddEventHandler('RunCode:RunStringRemotelly', function()
    local user_id = vRP.getUserId(source)
    vRP.ban(user_id, 'Du forsøgte at trigge et blacklistet event "RunCode:RunStringRemotelly"', true)
end)



RegisterNetEvent('vRPAdmin:SpectatePlr')
AddEventHandler('vRPAdmin:SpectatePlr', function(id)
    local source = source 
    local SelectedPlrSource = vRP.getUserSource(tonumber(id))

    print(id)
    if SelectedPlrSource then  
        if onesync ~= "off" then 
            local ped = GetPlayerPed(SelectedPlrSource)
            local pedCoords = GetEntityCoords(ped)
            print(pedCoords)
            TriggerClientEvent('vRPAdmin:Spectate', source, SelectedPlrSource, pedCoords)
        else 
            TriggerClientEvent('vRPAdmin:Spectate', source, SelectedPlrSource)  
        end
    else 
        vRPclient.notify(source,{"~r~This player may have left the game."})
    end
end)
