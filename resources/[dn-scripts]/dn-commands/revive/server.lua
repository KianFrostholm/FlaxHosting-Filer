AddEventHandler('chatMessage', function( source, n, msg )
    msg = string.lower( msg )
    
    if ( msg == "/revive" or msg == "/reviveme" ) then 
        CancelEvent() 
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        if vRP.hasPermission({user_id, "staff.revive"}) then
        TriggerClientEvent('revive', source )
        end
    end
end)

--Made by Skovsbøll#3650

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
-- Add an event handler for the 'chatMessage' event
AddEventHandler( 'chatMessage', function( source, n, msg )

    msg = string.lower( msg )
    
    -- Check to see if a client typed in /dv
    if ( msg == "/dv" or msg == "/delveh" ) then 
    
        -- Cancel the chat message event (stop the server from posting the message)
        CancelEvent() 
        
        local user_id = vRP.getUserId({source})
        local player = vRP.getUserSource({user_id})
        if vRP.hasPermission({user_id,"Mekaniker.dv"}) then
        -- Trigger the client event 
        TriggerClientEvent( 'wk:deleteVehicle', source )
        end
    end
end )

--Made by Skovsbøll#3650

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_fixcar")

AddEventHandler('chatMessage', function(source, name, msg)
	if msg == "/fix" then
	  local user_id = vRP.getUserId({source})
	  local player = vRP.getUserSource({user_id})
	  if vRP.hasPermission({user_id,"ledelse.fix"}) then
			TriggerClientEvent('murtaza:fix', source);
			CancelEvent();	  
	  end
	end
end)