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